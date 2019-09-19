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
        let suffix2 = Suffix(of: "encyclical", from: 1)
        let lcp = findLongestCommonPrefix(of: suffix1, and: suffix2)
        
        XCTAssertEqual(lcp.text, "ncycl")
        XCTAssertEqual(lcp.end, 5)
    }
    
    func testLongestCommonSubstring() {
        let lcs = longestCommonSubstring(of: "i'm henry the eighth i am",
                                             and: "henry the eighth i am i am")
        XCTAssertEqual(lcs.text, "henry the eighth i am")
        XCTAssertEqual(lcs.leftStart, 4)
        XCTAssertEqual(lcs.rightStart, 0)
    }
    
    func testLCSWithEmoji() {
        let s1 = "😀 😁 😂 🤣 😃 😄 😅 😆 😉 😊 😋 😎 😍 😘 👨‍👩‍👧‍👦 🥰 😗 😙 😚 ☺️ 🙂 🤗 🤩 🤔 🤨 😐 😑 😶 🙄 😏 😣 😥 😮 🤐 😯 😪 😫 😴 😌 😛 😜 😝 🤤 😒 😓 😔 😕 🙃 🤑 😲 ☹️ 🙁 😖 😞 😟 😤 😢"

        let s2 = "idyfhadhlfd a;dfhawd👨‍👩‍👧‍👦 🥰 😗 😙 😚 ☺️ 🙂 🤗 🤩 🤔 🤨 😐 😑 😶 🙄 😏 😣 😥 😮 🤐 😯 😪 😫 😴 😌 😛 😜 😝 🤤ldfdsfdsfsad"

        let expected = "👨‍👩‍👧‍👦 🥰 😗 😙 😚 ☺️ 🙂 🤗 🤩 🤔 🤨 😐 😑 😶 🙄 😏 😣 😥 😮 🤐 😯 😪 😫 😴 😌 😛 😜 😝 🤤"
        
        let lcs = longestCommonSubstring(of: s1, and: s2)
        XCTAssertEqual(lcs.text, expected)
    }
    
    func testDPLongestCommonSubstring() {
        let lcs = longestCommonSubstringDP(of: "i'm henry the eighth i am",
                                             and: "henry the eighth i am i am")
        XCTAssertEqual(lcs, "henry the eighth i am")
    }

    static var allTests: [(String, (LongestCommonSubstringTests) -> () -> Void)] = [
        ("testSuffix", testSuffix),
    ]
}


