
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
    
    // Returns the ith smallest suffix
    public func getSuffix(_ i: Int) -> Suffix {
        return suffixes[i]!
    }
}
