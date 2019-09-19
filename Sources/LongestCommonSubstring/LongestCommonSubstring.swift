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
    
    init(of text: String, to end: Int) {
        self.text = text
        self.end = end
    }
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
            let substring = String(text[text.startIndex..<substringEnd])
            return LongestCommonPrefix(of: substring, to: i)
        }
    }
    
    /*
     Since the suffixes are matched up to this point, the longest common prefix
     is the overlap of s1 and s2, up to the position specified by minLength
     */
    let text = s1.text
    let substringEnd = text.index(text.startIndex, offsetBy: shortestSuffixLength)
    let substring = String(text[text.startIndex..<substringEnd])
    return LongestCommonPrefix(of: substring, to: shortestSuffixLength)
}

public func longestCommonSubstring(of left: String, and right: String) -> LongestCommonSubstring {
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
public func longestCommonSubstringDP(of left: String, and right: String) -> String {
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
}

