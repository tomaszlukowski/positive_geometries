---
layout: article
sidebar:
  nav: docs-en
---

* **Definition**

    An associahedron $A_n$ is defined as an intersection $A_n = H_n \cap \Delta_n$, where
    
    $$ K_n=$$
    
    and
    
    $$ \Delta_n=$$

* **Properties**

  * F-vector ([OEIS A033282](https://oeis.org/A033282))
    
    | Simplex | Dimension | (-1)-faces | 0-faces | 1-faces | 2-faces | 3-faces | 4-faces | 5-faces | 6-faces |
    |:-------:|:---------:|:----------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
    | $A_0$   |     0     |  1         |  1      | 0       |    0    |    0    |   0     |    0    |   0     |
    | $A_1$   |     1     |  1         |  2      | 1       |    0    |    0    |   0     |    0    |   0     |
    | $A_2$   |     2     |  1         |  5      | 5       |    1    |    0    |   0     |    0    |   0     |
    | $A_3$   |     3     |  1         |  9      | 21      |    14   |    1    |   0     |    0    |   0     |
    | $A_4$   |     4     |  1         |  14     | 56      |    84   |    42   |   1     |    0    |   0     |
    | $A_5$   |     5     |  1         |  20     | 120     |    300  |    330  |   132   |    1    |   0     |
    | $A_6$   |     6     |  1         |  27     | 225     |    825  |    1485 |   1287  |    429  |   1     |

    F-vector generating function:

    $$\frac{-\sqrt{x^2-4 x y-2 x+1}-2 x y-x+1}{2 x y^2 (y+1)}+\frac{1}{y (1-x y)}$$

  * Canonical form
