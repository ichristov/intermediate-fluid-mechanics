# (Some) Vector & tensor algebra operations

Prof. Ivan C. Christov, Purdue University, ME 50900

## Transpose

$$
    \text{If}\quad \underline{\underline{T}} = T_{ij}
    \quad\text{then}\quad
    T_{ji} = \underline{\underline{T}}^t
    \\; \\;
    \left[\text{understood as } (\underline{\underline{T}}^t)_{ij \text{ entry}} \right]
$$

**Remember:** flipping the indices creates a *new* tensor ("the
transpose"); $T_{ij} = T_{ji}$ *only* for *symmetric* tensors!

(**Note:** Panton denotes transpose with $^t$, but you might also see
$^\top$.)

## Multiplication

### vector/vector (dot product; row vector $\times$ column vector = scalar) &mdash; *only one that commutes*

$$
    \underline{u}\cdot\underline{v} = u_i v_i = v_i u_i = \underline{v}\cdot\underline{u}
$$

**Note:** For $\underline{v}\cdot\underline{v}=v_iv_i$ **don't** write
$v_i^2$ because this expression has a free index, and it's therefore a
vector!

### vector/tensor (row vector $\times$ matrix = row vector, or matrix $\times$ column vector = column vector) &mdash; *does not commute*

(**Note:** Panton puts a $\cdot$ between vectors and tensors for
clarity; optional when using 1 vs. 2 underlines.)

$$
    \underline{v} ~ \underline{\underline{T}} = v_i T_{ij}
    \qquad\text{or}\qquad
    (\underline{v} ~ \underline{\underline{T}})_{j \text{th entry}} = \sum_{{\color{magenta}i}=1}^3 T_{{\color{magenta}i}j}v_{\color{magenta}i}
$$

but we're allowed to (carefully!) re-index as

$$
    (\underline{v} ~ \underline{\underline{T}})_{i \text{th entry}} = \sum_{{\color{magenta}j}=1}^3 T_{{\color{magenta}j}i}v_{\color{magenta}j}
$$

which **does** **not** **commute** because

$$
    \underline{\underline{T}} ~ \underline{v} = v_j T_{ij}
    \qquad\text{or}\qquad
    (\underline{\underline{T}} ~ \underline{v})_{i \text{th entry}}
    = \sum_{j=1}^3 T_{ij} v_j
$$

**Note:** If we always write $T_{ij}$, then you can remember what index
to put on $v$ by whether $\underline{v}$ is in-front of
$\underline{\underline{T}}$ (then it's $v_i$, and $\underline{v}$ is a _row vector_)
or behind $\underline{\underline{T}}$ (then it's $v_j$, and $\underline{v}$ is a
_column vector_) inthe symbolic notation expression.

The following useful fact follows:
$\underline{v} ~ \underline{\underline{T}}$ is the row vector with the
same entries as the column vector
$\underline{\underline{T}}^t ~ \underline{v}$.

### vector/vector (dyadic product; column vector $\times$ row vector = matrix) &mdash; *does not commute*

$$
    \underline{u} ~ \underline{v} = u_i v_j
$$

**does not commute** because
$$
    \underline{v} ~ \underline{u} = v_i u_j = u_j v_i
$$

But, if we let
$\underline{\underline{T}} =  \underline{u} ~ \underline{v}$, then we
have shown that
$\underline{v} ~ \underline{u} = \underline{\underline{T}}^t$.\
Sometimes we denote " $\underline{u} ~ \underline{v}$ " as
" $\underline{u}\otimes\underline{v}$ " (so we don't accidentaly confuse
it for " $\underline{u}\cdot\underline{v}$ ").

### tensor/tensor (direct product; matrix $\times$ matrix = matrix) &mdash; *does not commute*

$$
    \underline{\underline{R}} = \underline{\underline{T}} ~ \underline{\underline{S}} \quad\text{or}\quad R_{ij} = T_{ik}S_{kj} \quad\Rightarrow\quad\;\text{(for example)}\quad T_{ik}S_{jk} = \underline{\underline{T}} ~ \underline{\underline{S}}^t \ne \underline{\underline{R}} \; !
$$

This is simply multiplication of matrices, where $k$ runs over the $i$-th
row of $\underline{\underline{T}}$ *and* $j$-th column of
$\underline{\underline{S}}$: $$R_{ij} = \sum_{k=1}^3 T_{ik} S_{kj}$$
**"Row times column" $\Rightarrow$ inner indices** (2nd one on $T$ and 1st one on $S$, in index notation) **must match!**

### tensor/tensor (double contraction; "dot product" for tensors) &mdash; *does not commute*

$$
    \underline{\underline{T}} : \underline{\underline{S}} = T_{ij} S_{ji} \quad\Rightarrow\quad\;\text{(for example)}\quad T_{ij} S_{ij} = \underline{\underline{T}} : \underline{\underline{S}}^t \ne \underline{\underline{T}} : \underline{\underline{S}}
$$

**Note:** If we define $R_{kl} = T_{kj} S_{jl}$ then
$\mathop{\mathrm{tr}}(\underline{\underline{R}}) = R_{kk} = R_{ii} = T_{ij} S_{ji}$,
in other words
$\underline{\underline{T}} :  \underline{\underline{S}} = \mathop{\mathrm{tr}}( \underline{\underline{T}} ~  \underline{\underline{S}})$.

&mdash;-

Prof. Ivan C. Christov, Purdue University, ME 50900
