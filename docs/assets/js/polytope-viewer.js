/*
 * Mounts a rotatable three.js convex-hull view into every
 * <div class="polytope-viewer" data-shape="..."> found on a page.
 * Vertex data comes from window.PGPolytopes (polytope-data.js);
 * three.js itself is loaded lazily from a CDN via dynamic import so
 * pages without a viewer pay no cost.
 */
(function () {
  "use strict";

  const THREE_VERSION = "0.160.0";
  const THREE_URL = `https://unpkg.com/three@${THREE_VERSION}/build/three.module.js`;
  const ORBIT_URL = `https://unpkg.com/three@${THREE_VERSION}/examples/jsm/controls/OrbitControls.js`;
  const HULL_URL = `https://unpkg.com/three@${THREE_VERSION}/examples/jsm/geometries/ConvexGeometry.js`;

  let modulesPromise = null;
  function loadModules() {
    if (!modulesPromise) {
      modulesPromise = Promise.all([import(THREE_URL), import(ORBIT_URL), import(HULL_URL)]);
    }
    return modulesPromise;
  }

  const mounted = new WeakSet();

  function mountViewer(container, THREE, OrbitControls, ConvexGeometry) {
    if (mounted.has(container)) return;
    mounted.add(container);

    const shape = container.dataset.shape;
    const getVertices = window.PGPolytopes && window.PGPolytopes[shape];
    if (!getVertices) {
      console.warn("polytope-viewer: unknown shape", shape);
      return;
    }

    const width = container.clientWidth || 400;
    const height = container.clientHeight || 320;

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(45, width / height, 0.1, 100);
    camera.position.set(3.2, 2.4, 3.6);

    const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
    renderer.setSize(width, height);
    container.appendChild(renderer.domElement);

    const controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.08;
    controls.autoRotate = true;
    controls.autoRotateSpeed = 1.0;
    controls.addEventListener("start", () => {
      controls.autoRotate = false;
    });

    scene.add(new THREE.AmbientLight(0xffffff, 0.65));
    const key = new THREE.DirectionalLight(0xffffff, 0.9);
    key.position.set(4, 5, 3);
    scene.add(key);
    const rim = new THREE.DirectionalLight(0x8899ff, 0.5);
    rim.position.set(-4, -2, -3);
    scene.add(rim);

    const rawPoints = getVertices();
    let maxR = 0;
    for (const p of rawPoints) {
      const r = Math.sqrt(p[0] * p[0] + p[1] * p[1] + p[2] * p[2]);
      if (r > maxR) maxR = r;
    }
    const scale = maxR > 0 ? 1.5 / maxR : 1;
    const points = rawPoints.map((p) => new THREE.Vector3(p[0] * scale, p[1] * scale, p[2] * scale));

    const group = new THREE.Group();

    const hullGeom = new ConvexGeometry(points);
    const faceMat = new THREE.MeshStandardMaterial({
      color: 0xc98a2c,
      transparent: true,
      opacity: 0.35,
      metalness: 0.1,
      roughness: 0.6,
      side: THREE.DoubleSide,
    });
    group.add(new THREE.Mesh(hullGeom, faceMat));

    const edgeGeom = new THREE.EdgesGeometry(hullGeom, 1);
    group.add(new THREE.LineSegments(edgeGeom, new THREE.LineBasicMaterial({ color: 0xf4e3c1 })));

    const vertexGeom = new THREE.SphereGeometry(0.035, 16, 16);
    const vertexMat = new THREE.MeshBasicMaterial({ color: 0xe3a94a });
    for (const p of points) {
      const s = new THREE.Mesh(vertexGeom, vertexMat);
      s.position.copy(p);
      group.add(s);
    }

    scene.add(group);

    let frameId;
    function animate() {
      frameId = requestAnimationFrame(animate);
      controls.update();
      renderer.render(scene, camera);
    }
    animate();

    function onResize() {
      const w = container.clientWidth;
      const h = container.clientHeight;
      if (!w || !h) return;
      camera.aspect = w / h;
      camera.updateProjectionMatrix();
      renderer.setSize(w, h);
    }
    if (window.ResizeObserver) {
      new ResizeObserver(onResize).observe(container);
    } else {
      window.addEventListener("resize", onResize);
    }
  }

  function mountAll() {
    const containers = document.querySelectorAll(".polytope-viewer[data-shape]");
    if (!containers.length) return;
    loadModules()
      .then(([THREE, OrbitControlsMod, ConvexGeometryMod]) => {
        containers.forEach((el) =>
          mountViewer(el, THREE, OrbitControlsMod.OrbitControls, ConvexGeometryMod.ConvexGeometry)
        );
      })
      .catch((err) => console.error("polytope-viewer: failed to load three.js", err));
  }

  if (window.document$ && typeof window.document$.subscribe === "function") {
    // MkDocs Material's instant-navigation observable — fires on every
    // page render, including client-side navigations.
    document$.subscribe(mountAll);
  } else {
    document.addEventListener("DOMContentLoaded", mountAll);
  }
})();
