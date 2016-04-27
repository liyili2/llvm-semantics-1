module CTL-SYNTAX

    /* states */
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

    /* formula terms */
    /*---------------*/
    syntax Quant        ::= "A" | "E"
    syntax AtomicPred   ::= State
    syntax StatePred    ::= AtomicPred
                          | "ctl-true"
                          | "ctl-false"
                          | "(" StatePred ")"                   [bracket]
                          |           "not"     StatePred       [seqstrict]
                          > StatePred "and"     StatePred       [right, seqstrict]
                          | StatePred           StatePred       [right, seqstrict]
                          > StatePred "or"      StatePred       [right, seqstrict]
                          > StatePred "xor"     StatePred       [right, seqstrict]
                          > StatePred "implies" StatePred       [seqstrict]
                          > StatePred "iff"     StatePred       [seqstrict]
                          | Quant PathPred                      [strict(2)]
    syntax PathPred     ::= "(" PathPred ")"                    [bracket]
                          | "next" StatePred                    [seqstrict]
                          | "->" StatePred                      [seqstrict]
                          | "prev" StatePred                    [seqstrict]
                          | StatePred "<-"                      [seqstrict]
                          | StatePred "until" StatePred         [seqstrict]
                          | "--" StatePred "->" StatePred       [seqstrict]
                          | StatePred "since" StatePred         [seqstrict]
                          | StatePred "<-" StatePred "--"       [seqstrict]
                          | "-->" StatePred                     [seqstrict]
                          | "eventually" StatePred              [seqstrict]
                          | StatePred "<--"                     [seqstrict]
                          | "was" StatePred                     [seqstrict]

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
    syntax Satis        ::= "satis"
                          | "unsatis"
                          | "(" Satis ")"                   [bracket]
                          > "not" Satis                     [seqstrict]
                          > Satis "xor" Satis               [right, seqstrict]
                          > Satis "and" Satis               [right, seqstrict]
                          | Satis       Satis               [right, seqstrict] /* implicit `and` */
                          > Satis "or"  Satis               [right, seqstrict]

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

    configuration
        <basicBlocks>
            <k> $PGM:ModelQuery </k>
            <instruction multiplicity="*">
                <id> .K </id>
                <succs> .States </succs>
                <preds> .States </preds>
                <proven> ctl-true </proven>
                <query> .K </query>
            </instruction>
        </basicBlocks>

    /* input syntax */
    syntax StateDesc    ::= State "->" States "::" StatePred
    syntax ModelDesc    ::= StateDesc "." ModelDesc
                          | "; end model"
    syntax SatisDesc    ::= SatisQuery ";" SatisDesc
                          | "; end satis"
    syntax ModelQuery   ::= "; model" ModelDesc "; satis" SatisDesc "; stop"

    /* "constructors" (in the OOP sense) */
    syntax KItem        ::= State(StateDesc)
                          | Satis(SatisDesc)
                          | Satis(SatisQuery)
                          | Model(ModelDesc)
                          | nuEdges(State,States)
                          | nuSucc(State,State)
                          | nuPred(State,State)

    rule ; model
            MD:ModelDesc
         ; satis
            SD:SatisDesc
         ; stop => Model(MD) ~> Satis(SD)

    /* building problem statement */
    rule <k> Model(S -> SS :: SP . MD) => Model(MD) ~> nuEdges(S,SS) ... </k>
         (. => <instruction> ... <id> S </id> <atomic> SP </atomic> ... </instruction>)
    rule Model(; end model) => .

/*
    rule <k> Satis(SQ:SatisQuery ; SD:SatisDesc) => Satis(SD) ... </k>
    rule Satis(; end satis) => .
*/
    rule nuEdges(S, .States) => .
    rule nuEdges(S, S1:State SS) => nuSucc(S, S1) ~> nuPred(S1, S) ~> nuEdges(S, SS)

    rule <k> nuSucc(S, S') => . ... </k>
            <instruction>
                ...
                <id> S </id>
                (<succs> SS </succs> => <succs> S' SS </succs>)
                ...
            </instruction>

    rule <k> nuPred(S, S') => . ... </k>
            <instruction>
                ...
                <id> S </id>
                (<preds> PS </preds> => <preds> S' PS </preds>)
                ...
            </instruction>

endmodule
