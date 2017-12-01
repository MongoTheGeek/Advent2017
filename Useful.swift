//
//  Useful.swift
//  1
//
//  Created by Mark Lively on 12/1/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

extension Character {
    var string: String { return String(self) }
}

extension String.CharacterView {
    var string: String { return String(self) }
}

extension Sequence where Iterator.Element == UnicodeScalar {
    var string: String { return String(String.UnicodeScalarView(self)) }
}
extension String {
    func index(at offset: Int) -> Index? {
        precondition(offset >= 0, "offset can't be negative")
        return index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex))
    }
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
    subscript(offset: Int) -> String {
        precondition(offset >= 0, "offset can't be negative")
        guard let character = character(at: offset) else { return "" }
        return String(character)
    }
    subscript(range: Range<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        guard let startIndex = index(at: range.lowerBound) else { return "" }
        return self[startIndex..<(index(startIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    subscript(range: ClosedRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        guard let startIndex = index(at: range.lowerBound) else { return "" }
        return self[startIndex..<(index(startIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    subscript(partialRange: PartialRangeFrom<Int>) -> Substring {
        return self[partialRange.lowerBound..<endIndex.encodedOffset]
    }
    subscript(partialRange: PartialRangeUpTo<Int>) -> Substring {
        return self[startIndex.encodedOffset..<partialRange.upperBound]
    }
    subscript(partialRange: PartialRangeThrough<Int>) -> Substring {
        return self[startIndex.encodedOffset...partialRange.upperBound]
    }
}

//func MD5(string: String) -> Data {
//    let messageData = string.data(using:.utf8)!
//    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
//
//    _ = digestData.withUnsafeMutableBytes {digestBytes in
//        messageData.withUnsafeBytes {messageBytes in
//            CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
//        }
//    }
//
//    return digestData
//}
//

