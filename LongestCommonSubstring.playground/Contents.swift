//: Playground - noun: a place where people can play

import Foundation

// Mark: Suffix
/*
 A suffix of a string.
 A suffix of a string is any substring that includes the last letter of the
 string.
 
 Reference: https://en.wikipedia.org/wiki/Substring#Suffix
 */
public struct Suffix {
    public let text: String
    public let start: Int
    
    public init(of text: String, from i: Int) {
        let suffixStart = text.index(text.startIndex, offsetBy: i)
        self.text = text.substring(from: suffixStart)
        self.start = i
    }
    
    public var length: Int {
        return text.count
    }
    
    // Return the char at the specified index
    public func char(at i: Int) -> Character {
        let charIndex = text.index(text.startIndex, offsetBy: i)
        return text[charIndex]
    }
}

extension Suffix: Comparable, CustomStringConvertible {
    public static func < (lhs: Suffix, rhs: Suffix) -> Bool {
        return lhs.text < rhs.text
    }
    
    public func isBefore(_ s: Suffix) -> Bool {
        return self < s
    }
    
    public var description: String {
        return text
    }
    
    public static func ==(lhs: Suffix, rhs: Suffix) -> Bool {
        return lhs.text == rhs.text
    }
}

// Mark: Suffix Array

/*
 A sorted array of a string's suffixes. See https://en.wikipedia.org/wiki/Suffix_array and
 
 Section 6.3 of Algorithms, 4th Edition, by Robert Sedgewick and Kevin Wayne:
 http://algs4.cs.princeton.edu/63suffix
 */

public struct SuffixArray {
    private var suffixes: [Suffix?]
    
    public init(from parent: String) {
        let n = parent.count
        suffixes = [Suffix?](repeating: nil, count: n)
        
        for i in 0..<n {
            suffixes[i] = Suffix(of: parent, from: i)
        }
        
        suffixes.sort(by: {$0! < $1!})
    }
    
    public var length: Int {
        return suffixes.count
    }
    
    // Returns the ith smallest suffix, since the suffixes are ordered
    public func getSuffix(_ i: Int) -> Suffix {
        return suffixes[i]!
    }
}

// Mark: Suffix-Array implementation of Longest Common Substring algorithm

/*
 Longest common prefix (LCP) of the two strings being compared and the index
 at which the LCP ends in both strings.
 */
public struct LongestCommonPrefix {
    // longest common prefix (LCP)
    let text: String
    
    // Ending index of the LCP
    let end: Int
}

public struct LongestCommonSubstring {
    // Longest common substring (LCS)
    public let text: String
    
    // Starting index of the LCS in the left search string.
    public let leftStart: Int
    
    // Starting index of the LCS in the right search string.
    public let rightStart: Int
}

// Finds the longest common prefix of two suffixes.
public func findLongestCommonPrefix(of s1: Suffix, and s2: Suffix) -> LongestCommonPrefix {
    let shortestSuffixLength = min(s1.length, s2.length)
    
    /*
     The LCP can be no longer than the shortest suffix, so
     compare the chars at i in both suffixes. If the chars are different,
     then the longest common prefix is the substring of s1 on [0, i)
     */
    for i in 0..<shortestSuffixLength {
        if s1.char(at: i) != s2.char(at: i) {
            let text = s1.text
            let substringEnd = text.index(text.startIndex, offsetBy: i)
            return LongestCommonPrefix(text: text.substring(to: substringEnd), end: i)
        }
    }
    
    /*
     Since the suffixes are matched up to this point, the longest common prefix
     is the overlap of s1 and s2, up to the position specified by minLength
     */
    let text = s1.text
    let substringEnd = text.index(text.startIndex, offsetBy: shortestSuffixLength)
    return LongestCommonPrefix(text: text.substring(to: substringEnd), end: shortestSuffixLength)
}

public func findLongestCommonSubstring(of left: String, and right: String) -> LongestCommonSubstring {
    let leftLength = left.count
    let rightLength = right.count
    let leftSuffixes = SuffixArray(from: left)
    let rightSuffixes = SuffixArray(from: right)
    
    var lcs = ""
    var j = 0
    var k = 0
    var leftSuffix: Suffix
    var rightSuffix: Suffix
    var leftStart = 0
    var rightStart = 0
    
    while j < leftLength && k < rightLength {
        leftSuffix = leftSuffixes.getSuffix(j)
        rightSuffix = rightSuffixes.getSuffix(k)
        
        let lcp = findLongestCommonPrefix(of: leftSuffix, and: rightSuffix)
        
        /*
         If the LCP of the suffixes is longer than the LCS that has been found
         so far, then we've found a longer substring. In this case, we update
         the LCS.
         */
        if lcp.text.count > lcs.count {
            lcs = lcp.text
            leftStart = leftSuffix.start
            rightStart = rightSuffix.start
        }
        
        if leftSuffix.isBefore(rightSuffix) {
            j += 1
        } else {
            k += 1
        }
    }
    return LongestCommonSubstring(text: lcs, leftStart: leftStart, rightStart: rightStart)
}

// Mark: Dynamic Programming implementation of Longest Common Substring algorithm

// A Swift port of: https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Longest_common_substring#Python
public func findLongestCommonSubstringDP(of left: String, and right: String) -> String {
    let leftLength = left.count
    let rightLength = right.count
    
    var m: [[Int]] = Array(repeating: Array(repeating: 0, count: rightLength + 1), count: leftLength + 1)
    var lcsLeftEnd = 0
    var lcsLength = 0
    
    for i in 1..<(leftLength + 1) {
        for j in 1..<(rightLength + 1) {
            let leftChar = left[left.index(left.startIndex, offsetBy: i-1)]
            let rightChar = right[right.index(right.startIndex, offsetBy: j-1)]
            
            if leftChar == rightChar {
                m[i][j] = 1 + m[i-1][j-1]
                
                if m[i][j] > lcsLength {
                    lcsLength = m[i][j]
                    lcsLeftEnd = i
                }
            } else {
                m[i][j] = 0
            }
        }
    }
    
    let lcsLeftStartIndex = left.index(left.startIndex, offsetBy: lcsLeftEnd - lcsLength)
    let lcsLeftEndIndex = left.index(left.startIndex, offsetBy: lcsLeftEnd)
    return String(left[lcsLeftStartIndex..<lcsLeftEndIndex])
    //    return LongestCommonSubstring(text: lcsText, leftStart: lcsLeftEnd - lcsLength, )
}


