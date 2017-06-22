import Foundation

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

//public func findLongestCommonSubstring(of s1: String, and s2: String) -> LongestCommonSubstring {
//
//}

