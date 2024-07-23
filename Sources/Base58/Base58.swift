// The Swift Programming Language
// https://docs.swift.org/swift-book

import BigInt
import Foundation



public enum Base58 {
	private static let btcAlphabet = [UInt8]("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".utf8)
	private static let flickrAlphabet = [UInt8]("123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".utf8)

	private static let bigZero = BigUInt(0)
	private static let bigRadix = BigUInt(58)

	public static func Encode(_ bytes: [UInt8]) -> String {
		return EncodeAlphabet(bytes, btcAlphabet)
	}

	public static func Decode(_ input: String) -> [UInt8]? {
		return DecodeAlphabet(input, btcAlphabet)
	}

	public static func EncodeAlphabet(_ bytes: [UInt8], _ alphabet: [UInt8]) -> String {
		let zero = BigUInt(0)
		let radix = BigUInt(alphabet.count)

		var answer: [UInt8] = []
		var data = BigUInt(Data(bytes))

		while data > 0 {
			let (div, mod) = data.quotientAndRemainder(dividingBy: radix)
			answer.insert(alphabet[Int(mod)], at: 0)
			data = div
		}

		for byte in bytes {
			if byte != 0 {
				break
			}
			answer.append(alphabet.first!)
		}

		//answer.reverse()

		return String(bytes: answer, encoding: String.Encoding.utf8)!
	}

	public static func DecodeAlphabet(_ input: String, _ alphabet: [UInt8]) -> [UInt8]? {
		let inputArray = [UInt8](input.utf8)
		let radix = BigUInt(alphabet.count)
		var answer = BigUInt(0)

		var count = BigUInt(1)

		for char in inputArray.reversed() {
			guard let tmpl = alphabet.firstIndex(of: char) else {
				return nil
			}

			let idx = BigUInt(alphabet.distance(from: alphabet.startIndex, to: tmpl))

			answer += count * idx
			count *= radix
		}

		let temp = answer.serialize()

		var numZeroes = 0
		for char in inputArray {
			if char != alphabet.first {
				break
			}
			numZeroes += 1
		}

		let flen = numZeroes + temp.count
		var val = [UInt8](repeating: 0, count: flen)
		val.replaceSubrange(numZeroes..<flen, with: temp)

		return val

	}
}
