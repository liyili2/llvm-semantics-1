module CTL-SYNTAX

    /* states */
    /*--------*/
    syntax State        ::= Id
    syntax States       ::= ".S"
                          | "(" States ")"      [bracket]
                          | State "," States
                          | succ(State)
                          | pred(State)

    /* formula terms */
    /*---------------*/
    syntax Quant        ::= "A" | "E"
    syntax AtomicPred   ::= State
    syntax StatePred    ::= AtomicPred
                          | "ctl-true"
                          | "ctl-false"
                          | "(" StatePred ")"                   [bracket]
                          |           "not"     StatePred       [function]
                          > StatePred "and"     StatePred       [right, function]
                          | StatePred           StatePred       [right, function]
                          > StatePred "or"      StatePred       [right, function]
                          > StatePred "xor"     StatePred       [right, function]
                          > StatePred "implies" StatePred       [function]
                          > StatePred "iff"     StatePred       [function]
                          | Quant PathPred
    syntax PathPred     ::= "(" PathPred ")"                    [bracket]
                          | "next" StatePred
                          | "prev" StatePred
                          | StatePred "until" StatePred
                          | StatePred "since" StatePred
                          | "->" StatePred                      [function]
                          | StatePred "<-"                      [function]
                          | "--" StatePred "->" StatePred       [function]
                          | StatePred "<-" StatePred "--"       [function]
                          | "eventually" StatePred              [function]
                          | "-->" StatePred                     [function]
                          | "was" StatePred                     [function]
                          | StatePred "<--"                     [function]

    /* desugaring (functional) rules */
    /*-------------------------------*/

    /* desugar implicit `and` */
    rule S1:StatePred S2:StatePred      => S1 and S2

    /* desugar `implies` and `iff` */
    rule (S1 implies S2):StatePred      => (not S1) or S2
    rule (S1 iff S2):StatePred          => (S1 and S2) or not (S1 or S2)

    /* algebraic normal form */
    rule (not S):StatePred              => ctl-true xor S
    rule (S1 or S2):StatePred           => (S1 xor S2) xor (S1 and S2)
    rule ((S1 xor S2) and S3):StatePred => (S1 and S3) xor (S2 and S3)

    /* simplify `and` */
    rule (ctl-false and S):StatePred    => ctl-false
    rule (S and ctl-false):StatePred    => ctl-false
    rule (ctl-true and S):StatePred     => S
    rule (S and ctl-true):StatePred     => S
    rule (S and S):StatePred            => S

    /* simplify `xor` */
    rule (S xor S):StatePred            => ctl-false
    rule (ctl-false xor S):StatePred    => S
    rule (S xor ctl-false):StatePred    => S

    /* desugar path predicates */
    rule (-> P):PathPred                => next P
    rule (-- P1 -> P2):PathPred         => P1 until P2
    rule (P <-):PathPred                => prev P
    rule (P2 <- P1 --):PathPred         => P1 since P2
    rule (--> P):PathPred               => eventually P
    rule (P <--):PathPred               => was P
    rule (eventually P):PathPred        => ctl-true until P
    rule (was P):PathPred               => ctl-true since P

    /* satsifaction */
    /*--------------*/
    syntax Satis        ::= "satis"
                          | "unsatis"
                          | "(" Satis ")"                   [bracket]
                          > Satis "and" Satis               [right]
                          > Satis       Satis               [right, function]
                          > Satis "xor" Satis               [right]
                          > Satis "or"  Satis               [right, function]
                          | State           "|=" StatePred
                          | Quant States    "|=" StatePred

    /* desugar implicit `and` */
    rule (S S'):Satis       => S and S'                     [structural]

    /* remove `not` and `or` */
    rule (S1 or S2):Satis   => (S1 xor S2) xor (S1 and S2)  [structural]

endmodule


module CTL-SEMANTICS
    imports CTL-SYNTAX

    configuration
        <basicBlocks>
            <k> $PGM:Query </k>
            <instruction multiplicity="*">
                <id> .K </id>
                <succs> .S </succs>
                <preds> .S </preds>
                <proven> ctl-true </proven>
                <query> .K </query>
            </instruction>
        </basicBlocks>

    /* input syntax */
    syntax State    ::= State "->" States "::" StatePred
    syntax Model    ::= State "." Model
                      | "; end model"
    syntax Query    ::= "; model" Model "; satis" Satis

    /* desugar input */
    rule ; model
            MD:Model
         ; satis
            SQ:Satis
         => MD ~> SQ

    /* break model description into correct nodes for model */
    rule ; end model => .
    rule <k> S -> SS :: SP . MD:Model => MD ~> nuEdges(S,SS) ... </k>
         (. => <instruction> ... <id> S </id> <proven> SP </proven> ... </instruction>)

    /* add edges between nodes */
    syntax KItem        ::= nuEdges(State,States)
                          | nuSucc(State,State)
                          | nuPred(State,State)

    rule <k> nuEdges(S, S1 , SS) => nuSucc(S, S1) ~> nuPred(S1, S) ~> nuEdges(S, SS) ... </k>
    rule <k> nuEdges(S, .S) => . ... </k>

    rule <k> nuSucc(S, S') => . ... </k>
            <instruction>
                ...
                <id> S </id>
                (<succs> SS </succs> => <succs> S' , SS </succs>)         /* WHYYYY???? */
                ...
            </instruction>

    rule <k> nuPred(S, S') => . ... </k>
            <instruction>
                ...
                <id> S </id>
                (<preds> PS </preds> => <preds> S' , PS </preds>)         /* WHYYYY???? */
                ...
            </instruction>

    /* evaluate query */
    rule A .S |= SP                     => satis                        [structural]
    rule A (S:State , SS:States) |= P   => (S |= P) and (A SS |= P)     [structural]
    rule E .S |= SP                     => unsatis                      [structural]
    rule E (S:State , SS:States) |= P   => (S |= P) or (E SS |= P)      [structural]

    rule <k> S:State |= SP:StatePred => . ... </k>
            <instruction> ...  <id> S </id> <query> . => SP </query> ...  </instruction>

    rule <k> Q:Quant (succ(S:State) => SS) |= SP:StatePred ... </k>
            <instruction> ...  <id> S </id> <succs> SS </succs> ...  </instruction>

    rule <k> Q:Quant (pred(S:State) => PS) |= SP:StatePred ... </k>
            <instruction> ...  <id> S </id> <preds> PS </preds> ...  </instruction>

endmodule
