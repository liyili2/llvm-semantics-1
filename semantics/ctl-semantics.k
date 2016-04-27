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
                          > StatePred "and"     StatePred       [right]
                          | StatePred           StatePred       [right, function]
                          > StatePred "or"      StatePred       [right, function]
                          > StatePred "xor"     StatePred       [right]
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

    /* desugaring rules */
    /*------------------*/

    rule S1:StatePred S2:StatePred  => S1 and S2
    rule (not S):StatePred          => ctl-true xor S
    rule (S1 or S2):StatePred       => (S1 xor S2) xor (S1 and S2)
    rule (S1 implies S2):StatePred  => (not S1) or S2
    rule (S1 iff S2):StatePred      => (S1 and S2) or not (S1 or S2)
    rule (-> P):PathPred            => next P
    rule (-- P1 -> P2):PathPred     => P1 until P2
    rule (P <-):PathPred            => prev P
    rule (P2 <- P1 --):PathPred     => P1 since P2
    rule (--> P):PathPred           => eventually P
    rule (P <--):PathPred           => was P
    rule (eventually P):PathPred    => ctl-true until P
    rule (was P):PathPred           => ctl-true since P

    /* simplification */
    /*----------------*/

    /* distribute `and` over `xor` */
/*    rule (C1 xor C2) and C3         => (C1 and C3) xor (C2 and C3)          [structural]
*/
    /* simplify `xor` */
/*    rule C          xor C           => ctl-false                            [structural]
    rule ctl-false  xor C           => C                                    [structural]
    rule C          xor ctl-false   => C                                    [structural]
*/
    /* simplify `and` */
/*    rule ctl-false  and C           => ctl-false                            [structural]
    rule C          and ctl-false   => ctl-false                            [structural]
    rule ctl-true   and C           => C                                    [structural]
    rule C          and ctl-true    => C                                    [structural]
    rule C          and C           => C                                    [structural]
*/
    /* satsifaction */
    /*--------------*/
    syntax Satis        ::= "satis"
                          | "unsatis"
                          | "(" Satis ")"                   [bracket]
                          > "not" Satis
                          > Satis "xor" Satis               [right]
                          > Satis "and" Satis               [right]
                          | Satis       Satis               [right] /* implicit `and` */
                          > Satis "or"  Satis               [right]
                          | State           "|=" StatePred
                          | Quant States    "|=" StatePred

    /* desugar implicit `and` */
/*    rule S:Satis S':Satis       => S and S'                         [structural]
*/
    /* remove `not` and `or` */
/*    rule not S:Satis            => satis xor S                      [structural]
    rule S1:Satis or S2:Satis   => (S1 xor S2) xor (S1 and S2)      [structural]
*/
    /* simplify `xor` */
/*    rule S       xor S          => unsatis                          [structural]
    rule unsatis xor S          => S                                [structural]
    rule S       xor unsatis    => S                                [structural]
*/
    /* simplify `and` */
/*    rule unsatis and S          => unsatis                          [structural]
    rule S       and unsatis    => unsatis                          [structural]
    rule satis   and S          => S                                [structural]
    rule S       and satis      => S                                [structural]
    rule S       and S          => S                                [structural]
*/
    /* distribute `xor` over `and` */
/*    rule (S1 xor S2) and S3     => (S1 and S3) xor (S2 and S3)      [structural]
*/
endmodule


module CTL-SEMANTICS
    imports CTL-SYNTAX

    /* boolean logic */
    /*
     * rule S:State |= ctl-true            => satis                        [structural]
     * rule S:State |= ctl-false           => unsatis                      [structural]
     * rule S:State |= S':State            => satis        when S ==K S'   [structural]
     * rule S:State |= S':State            => unsatis      when S =/=K S'  [structural]
     * rule S:State |= (P1 and P2)         => (S |= P1) and (S |= P2)      [structural]
     * rule S:State |= (P1 xor P2)         => (S |= P1) xor (S |= P2)      [structural]
     */

    /* quantified paths */
    /*
     * rule S:State |= Q:Quant (next P)        => Q succ(S) |= P                           [structural]
     * rule S:State |= Q:Quant (prev P)        => Q pred(S) |= P                           [structural]
     * rule S:State |= Q:Quant (P1 until P2)   => (S |= P2) or (S |= P1 and Q (next Q (P1 until P2)))    [structural]
     * rule S:State |= Q:Quant (P1 since P2)   => (S |= P2) or (S |= P1 and Q (prev Q (P1 since P2)))    [structural]
     */

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
