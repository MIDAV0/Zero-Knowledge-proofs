pragma circom 2.0.0;

template NonEqual(){
    signal input in0;
    signal input in1;
    // check that (in0 - in1) != 0
    signal inverse;
    inverse <-- 1 / (in0 - in1);
    inverse*(in0 - in1) === 1;
}

// Ensure that all inputs are distinct
template Distinct(n){
    signal input in[n];
    component nonEqual[n][n];
    for (var i = 0; i < n; i++) {
        for (var j = 0; j < i; j++) {
            if (i != j) {
                nonEqual[i][j] = NonEqual();
                nonEqual[i][j].in0 <== in[i];
                nonEqual[i][j].in1 <== in[j];
            }
        }
    }
}

// Ensure that 0 <= in < 16
template Bits4(){
    signal input in;
    signal bits[4];
    var bitsum = 0;
    for (var i = 0; i < 4; i++) {
        bits[i] <-- (in >> i) & 1;
        bits[i] * (bits[i] - 1) === 0;
        bitsum = bitsum + 2 ** i * bits[i];
    }
    bitsum === in;
}

// Ensure that 1 <= in <= 9
template OneToNine(){
    signal input in;
    component lowerBound = Bits4();
    component upperBound = Bits4();
    lowerBound.in <== in - 1;
    upperBound.in <== in + 6;
}


template Sudoku(n){
    signal input solution[n][n];
    signal input puzzle[n][n];

    // Ensure that each solution number in the range 1..9
    component inRange[n][n];
    for (var i = 0; i < n; i++) {
        for (var j = 0; j < n; j++) {
            inRange[i][j] = OneToNine();
            inRange[i][j].in <== solution[i][j];
        }
    }

    // Ensure that puzzle and solution agree
    for (var i = 0; i < n; i++) {
        for (var j = 0; j < n; j++) {
            // puzzle_cell * (puzzle_cell - solution_cell) === 0
            puzzle[i][j] * (puzzle[i][j] - solution[i][j]) === 0;
        }
    }

    // Ensure uniqueness of each row
    component distinct[n];
    for (var i = 0; i < n; i++) {
        distinct[i] = Distinct();
        for (var j = 0; j < n; j++) {
            distinct[i].in[j] <== solution[i][j];
        }
    }
}

component main {public[puzzle]} = Sudoku(9);