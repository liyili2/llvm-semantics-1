module CUSFUNC
    syntax KItem ::= ieeetest(K, K)
    syntax Int ::= #SmallPow(Int, Int) [function]
    syntax Int ::= #DivTest(Int, Int) [function]
    syntax Int ::= decimal(Int, Int, Int, Int, Int)
    syntax Int ::= deccou(Int, Int, Int, Int, Int, Int)

    rule #DivTest(N:Int,C:Int) => N /Int C

    rule <k> ieeetest(N:Float, M:Int) => ieeetest(((N -Float floorFloat(N)) /Float 2:Float), M +Int 1) ...</k>
         requires M <Int 23
    rule <k> ieeetest(N:Float, M:Int) => 0 ...</k>
         requires M >=Int 23 andBool N =/=Float 0:Float
    rule <k> ieeetest(N:Float, M:Int) => 1 ...</k>
         requires M <=Int 23 andBool N ==Float 0:Float

    rule <k> decimal(M:Int, C:Int, R:Int, I:Int, X:Int) => decimal((2 *Int M) -Int #SmallPow(M,1), 10 *Int C, R +Int C, I +Int 1, X) ...</k>
         requires 2 *Int M >Int #SmallPow(M,1) andBool M >Int 0 andBool I <Int X
    rule <k> decimal(M:Int, C:Int, R:Int, I:Int, X:Int) => decimal(2 *Int M, 10 *Int C, R, I +Int 1, X) ...</k>
         requires 2 *Int M <Int #SmallPow(M,1) andBool M >Int 0 andBool I <Int X
    rule <k> decimal(M:Int, C:Int, R:Int, I:Int, X:Int) => R ...</k>
         requires 2 *Int M ==Int #SmallPow(M,1) andBool M >Int 0 andBool I <Int X

    rule <k> deccou(M:Int, C:Int, R:Int, I:Int, X:Int, Y:Int) => deccou((2 *Int M) -Int Y, 10 *Int C, R +Int C, I +Int 1, X, Y) ...</k>
         requires ((2 *Int M) /Int Y) >Int 0 andBool M >Int 0 andBool I <Int X andBool (2 *Int M) =/=Int Y
    rule <k> deccou(M:Int, C:Int, R:Int, I:Int, X:Int, Y:Int) => deccou(2 *Int M, 10 *Int C, R, I +Int 1, X, Y) ...</k>
         requires ((2 *Int M) /Int Y) =Int 0 andBool M >Int 0 andBool I <Int X andBool (2 *Int M) =/=Int Y
    rule <k> deccou(M:Int, C:Int, R:Int, I:Int, X:Int, Y:Int) => R ...</k>
         requires M >Int 0 andBool I <Int X andBool (2 *Int M) =Int Y
    rule <k> deccou(M:Int, C:Int, R:Int, I:Int, X:Int, Y:Int) => R ...</k>
         requires M =Int 0 andBool I <Int X


    rule #SmallPow(N,C) => #SmallPow(N,10 *Int C)
         requires N >Int C
    rule #SmallPow(N,C) => C
         requires N <=Int C
endmodule
