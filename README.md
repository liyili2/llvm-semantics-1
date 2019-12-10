The previous version of the LLVM semantics (using K version 2) is now located at https://github.com/kframework/llvm-semantics-old.

Versions of tools used to generate the .ll files:

LLVM (http://llvm.org/):
  LLVM version 6.0.0
  
  Optimized build.
  Built Mar  5 2018 (17:05:10).
  Default target: x86_64-unknown-linux-gnu
  Host CPU: core-avx-i

clang version 6.0.0 (tags/RELEASE_600/final)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin

Currently, the K parser cannot parse LLVM comments. They need to be
removed from your LLVM program before you call the kast tool on them.
For your convenience, we provide a java program that does that, called
DeleteLLVMComments:

$ java DeleteLLVMComments myprogram.ll

will output the resulting LLVM program to standard output, while

$ krun --parser "java DeleteLLVMComments" --directory mysemanticsdirectory myprogram.ll

will forward it to the kast tool. Therefore, if your LLVM program
contains comments, make sure that you use the pipe command
above as external parser to the krun tool when you execute your
program with the LLVM semantics.

K-LLVM is supposed to run on K 3.6 platform. 

To compile K-LLVM, it is required to have more than 8G memory. Please follow the following steps. First, unzip the k.zip file. In the k/bin directory, it contains all necessary tools. Assume that users have set the path to the k/bin directory. To compile K-LLVM, go to the semantics directory, and hit:

kompile llvm-semantics.k

This command allows users to build K-LLVM in K. Now, to execute a LLVM program, please do the following:

krun xxx.ll

This command executes the program xxx.ll by using the K-LLVM semantics we just compiled above, and creates a final abstract machine state containing all information in different cells after executing the program. To see the step by step result, users need to use the following command:

krun xxx.ll --depth num

The command allows users to see an execution with maximally "num" number of steps. 






