---
layout: article
sidebar:
  nav: docs-en
---

* **Definition**

    Unit hypercube $K_n^{(0)}$ is the cartesian product of $n$ unit segments: $K_n^{(0)}=[0,1]^n$.

* **Properties**

  * F-vector ([OEIS A062715](https://oeis.org/A062715))

    | Simplex | Dimension | (-1)-faces | 0-faces | 1-faces | 2-faces | 3-faces | 4-faces | 5-faces | 6-faces |
    |:-------:|:---------:|:----------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
    | $K_0$   |     0     |  1         |  1      | 0       |    0    |    0    |   0     |    0    |   0     |
    | $K_1$   |     1     |  1         |  2      | 1       |    0    |    0    |   0     |    0    |   0     |
    | $K_2$   |     2     |  1         |  4      | 4       |    1    |    0    |   0     |    0    |   0     |
    | $K_3$   |     3     |  1         |  8      | 12      |    6    |    1    |   0     |    0    |   0     |
    | $K_4$   |     4     |  1         |  16     | 32      |    24   |    8    |   1     |    0    |   0     |
    | $K_5$   |     5     |  1         |  32     | 80      |    80   |    40   |   10    |    1    |   0     |
    | $K_6$   |     6     |  1         |  64     | 192     |    240  |    160  |   60    |    12   |   1     |

    Generating function:

    $$f(x,y)=\frac{1-2x-x^2 y}{(1-x) (1-2x-x y)}$$

  * Canonical form

    $$ \Omega(K_n^{(0)})=\frac{dY_1\wedge \ldots \wedge dY_n}{\prod_i Y_i\prod_i (1-Y_i)}$$
