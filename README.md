# Máquina Diferencial de Babbage em Verilog

Esse projeto corresponde à um emulador de uma máquina diferencial de Babbage. A máquina diferencial de Babbage tem como objetivo de tabular valores em uma equação polinominal utilizando equações de diferença. Desta forma, o hardware digital não deve se preocupar em realizar operações complexas de multiplicação, apenas soma e subtrações, o que simplifica o nosso circuito.

![image](https://github.com/pedrothiag/babbage_verilog/assets/5923790/9d2e6307-1228-4345-8667-4fd457798196)

## Como Funciona a Máquina Diferencial de Babbage?

Considere que desejamos tabular os valores do seguintes polinômio $h(n)$ dado por:

$$
h(n) = n^3 + 2n^2 + 2n + 1
$$

O primeiro passo é tomar o valor de $h(n-1)$:

$$
\begin{split}
h(n-1) & = (n-1)^3 + 2(n-1)^2 + 2(n-1) + 1\\
       & = n^3 - n^2 + n
\end{split}
$$

Desta forma podemos encontrar a primeira diferença regressiva em relação à $h(n)$:

$$
\begin{split}
h(n) - h(n-1) & = n^3 + 2n^2 + 2n + 1 - (n^3 - n^2 + n) \\
              & = 3n^2 + n + 1
\end{split}
$$

ou seja,

$$
h(n) = h(n-1) + 3n^2 + n + 1
$$

Isso é particulamente verdadeiro para $n > 0$. Para $n = 0$, o valor de $h(n)$ é dado pelo termo livre do polinômio $h(n)$, ou seja $h(0) = 1$. Desta forma,

$$
h(n) = \begin{cases}
    1, & n = 0 \\
    h(n-1) + 3n^2 + n + 1, & n > 0
\end{cases}
$$

Todavia, a equação apresentada acima ainda contém termos de segunda ordem. Isso pode ser resolvido denominado $f(n) = 3n^2 + n + 1$. Desta forma,

$$
h(n) = \begin{cases}
    1, & n = 0 \\
    h(n-1) + f(n), & n > 0
\end{cases}
$$

O procedimento é repetido para o novo polinômio $f(n)$, ou seja, tomando-se $f(n-1)$:

$$
\begin{split}
f(n-1) & = 3(n-1)^2 + (n-1) + 1\\
       & = 3n^2 - 5n + 3
\end{split}
$$

Desta forma,

$$
\begin{split}
f(n) - f(n-1) & = 3n^2 + n + 1 - (3n^2 - 5n + 3)\\
              & = 6n - 2
\end{split}
$$

ou seja,

$$
f(n) = f(n-1) + 6n - 2
$$

Isso é particulamente verdadeiro para $n > 1$ (lembrando que o primeiro valor de $f(n)$ é calculado em $n=1$). Para $n = 1$, o valor de $f(n)$ é dado por $f(1) = 3(1)^2 + 1 + 1 = 5$. Ou seja:

$$
f(n) = \begin{cases}
    5, & n = 1 \\
    f(n-1) + 6n - 2, & n > 1
\end{cases}
$$

Por fim, denominado $g(n) = 6n - 2$ temos que:

$$
f(n) = \begin{cases}
    5, & n = 1 \\
    f(n-1) + g(n), & n > 1
\end{cases}
$$

Podemos realizar o mesmo procedimento para $g(n)$:

$$
\begin{split}
g(n-1) & = 6(n-1) - 2\\
       & = 6n - 8
\end{split}
$$

ou seja,

$$
\begin{split}
g(n) - g(n-1) & = 6n - 2 - (6n - 8)\\
              & = 6
\end{split}
$$

Assim sendo,

$$
g(n) = 6 + g(n-1)
$$

Isso é particulamente verdadeiro para $n > 2$ (lembrando que o primeiro valor de $g(n)$ é calculado em $n=2$). Para $n = 2$, o valor de $g(n)$ é dado por $g(2) = 6(2) - 2 = 10$. Ou seja:

$$
g(n) = \begin{cases}
    10, & n = 2 \\
    6 + g(n-1), & n > 2
\end{cases}
$$

Desta forma, o polinômio $h(n) = n^3 + 2n^2 + 2n + 1$ pode ter seus valores tabulados utilizando-se as seguintes equações de diferença:

$$
h(n) = \begin{cases}
    1, & n = 0 \\
    h(n-1) + f(n), & n > 0
\end{cases}
$$

$$
f(n) = \begin{cases}
    5, & n = 1 \\
    f(n-1) + g(n), & n > 1
\end{cases}
$$

$$
g(n) = \begin{cases}
    10, & n = 2 \\
    6 + g(n-1), & n > 2
\end{cases}
$$

Ou seja, um polinômio de terceiro grau tem seus valores tabulados sem a necessidade de nenhuma operação que não seja somas!
