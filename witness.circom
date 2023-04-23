template NonZero() {
    signal input in;
    signal inverse;
    inverse <-- 1 /in;
    1 === in * signal;
}

template Main() {
    signal input a;
    signal input b;
    component nz = NonZero();
    nz.in <== a;
    0 === a * b;
}