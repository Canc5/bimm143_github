# Class 6: R functions
Canbin Cai (PID: A18087473)

- [1. Function basics](#1-function-basics)
- [2. Generate DNA sequence](#2-generate-dna-sequence)
- [3. Generate Protein function](#3-generate-protein-function)

## 1. Function basics

Let’s start writing our first silly function to add some numbers:

Every R function has 3 things:

- name (we get to pick this)
- input arguments (there can loads of these seperated by a comma)
- the body (the R code that does the work)

``` r
add <- function(x, y=10, z=0){
  x + y + z
}
```

I can just use this function like any other function as long as R knows
about it (i.e. run the code chunk)

``` r
add(1, 100)
```

    [1] 101

``` r
add( x=c(1,2,3,4), y=100)
```

    [1] 101 102 103 104

``` r
add(1)
```

    [1] 11

Functions can have “required” input arguments and “optional” input
arguments. The optional arguments are defined with an equals default
value (`y=10`) in the function defination.

``` r
add(x=1, y=100, z=10)
```

    [1] 111

> Q. Write a function to return a DNA sequence of a user specified
> lenght? Call it `generate_dna()`

The `sample()` function can help here

``` r
#generate_dna <- function(size=5) { }

students <- c("jeff", "jeremy", "peter")

sample(students, size = 5, replace=TRUE)
```

    [1] "peter"  "jeff"   "jeremy" "jeremy" "jeff"  

## 2. Generate DNA sequence

Now work with `bases` rather than `students`

``` r
bases <- c("A", "C", "G", "T")
sample(bases, size=10, replace=TRUE)
```

     [1] "C" "C" "C" "C" "C" "A" "G" "C" "G" "T"

Now I have a working ‘snippet’ of code I can use this as the body of my
first function version here:

``` r
generate_dna <- function(size=5) {
  bases <- c("A", "C", "G", "T")
  sample(bases, size=size, replace=TRUE) 
}
```

``` r
generate_dna(100)
```

      [1] "A" "A" "C" "A" "T" "C" "C" "T" "A" "A" "A" "C" "C" "G" "A" "G" "T" "C"
     [19] "C" "T" "A" "A" "A" "T" "C" "A" "T" "C" "G" "C" "A" "C" "T" "A" "G" "C"
     [37] "T" "C" "G" "A" "C" "T" "G" "A" "T" "C" "C" "C" "G" "A" "T" "T" "T" "C"
     [55] "G" "G" "T" "G" "C" "A" "C" "G" "T" "G" "A" "G" "C" "A" "C" "A" "A" "G"
     [73] "G" "C" "G" "T" "T" "A" "A" "C" "G" "G" "G" "C" "A" "C" "T" "A" "C" "G"
     [91] "G" "C" "T" "G" "C" "G" "C" "A" "G" "C"

``` r
generate_dna()
```

    [1] "G" "C" "T" "T" "T"

I want the ability to return a sequence like “AGTACCTG” i.e. a one
element vector where the bases are all together.

``` r
generate_dna <- function(size=5, together=TRUE) {
  bases <- c("A", "C", "G", "T")
  sequence <- sample(bases, size=size, replace=TRUE) 
  
  if(together) {
   sequence <- paste(sequence, collapse = "") 
  }
  return(sequence) 
}
```

``` r
generate_dna()
```

    [1] "ATCCT"

``` r
generate_dna(together = F)
```

    [1] "A" "A" "A" "G" "A"

## 3. Generate Protein function

> Q. Write a protein sequence generating function that will return
> sequences of a user specifed length?

We can get the set of 20 natural amino-acids from the **bio3d** package.

``` r
aa <- bio3d::aa.table$aa1[1:20]
```

``` r
generate_protein <- function(size=6, together=TRUE) {
  
  ## Get the 20 amino-acids as a vector
  aa <- bio3d::aa.table$aa1[1:20]
  sequence <- sample(aa, size, replace=TRUE)
  
  ## Optionally return a single element string 
  if(together) {
    sequence <- paste(sequence, collapse = "")
  }
  return(sequence)
}
```

> Q. Generate random protein sequences of length 6 to 12 amino acids.

``` r
generate_protein(7)
```

    [1] "MTYYQCQ"

``` r
generate_protein(8)
```

    [1] "HSRCLDYE"

``` r
generate_protein(9)
```

    [1] "FSQQWKEAC"

``` r
# generate_protein(size=6:12)
```

We can fix this inability to generate multiple sequences by either
editing and adding to the function body code (e.g. a for loop) or by
using the R **apply** family of utility functions.

``` r
sapply(6:12, generate_protein)
```

    [1] "WDWMSV"       "IRAWWTR"      "VGAWVRHH"     "SNGSSIGNT"    "TIDGFFMRKD"  
    [6] "TMFAGLLWESH"  "DPGSTYFWHGEP"

It would cool and useful if I could get FASTA format output.

``` r
ans <- sapply(6:12, generate_protein)
ans
```

    [1] "QNHYGI"       "DNTCHWT"      "WIVWIWWE"     "MIGYSVESC"    "MGSCDLRMPW"  
    [6] "SEIIKFDKPPE"  "CVYQMICRKWAA"

``` r
cat(ans, sep="\n")
```

    QNHYGI
    DNTCHWT
    WIVWIWWE
    MIGYSVESC
    MGSCDLRMPW
    SEIIKFDKPPE
    CVYQMICRKWAA

I want this to look like FASTA format with an ID line. e.g. 

    >ID.6
    IHPQPQ
    >ID.7
    VCLEIQD
    >ID.8
    CWLCYGHC

The functions `paste()` and `cat()` can help us here…

``` r
cat( paste(">ID.", 6:12, "\n", ans, sep=""), sep="\n" )
```

    >ID.6
    QNHYGI
    >ID.7
    DNTCHWT
    >ID.8
    WIVWIWWE
    >ID.9
    MIGYSVESC
    >ID.10
    MGSCDLRMPW
    >ID.11
    SEIIKFDKPPE
    >ID.12
    CVYQMICRKWAA

``` r
id.line <- paste(">ID.", 6:12, sep="")
id.line
```

    [1] ">ID.6"  ">ID.7"  ">ID.8"  ">ID.9"  ">ID.10" ">ID.11" ">ID.12"

``` r
id.line <- paste(">ID.", 6:12, sep="")
seq.line <- paste(id.line, ans, sep="\n")
cat(seq.line, sep="\n", file="myseq.fa") 
```

> Q. Determine if these sequences can be found in nature or are they
> unique? Why or why not?

I BLASTp searched my FASTA format sequences against NR and found that
length 6 and 7 are not unique and can be found in the databases with
100% coverage and 100% identity.

Random sequences of length 8 and above are unique and can’t be found in
the databases.
