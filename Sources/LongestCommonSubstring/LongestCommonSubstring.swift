import Foundation

/*
 Longest common prefix (LCP) of the two strings being compared and the index
 at which the LCP starts in the right string.
 */
fileprivate struct LongestCommonPrefix {
    // longest common prefix (LCP)
    let text: String
    
    // Starting index of the LCP in the right string
    let rightStart: Int
}

struct LongestCommonSubstring {
    // Longest common substring (LCS)
    public let text: String
    
    // Starting index of the LCS in the left search string.
    public let leftStart: Int
    
    // Starting index of the LCS in the right search string.
    public let rightStart: Int
}

fileprivate func findLongestCommonPrefix(of s1: Suffix, and s2: Suffix) -> LongestCommonPrefix {
    let shortestSuffixLength = min(s1.length, s2.length)
    
    /*
     The LCP can be no longer than the shortest suffix, so
     compare the chars at i in both suffixes. If the chars are different,
     then the longest common prefix is the substring of s1 on [0, i)
     */
    for i in 0..<shortestSuffixLength {
        if s1.char(at: i) != s2.char(at: i) {
            let text = s1.text
            let substringStart = text.index(text.endIndex, offsetBy: i - text.count)
            return LongestCommonPrefix(text: text.substring(from: substringStart), rightStart: i)
        }
    }
    
    /*
     Since the suffixes are matched up to this point, the longest common prefix
     is the overlap of s1 and s2, up to the position specified by minLength
     */
    let text = s1.text
    let substringStart = text.index(text.endIndex, offsetBy: shortestSuffixLength - text.count)
    return LongestCommonPrefix(text: text.substring(from: substringStart), rightStart: shortestSuffixLength)
}
