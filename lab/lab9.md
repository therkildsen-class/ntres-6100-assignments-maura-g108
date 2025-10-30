

``` r
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   3.5.2     ✔ tibble    3.2.1
    ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ✔ purrr     1.1.0     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
dna_or_rna <- function(sequence){
   bases <- str_split(sequence, pattern = "") %>%
     unlist() %>%
     unique()
   if (all(bases %in% c("a", "t", "g", "c")) & "t" %in% bases){
     return("DNA")
   } else if (all(bases %in% c("a", "u", "g", "c")) & "u" %in% bases){
     return("RNA")
   } else {
     return("unknown")
   }
 }
```

``` r
dna_or_rna("attggc")
```

    [1] "DNA"

``` r
dna_or_rna("gccaau")
```

    [1] "RNA"

``` r
dna_or_rna("ccagac")
```

    [1] "unknown"

``` r
dna_or_rna("tgcacug")
```

    [1] "unknown"

``` r
sequences = c("ttgaatgccttacaactgatcattacacaggcggcatgaagcaaaaatatactgtgaaccaatgcaggcg", 
              "gauuauuccccacaaagggagugggauuaggagcugcaucauuuacaagagcagaauguuucaaaugcau", 
              "gaaagcaagaaaaggcaggcgaggaagggaagaagggggggaaacc", 
              "guuuccuacaguauuugaugagaaugagaguuuacuccuggaagauaauauuagaauguuuacaacugcaccugaucagguggauaaggaagaugaagacu", 
              "gataaggaagaugaagacutucaggaaucuaauaaaaugcacuccaugaauggauucauguaugggaaucagccggguc")
```

``` r
sequence_type <- vector("double", length(sequences))
for (i in seq_along(sequences)){
  sequence_type[i] <- dna_or_rna(sequences[i])
}
sequence_type
```

    [1] "DNA"     "RNA"     "unknown" "RNA"     "unknown"

``` r
map_chr(sequences, dna_or_rna)
```

    [1] "DNA"     "RNA"     "unknown" "RNA"     "unknown"

``` r
dna_or_rna <- function(sequence){
   bases <- str_split(sequence, pattern = "") %>%
     unlist() %>%
     tolower() %>%
     unique()
   if (all(bases %in% c("a", "t", "g", "c")) & "t" %in% bases){
     return("DNA")
   } else if (all(bases %in% c("a", "u", "g", "c")) & "u" %in% bases){
     return("RNA")
   } else {
     return("unknown")
   }
 }
```

``` r
dna_or_rna("ATTGGC")
```

    [1] "DNA"

``` r
dna_or_rna("gCCAAu")
```

    [1] "RNA"

``` r
dna_or_rna("ggcacgG")
```

    [1] "unknown"

``` r
round_away <- function(x, digits=0){
   x_new<-abs(x*10^digits)
   x_sign <- sign(x)
   integer <- x_new%/%1
   decimal <- x_new-integer
   if(decimal<0.5){
     x_new <- integer
   } else {
     x_new <- integer +1
   }
   x_rounded <- x_new/10^digits*x_sign
   return(x_rounded)
 }
```

``` r
round_away(0.55, digits=0)
```

    [1] 1

``` r
round_away(2.45, digits=0) 
```

    [1] 2

``` r
round_away(-0.55, digits=0)
```

    [1] -1

``` r
round_away(-2.45, digits=0) 
```

    [1] -2

``` r
round_away(0.55, digits=1)
```

    [1] 0.6

``` r
round_away(2.45, digits=1) 
```

    [1] 2.5

``` r
round_away(-0.55, digits=1)
```

    [1] -0.6

``` r
round_away(-2.45, digits=1) 
```

    [1] -2.5

``` r
round_even <- function(x, digits=0){
   x_new<-abs(x*10^digits)
   x_sign <- sign(x)
   integer <- x_new%/%1
   decimal <- x_new-integer
   if(decimal<0.5){
     x_new <- integer
   } else if (decimal ==0.5){
     if(integer%%2==0){
       x_new <- integer 
     } else {
       x_new <- integer +1
     }
   } else {
       x_new <- integer +1
   }
   x_rounded <- x_new/10^digits*x_sign
   return(x_rounded)
 }
```

``` r
round_even(0.55, digits=0)
```

    [1] 1

``` r
round_even(2.45, digits=0) 
```

    [1] 2

``` r
round_even(-0.55, digits=0)
```

    [1] -1

``` r
round_even(-2.45, digits=0) 
```

    [1] -2

``` r
round_even(0.55, digits=1)
```

    [1] 0.6

``` r
round_even(2.45, digits=1) 
```

    [1] 2.4

``` r
round_even(-0.55, digits=1)
```

    [1] -0.6

``` r
round_even(-2.45, digits=1)
```

    [1] -2.4
