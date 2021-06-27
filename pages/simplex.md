---
layout: article
sidebar:
  nav: docs-en
---

* **Definition**

    A unit simplex is the convex hull of $n$ basis points: $S_n^{(0)}=\text{conv}\\{e_1,\ldots,e_n\\}$

    A projective simplex $S_n$ is a convex hull of $n$ vectors $Z_i\in \mathbb{P}^{n-1}$: $S_n=\text{conv}\\{Z_1,\ldots,Z_n\\}$.

* **Properties**

  * F-vector 

      * ([OEIS A007318](https://oeis.org/A007318))
    
      | Simplex | Dimension | (-1)-faces | 0-faces | 1-faces | 2-faces | 3-faces | 4-faces | 5-faces | 6-faces |
      |:-------:|:---------:|:----------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|:-------:|
      | $S_1$   |     0     |  1         |  1      | 0       |    0    |    0    |   0     |    0    |   0     |
      | $S_2$   |     1     |  1         |  2      | 1       |    0    |    0    |   0     |    0    |   0     |
      | $S_3$   |     2     |  1         |  3      | 3       |    1    |    0    |   0     |    0    |   0     |
      | $S_4$   |     3     |  1         |  4      | 6       |    4    |    1    |   0     |    0    |   0     |
      | $S_5$   |     4     |  1         |  5      | 10      |    10   |    5    |   1     |    0    |   0     |
      | $S_6$   |     5     |  1         |  6      | 15      |    20   |    15   |   6     |    1    |   0     |
      | $S_7$   |     6     |  1         |  7      | 21      |    35   |    35   |   21    |    7    |   1     |

      * F-vector generating function:

        $$f(x,y)=\frac{1}{y(1-x-xy)}$$

      * F-vector exponential generating function:

        $$\bar{f}(x,y)=\frac{e^{x (y+1)}}{y}$$
  
  * Canonical form

      * General simplex

    $$ \Omega(S_n)=\frac{\langle Z_1 Z_2 \ldots Z_n\rangle^{n-1} \langle Yd^n Y\rangle}{m! \langle YZ_1\ldots Z_{n-1}\rangle\langle YZ_2\ldots Z_{n}\rangle\ldots \langle YZ_n\ldots Z_{n-2}\rangle}$$
    
       * Unit simplex:

    $$ \Omega(S_n^{(0)}) = \frac{\langle Yd^n Y\rangle }{Y_1 Y_2\ldots Y_n}$$
