//
//  Useful.swift
//  1
//
//  Created by Mark Lively on 12/1/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation
import Security

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

    func md5() -> String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        var hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }
    
    func toMD5()  -> String {
        
        if let messageData = self.data(using:String.Encoding.utf8) {
            var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
            
            _ = digestData.withUnsafeMutableBytes {digestBytes in
                messageData.withUnsafeBytes {messageBytes in
                    CC_MD5(messageBytes, CC_LONG((messageData.count)), digestBytes)
                }
            }
            return digestData.hexString()
        }
        
        return self
    }
}

extension Data {
    
    func hexString() -> String {
        let string = self.map{ String($0, radix:16) }.joined()
        return string
    }
    
}

func knotHash(_ input:String) -> String {
    var hash = Array<Int>()
    let max = 256
    var input2 = Array<Int>()
    for c in input{
        input2.append(Int(String(c).cString(using: .ascii)![0]))
    }
    
    input2.append(contentsOf: [17, 31, 73, 47, 23])

    for i in 0...max-1{
        hash.append(i)
    }
    var skip = 0
    var position = 0
    for _ in 1...64 {
        for l in input2{
            if l <= max {
                if position + l > max {
                    let temp1 = hash.prefix(position + l - max)
                    let temp2 = hash.suffix(max - position)
                    let temp3 = Array(hash.dropFirst(position + l - max).dropLast(max-position))
                    let temp4 = Array((temp2 + temp1).reversed())
                    hash = Array(temp4.dropFirst(max - position)) + temp3 + Array(temp4.prefix(max - position))
                } else {
                    let temp1 = hash.prefix(position)
                    let temp2 = Array(hash.dropFirst(position).prefix(l).reversed())
                    let temp3 = hash.suffix(max-position-l)
                    hash = temp1 + temp2 + temp3
                }
                position = (position + l + skip) % max
                skip += 1
            }
        }
    }
    var output = ""
    for i in 0...15 {
        let sub = hash[(i*16)...(i*16+15)]
        let reduced = sub.reduce(0, ^)
        output.append(String(format:"%02x", reduced))  //leading 0s  thank you Reddit
    }
    return output
}

