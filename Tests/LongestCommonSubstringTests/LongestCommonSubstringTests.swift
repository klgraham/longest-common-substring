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

    static var allTests: [(String, (LongestCommonSubstringTests) -> () -> Void)] = [
        ("testSuffix", testSuffix),
    ]
}


