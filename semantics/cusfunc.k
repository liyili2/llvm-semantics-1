module CUSFUNC
    syntax KItem ::= ieeetest(K, K)

    rule <k> ieeetest(N:Float, M:Int) => ieeetest(((N -Float floorFloat(N)) /Float 2:Float), M +Int 1) ...</k>
         requires M <Int 23
    rule <k> ieeetest(N:Float, M:Int) => 0 ...</k>
         requires M >=Int 23 andBool N =/=Float 0:Float
    rule <k> ieeetest(N:Float, M:Int) => 1 ...</k>
         requires M <=Int 23 andBool N ==Float 0:Float
endmodule
