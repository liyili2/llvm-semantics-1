---
title: Correct by Construction Optimizing Compiler
author: Liyi Li (liyili2), Everett Hildenbrandt (hildenb2)
geometry: margin=2.5cm
format: latex
linestretch: 1.2
fontsize: 10pt
csl: ieee.csl
...


Project
=======

---
requirement: The problem statement and motivation.
length: 1/3 page
...

Algorithmic specifications of compiler optimizations often come with correctness
proofs, but their implementations do not; instead bugs that surface in tests are
uncovered and fixed afterward. Perhaps we could have a correct by construction
optimizing compiler, where the algorithmic proof of correctness carries over to
the compiler implementation.

To have a correct by construction compiler, we could generate the correct C++
(or another appropriate low-level language) directly from the mathematical
description of the algorithm; the trusted code base here is the translator from
the algorithmic language to the execution language. Alternatively, we could
execute the high-level language directly; the execution environment of the
high-level algorithmic language becomes the trusted code base.

We experiment with the idea of a correct by construction optimizing compiler by
providing a tool for writing CFG based optimizations in a high-level algorithmic
language. Our high-level language directly executes instead of generating
low-level code. The focus has been CGF based optimizations; in general it should
be possible to create rewriting logic DSLs for many different classes of
optimizations.


Existing Work
=============

---
requirment: Brief summary of existing work in the literature, with citations.
length: 1/2 page
...

Specifying and Executing Optimizations for Parallel Programs (2014):
:   Mansky et al. define the PTRANS graph-rewriting optimization framework using
    three languages. One language describes simple graph transformations which
    always preserve the well-formedness of GCFGs[^GCFG]. The second language
    describes CTL side-conditions for compiler optimizations[^CTLside]. The
    third language gives a Kleene algebra[^kleene] for specifying optimizations,
    where each optimization is a graph transformation along with a CTL
    side-condition allowing the transformation. [@ptrans-verif-opt]

Proving Correctness of Compiler Optimizations by Temporal Logic (2002):
:   Lacey et al. use CTL to specify the side conditions which must hold to run
    an optimization. They use a simple language with assignments, arithmetic
    expressions, and branches for demonstration. A few optimization
    side-conditions are expressed (for dead-code-elimination, constant folding,
    and code motion). In addition, they provide a way to show that an
    optimization preserves program semantics. [@correct-optim-ctl]

Imperative Program Transformation by Rewriting (2001):
:   Lacey et al. describe an executable rewriting specification of various
    compiler optimizations. The transformations are specified as graph-rewrites,
    with the observation that algebraic matching can be achieved over imperative
    languages as CTL side conditions. Their executable prototype scales to
    hundreds of lines of code. [@imperative-lang-rewrites]

[^GCFG]: Generalized control flow graphs. Basic blocks are instructions and each
    instruction has a type which dictates how it may be used in building GCFGs
    (eg. "an `if` statement must have exactly two outgoing edges").
[^CTLside]: This is the analog to the program analysis phase of compilers.
[^kleene]: This is the analog of the overall optimization of the compiler, where
    the order of analysis and transformations is specified. Kleene algebras
    contain regular expressions, giving quite good expressive power.


Design
======

---
requirement: High-level overview of your algorithm or design.
length: 1 page
...

Optimizing compilers require at least two basic functionalities; program
analysis and program transformation. For program analysis, we are using CTL
side-conditions on the CFG representation of program code. For program
transformation, we are using unification and rewriting over the abstract syntax
of the target language. We express both the CTL and target language syntax in
the K framework, which allows for prototype execution of the rules. Our target
language for optimization is the LLVM IR.

### Program Analysis

We use CTL to reason about graph rewrite feasibility because CTL has an
efficient proof system [@ctl-proof-system] and provides a natural way to reason
about graph structure. To specify a program analysis, one writes down the
corresponding CTL formula.  For example, the CTL formula  
`use(v) /\ def(v,c:Const) <-A not def(v,e) --`  
specifies a node that uses program variable `v` *and* has the constant `c` as
the dominating definition of variable `v` along all backwards paths. This
formula can be used to enable a constant propagation transformation.

Note that the variables `v`, `c`, and `e` in the formula above range over
expressions in the target language. This rule must be instantiated with concrete
expressions from a target program, in general not a trivial process. The CTL
formula thus not only specifies when a transformation is correct to apply
abstractly, but provides concrete substitutions from formula variables to
language expressions when a correct instantiation is found.

### Program Transformation

For transformations, we use instruction rewrite rules defined over the abstract
syntax of the target language coupled with CTL side-conditions on the local CFG.
This is done using unification[^unifInRewrite] of instruction patterns with
concrete instructions in the program.

For example, the full constant propagation optimization is written as follows:  
`I => I[v/c] if use(v) /\ def(v,c:Const) <-A not def(v,e) --`  
The side condition limits the rule to points in the CFG which are safe to
perform constant propagation on. The rewrite `I => I[v/c]` specifies replacement
of occurrences of variable `v` with constant `c` at those points.

[^unifInRewrite]: Unification (or at least matching) is a core component of most
    rewriting-engines. By using a rewriting framework we can assume a
    unification algorithm is available for the abstract syntax of a language.

### Target Language: LLVM

Our target language is LLVM IR. LLVM is a Static Single Assignment (SSA) based
representation that provides type safety, low-level operations, flexibility, and
the capability of representing 'all' high-level languages cleanly. It is the
common code representation used throughout all phases of the LLVM compilation
strategy.[^fromLLVMRefManual] LLVM is a significantly more complicated language
than others for which a correct by construction compiler has been attempted.

[^fromLLVMRefManual]: From the
    [LLVM Reference Manual](http://llvm.org/docs/LangRef.html).

### K Framework

Given these requirements, we need a framework which can express and execute
logical side conditions (for the CTL), as well as perform unification over the
abstract syntax of a target language. The K semantic framework allows the
operational definition of imperative programming languages, which gives a
correct[^wrtSemantics] interpreter for the language. The syntax and semantics of
CTL are defined in K, allowing execution of program analysis, and the syntax and
semantics of some target language are also defined in K allowing unification
over the abstract syntax of the language. [@k-framework]

As unpublished work, the syntax and semantics of LLVM have been defined in the K
framework (though not extensively tested). We are using this definition to
provide predicates over the LLVM language (such as `use(v)` or `def(v,e)`). The
remaining work to be done is to glue the semantics of CTL and LLVM together.
This can be quite cumbersome given some non-modularity issues that K has.

[^wrtSemantics]: Correct with respect to the defined semantics. There can be
    bugs in the defined semantics, the advantage of using K instead of English
    being that the semantics are immediately executable and therefore testable.


Implementation
==============

---
requirement: Implementation details
-   Prior analyses or transformations required by your code.
-   Major code components (passes, data structures, and functions).
-   Testing strategy and status: unit tests, small source programs, larger
    (multi file) source programs of 10K-100K LOC, at least a few of which are of
    50K-100K LOC (as counted by sloccount).
-   Implementation status describing what functionality works and what doesn't
    work, for arbitrary source programs.
-   A description of where to find your source code, executable, and input
    programs, and how to run the executable for example inputs.
length: 1-1.5 pages
...

### CTL Specification

We have defined and lightly tested the semantics of CTL in K. For testing we
have been hand-building graphs where we assign atomic predicates to each node in
the graph, then check if some specific CTL query returns true or false for that
graph. In a full-sized program the nodes of the graph will be generated by
instructions in the code, and the queries will be patterns that must be matched
for an optimization to fire. Note that these patterns include both CTL patterns
(language independent) and instruction patterns (language specific).

To integrate this with a language, we need to define the atomic predicates we
are interested in performing analysis over. This includes things like
`defines(V)` or `uses(V)` for `V` some variable. Given a specific variable, this
is an easy (though tedious) check by recursing into sub-formula on the language
we're optimizing over. Because we're not given specific variables and instead
are trying to find *which variables* will satisfy a given predicate at a given
instruction, this problem becomes harder.

One potential work-around is to do a pre-analysis to grab all the variables that
a specific program mentions, then check the predicates for each variable at each
node. It seems that the ideal solution would be to allow users to use the
concrete syntax of the language being optimized over, then we could use K's
builtin unification algorithms to decide if the instruction-level pattern
matches or not and simultaneously (if it does match) give us the variable
substitution. This would eliminate the need for us to do the pre-analysis, and
yields a sound and complete proof system (of matching logic).

### LLVM Integration

Note that this project does not depend on the LLVM infrastructure (in fact we
are not using any of LLVM code or libraries for this, just the K-defined
semantics of LLVM). LLVM is a good target for this optimization technique
because it's already in CFG form, meaning that the K representation of LLVM is
already close to being in the form needed to analyze with CTL. It would have
been more feasible (for a semester time-scale) to focus on a smaller language.

Integration with the LLVM semantics is still underway. As mentioned above, this
will require many recursive definitions over the structure of the LLVM language
(which is quite a large language) to decide the atomic predicates.


Experimental
============

---
requirement: Experimental results - choose results appropriate for your project,
             again for complete programs.
length: 1-2 pages
...


References
==========

---
requirement: References (as long as necessary; not counted in the 5 pages).
requirement: Appendix: An Extended Example (again, as long as necessary): Use
    part of one of the benchmarks (or design your example based on one of the
    benchmarks) to illustrate what your code does. Choose the example carefully
    to highlight the major technical capabilities and limitations. You can use
    more than one example if needed, but no more than absolutely necessary.
...

---
references:
-   id: ptrans-verif-opt
    author:
    -   family: Mansky
        given: William
    -   family: Griffith
        given: Dennis
    -   family: Gunter
        given: Elsa
    issued:
    -   year: 2014
    title: Specifying and Executing Optimizations for Parallel Programs
    container-title: GRAPH Inspection and Traversal Engineering (GRAPHITE)
-   id: correct-optim-ctl
    author:
    -   family: Lacey
        given: David
    -   family: Jones
        given: Neil D.
    -   family: Van Wyk
        given: Eric
    -   family: Frederiksen
        given: Carl Christian
    issued:
    -   year: 2002
    title: Proving Correctness of Compiler Optimizations by Temporal Logic
    container-title: SIGPLAN Not. 37 (1)
-   id: imperative-lang-rewrites
    author:
    -   family: Lacey
        given: David
    -   family: de Moor
        given: Oege
    issued:
    -   year: 2001
    title: Imperative Program Transformation by Rewriting
    container-title: Lecture Notes in Computer Science
    volume: 2027
-   id: ctl-proof-system
    author:
    -   family: Pnueli
        given: Amir
    -   family: Kesten
        given: Yonit
    issued:
    -   year: 2002
    title: A Deductive Proof System for CTL*
    container-title: Lecture Notes in Computer Science
    volume: 2421
-   id: k-framework
    author:
    -   family: Rosu
        given: Grigore
    -   family: Serbanuta
        given: Traian Florin
    issued:
    -   year: 2010
    title: An Overview of the K Semantic Framework
    container-title: The Journal of Logic and Algebraic Programming
    volume: 79(6)
...
