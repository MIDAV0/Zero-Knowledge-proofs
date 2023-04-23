template Multiply() {

    // Declaration of signals.
    signal input x;
    signal input y;
    signal output z;
    
    // <-- sets signal value
    // === creates constraint
    // <== does both

    z <-- x * y;

    // Constraints.
    z === x * y;


}

// Instantiation of the module.
component main {public [x]} = Multiply();
