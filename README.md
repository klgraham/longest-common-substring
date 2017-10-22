# Longest Common Substring

The [longest common substring problem](https://en.wikipedia.org/wiki/Longest_common_substring_problem) is where you want to find the longest string that is a substring of two other strings. For example, the longest common substring of "encyclopedia" and "encyclical" is "ncycl".

This repo contains implementations of the longest common substring algorithm in Swift. There's an implementation based on [suffix arrays](https://en.wikipedia.org/wiki/Suffix_array) and a dynamic programming implementation. The suffix array implementation is largely ported from Robert Sedgewick and Kevin Wayne's textbook [_Algorithms_, 4th edition](http://algs4.cs.princeton.edu). The suffix array algorithm should run in `O(m + n)` time, while the dynamic programming version should run in `O(mn)` time, where `m` and `n` are the lengths of the input strings.
