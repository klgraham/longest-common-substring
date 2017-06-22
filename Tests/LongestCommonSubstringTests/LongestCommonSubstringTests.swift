import XCTest
@testable import LongestCommonSubstring


class LongestCommonSubstringTests: XCTestCase {
    func testSuffix() {
        let s1 = Suffix(of: "car", from: 0)
        let s2 = Suffix(of: "car", from: 1)
        
        XCTAssertEqual(s1.char(at: 1), "a")
        XCTAssertTrue(s2 < s1)        
    }
    
    func testSuffixArray() {
        let s = SuffixArray(from: "banana")
        
        var previousSuffix = s.getSuffix(0)
        var suffixArrayIsSorted = true
        
        for i in 1..<s.length {
            suffixArrayIsSorted = suffixArrayIsSorted && previousSuffix < s.getSuffix(i)
            previousSuffix = s.getSuffix(i)
        }
        XCTAssertTrue(suffixArrayIsSorted)
    }
    
    func testLongestCommonPrefix() {
        let suffix1 = Suffix(of: "encyclopedia", from: 1)
        print("Suffix 1: \(suffix1)")
        let suffix2 = Suffix(of: "encyclical", from: 1)
        print("Suffix 2: \(suffix2)")
        
        
        let lcp = findLongestCommonPrefix(of: suffix1, and: suffix2)
        print(lcp)
        XCTAssertEqual(lcp.text, "ncycl")
        XCTAssertEqual(lcp.end, 5)
    }

    static var allTests: [(String, (LongestCommonSubstringTests) -> () -> Void)] = [
        ("testSuffix", testSuffix),
    ]
}


