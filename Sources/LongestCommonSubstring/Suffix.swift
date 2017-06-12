import Foundation

/*
 A suffix of a string.
 A suffix of a string is any substring that includes the last letter of the
 string.
 
 Reference: https://en.wikipedia.org/wiki/Substring#Suffix
 */
public struct Suffix {
    public let text: String
    
    public init(of text: String, from index: Int) {
        let suffixStart = text.index(text.endIndex, offsetBy: index - text.count)
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
