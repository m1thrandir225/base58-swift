import XCTest
import Base58
@testable import Base58

final class Base58Tests: XCTestCase {
	public func testValidEncoding() {
		let validStrings = [
			("abc", "ZiCa"),
			("james gunn", "6yeTtvV5Qn7Txq"),
			("ponedelnik", "7KNn1g3GGv6A9Y"),
			("August, 1990", "2EeR7kjrvkHYsiUJb"),
			("https://sebastijanzindl.me", "4CWoMo83vssWvriSEmmdamCmnVVijBMf91pY")
		]
		for (initial, encoded) in validStrings {
			let bytes = [UInt8](initial.utf8)
			let result = Base58.Encode(bytes)
			XCTAssertEqual(result, encoded)
		}
		
		
	}
	
	public func testInvalidEncoding() {
		 let invalid = [
			"0",
			"#$!@-=_+~`",
			"123l456",
			"mnopqr(s)",
			"abcdefgh*",
			"1234567890",
			"1I234",
		]
		
		for string in invalid {
			let result = Base58.Decode(string)
			XCTAssertNil(result)
		}
	}
}
