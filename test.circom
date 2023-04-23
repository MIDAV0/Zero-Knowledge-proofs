template Multiply() {

    // Declaration of signals.
    signal input x;
    signal input y;
    signal output z;
    
    z <-- x * y;

    // Constraints.
    z === x * y;


}
