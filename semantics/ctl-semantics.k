module CTL-SYNTAX

    /* States */
    /*--------*/
    syntax State        ::= Id
    syntax StateQuery   ::= succ(State)
                          | pred(State)
    syntax SetState     ::= "(" SetState ")"    [bracket]
                          | ".States"
                          | State SetState
    syntax States       ::= "(" States ")"      [bracket]
                          | SetState
                          | StateQuery

    syntax KResult      ::= State
    syntax KResult      ::= SetState

    /* formula constructor terms */
    /*---------------------------*/

    syntax Quant        ::= "A" | "E"
    syntax AtomicPred   ::= State

    syntax StatePredFin ::= AtomicPred
                          | "ctl-true"
                          | "ctl-false"
                          > StatePredFin "and" StatePredFin     [right, seqstrict]
                          > StatePredFin "xor" StatePredFin     [right, seqstrict]
                          | Quant PathPredFin                   [seqstrict]

    syntax PathPredFin  ::= "next" StatePredFin                 [seqstrict]
                          | "prev" StatePredFin                 [seqstrict]
                          | StatePredFin "until" StatePredFin   [right, seqstrict]
                          | StatePredFin "since" StatePredFin   [right, seqstrict]

    syntax KResult      ::= StatePredFin
    syntax KResult      ::= PathPredFin

    /* formula sugared terms */
    /*-----------------------*/

    syntax StatePred    ::= StatePredFin
                          | "(" StatePred ")"               [bracket]
                          |           "not"     StatePred   [seqstrict]
                          > StatePred "and"     StatePred   [left, seqstrict]
                          | StatePred           StatePred   [left, seqstrict]          /* implicit `and` */
                          > StatePred "xor"     StatePred   [left, seqstrict]
                          > StatePred "or"      StatePred   [left, seqstrict]
                          > StatePred "implies" StatePred   [seqstrict]
                          > StatePred "iff"     StatePred   [seqstrict]
                          | Quant PathPred                  [strict(2)]

    syntax PathPred     ::= PathPredFin
                          | "(" PathPred ")"                [bracket]
                          | "->" StatePred                  [seqstrict]
                          | "--" StatePred "->" StatePred   [seqstrict]
                          | StatePred "<-"                  [seqstrict]
                          | StatePred "<-" StatePred "--"   [seqstrict]
                          | "-->" StatePred                 [seqstrict]
                          | "eventually" StatePred          [seqstrict]
                          | StatePred "<--"                 [seqstrict]
                          | "was" StatePred                 [seqstrict]

    /* desugaring rules */
    /*------------------*/

    /* implicit `and` */
    rule C1         C2              => C1 and C2                            [structural]

    /* `not`, `or`, `implies`, and `iff` */
    rule    not     C               => ctl-true xor C                       [structural]
    rule C1 or      C2              => (C1 xor C2) xor (C1 and C2)          [structural]
    rule C1 implies C2              => (not C1) or C2                       [structural]
    rule C1 iff     C2              => (C1 and C2) or not (C1 or C2)        [structural]

    /* desugar path predicates */
    rule -> P                       => next P                               [structural]
    rule -- P1 -> P2                => P1 until P2                          [structural]
    rule P <-                       => prev P                               [structural]
    rule P2 <- P1 --                => P1 since P2                          [structural]
    rule --> P                      => eventually P                         [structural]
    rule P <--                      => was P                                [structural]
    rule eventually P               => ctl-true until P                     [structural]
    rule was P                      => ctl-true since P                     [structural]

    /* simplification */
    /*----------------*/

    /* distribute `and` over `xor` */
    rule (C1 xor C2) and C3         => (C1 and C3) xor (C2 and C3)          [structural]

    /* simplify `xor` */
    rule C          xor C           => ctl-false                            [structural]
    rule ctl-false  xor C           => C                                    [structural]
    rule C          xor ctl-false   => C                                    [structural]

    /* simplify `and` */
    rule ctl-false  and C           => ctl-false                            [structural]
    rule C          and ctl-false   => ctl-false                            [structural]
    rule ctl-true   and C           => C                                    [structural]
    rule C          and ctl-true    => C                                    [structural]
    rule C          and C           => C                                    [structural]

endmodule


module SATISFACTION

    /* satsifaction */
    syntax SatisFin     ::= "satis"
                          | "unsatis"
    syntax Satis        ::= SatisFin
                          | "(" Satis ")"                   [bracket]
                          > "not" Satis                     [seqstrict]
                          > Satis "xor" Satis               [right, seqstrict]
                          > Satis "and" Satis               [right, seqstrict]
                          | Satis       Satis               [right, seqstrict] /* implicit `and` */
                          > Satis "or"  Satis               [right, seqstrict]

    syntax KResult      ::= SatisFin

    /* desugar implicit `and` */
    rule S:Satis S':Satis       => S and S'                         [structural]

    /* remove `not` and `or` */
    rule not S:Satis            => satis xor S                      [structural]
    rule S1:Satis or S2:Satis   => (S1 xor S2) xor (S1 and S2)      [structural]

    /* simplify `xor` */
    rule S       xor S          => unsatis                          [structural]
    rule unsatis xor S          => S                                [structural]
    rule S       xor unsatis    => S                                [structural]

    /* simplify `and` */
    rule unsatis and S          => unsatis                          [structural]
    rule S       and unsatis    => unsatis                          [structural]
    rule satis   and S          => S                                [structural]
    rule S       and satis      => S                                [structural]
    rule S       and S          => S                                [structural]

    /* distribute `xor` over `and` */
    rule (S1 xor S2) and S3     => (S1 and S3) xor (S2 and S3)      [structural]

endmodule


module CTL-SEMANTICS
    imports SATISFACTION
    imports CTL-SYNTAX

    /* satisfaction syntax (only CTL, not CTL*) */
    syntax SatisQuery   ::= State           "|=" StatePred
                          | States          "|=" StatePred                      [strict(1)]
                          | Quant States    "|=" StatePred                      [strict(2)]
    syntax Satis        ::= SatisQuery

    /* extension of satisfaction to sets of states/paths */
    rule S:States |= P                  => A S |= P                             [structural]
    rule A .States |= SP                => satis                                [structural]
    rule A (S:State SS:SetState) |= P   => (S |= P) and (A SS |= P)             [structural]
    rule E .States |= SP                => unsatis                              [structural]
    rule E (S:State SS:SetState) |= P   => (S |= P) or (E SS |= P)              [structural]

    /* boolean logic */
    rule S:State |= ctl-true            => satis                                [structural]
    rule S:State |= ctl-false           => unsatis                              [structural]
    rule S:State |= S':State            => satis        when S ==K S'           [structural]
    rule S:State |= S':State            => unsatis      when S =/=K S'          [structural]
    rule S:State |= (P1 and P2)         => (S |= P1) and (S |= P2)              [structural]
    rule S:State |= (P1 xor P2)         => (S |= P1) xor (S |= P2)              [structural]

    /* quantified paths */
    rule S:State |= Q:Quant (next P)        => Q succ(S) |= P                       [structural]
    rule S:State |= Q:Quant (prev P)        => Q pred(S) |= P                       [structural]
    rule S:State |= Q:Quant (P1 until P2)   => (S |= P2) or (S |= Q (next Q (P1 until P2)))   [structural]
    rule S:State |= Q:Quant (P1 since P2)   => (S |= P2) or (S |= Q (prev Q (P1 since P2)))   [structural]

    /* calculating successors/predecessors */
/*    rule <k> succ(S:State) => SS ... </k>
         <succs> ... S |-> SS ... </succs>
    rule <k> pred(S:State) => SS ... </k>
         <preds> ... S |-> SS ... </preds>
*/
    /* testing */

    /* input syntax */
    syntax StateDesc    ::= State "->" States "::" StatePred
    syntax ModelDesc    ::= ".Model"
                          | StateDesc ";;" ModelDesc
    syntax ModelQuery   ::= ModelDesc "--satis--" SatisQuery

    syntax KItem        ::= ModelQuery
                          | SatisQuery
                          | buildModel(ModelDesc)
                          | nuEdges(State,States)

    rule MD:ModelDesc --satis-- S:SatisQuery => buildModel(MD) ~> S

    /* building problem statement */
    rule <k> buildModel(SD:StateDesc ;; MD:ModelDesc) => buildModel(MD) ... </k>
         (. => <instruction> ... <id> buildState(SD) </id> ... </instruction>)

    rule <k> buildModel(.Model) => . ... </k>

    rule <k> (. => nuEdges(S,SS)) ... </k>
         <id> buildState(S:State -> SS:States :: SP:StatePred) => . ... </id>
         <atomic> . => SP </atomic>

/*
    rule addEdges(S:State, S1:State SS:StateSuccs) => addEdges(S,S1) ~> addEdges(S,SS)

    rule <instruction> 

    rule <k> (addEdge(S:State, S':State) => .) ... </k>
         <succs> ... S |-> (SS:SetState => S' SS) ... </succs>
    rule <k> addEdge(S:State, S':State) => . ... </k>
         <succs> (.Map => S |-> S' .States) Succs:Map </succs>
         when notBool (S in keys(Succs))

    rule <k> (addBackEdge(S:State, S':State) => .) ... </k>
         <preds> ... S |-> (SS:SetState => S' SS) ... </preds>
    rule <k> addBackEdge(S:State, S':State) => . ... </k>
         <preds> (.Map => S |-> S' .States) Preds:Map </preds>
         when notBool (S in keys(Preds))
*/

    configuration
        <basicBlocks>
            <k> $PGM:ModelQuery </k>
            <instruction multiplicity="*">
                <id> .K </id>
                <succs> .States </succs>
                <preds> .States </preds>
                <atomic> ctl-true </atomic>
                <checking> .K </checking>
            </instruction>
        </basicBlocks>
    /*
     * syntax Rule         ::= Name
     * syntax Rewrite      ::= Rule
     *                       | Rule "*"
     *                       | Rule ";;" Rule      [right]
     * syntax Optimization ::= Model
     *                         ";; begin optimization"
     *                         ";;" Rewrite
     *                         ";; end optimization"
     */

endmodule
