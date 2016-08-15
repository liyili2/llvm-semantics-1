// Copyright (c) 2013-2015 K Team. All Rights Reserved.

module LLVM-SYSCALLS-SYNTAX

    syntax KItem ::= syscallHandler(K, K) [function]

    syntax KItem ::= "sys-write" "(" K ")" 
    rule syscallHandler(4, L) => sys-write(L)

    syntax KItem ::= "sys-getpid" "(" K ")" 
    rule syscallHandler(20, L) => sys-getpid(L)

    syntax KItem ::= "sys-brk" "(" K ")" 
    rule syscallHandler(45, L) => sys-brk(L)

    syntax KItem ::= "sys-ioctl" "(" K ")" 
    rule syscallHandler(54, L) => sys-ioctl(L)

    syntax KItem ::= "sys-rt-sigprocmask" "(" K ")"
    rule syscallHandler(175, L) => sys-rt-sigprocmask(L)

    syntax KItem ::= "sys-gettid" "(" K ")" 
    rule syscallHandler(224, L) => sys-gettid (L)

    syntax KItem ::= "sys-exit-group" "(" K ")" 
    rule syscallHandler(248, L) => sys-exit-group(L)

    syntax KItem ::= "sys-tgkill" "(" K ")"
    rule syscallHandler(268, L) => sys-tgkill(L)


endmodule
