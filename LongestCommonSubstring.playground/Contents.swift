//: Playground - noun: a place where people can play

import Foundation

public struct Suffix {
    public let text: String
    
    public init(of text: String, from i: Int) {
        let suffixStart = text.index(text.startIndex, offsetBy: i)
        self.text = text.substring(from: suffixStart)
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
    
    public var description: String {
        return text
    }
    
    public static func ==(lhs: Suffix, rhs: Suffix) -> Bool {
        return lhs.text == rhs.text
    }
}

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
    
    // Returns the ith smallest suffix
    public func getSuffix(_ i: Int) -> Suffix {
        return suffixes[i]!
    }
}


