//
//  main.swift
//  24
//
//  Created by Mark Lively on 12/24/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let test = """
0/2
0/1
10/1
9/10
2/2
2/3
3/4
3/5
"""

let test2 = """
0/3
3/7
7/4
"""
struct component {
    let ports: Array<Int>

    init(_ string:String){
        ports = string.split(separator: "/").map({Int($0)!})
    }
    
    func value()->Int {
        return ports.reduce(0, +)
    }

}

func cobble(_ pieces:Array<component>, join:Int) -> (Int, Array<component>){
    var strength = join
    var outArray = Array<component>()
    var t = -1
    if pieces.count == 0 {return (strength, outArray)}
    for i in 0...pieces.count-1{
        let bit = pieces[i]
        if bit.ports.contains(join){
            var next = 0
            if bit.ports[0] == join { next = bit.ports[1]} else {next = bit.ports[0]}
            var subArray = pieces
            if i == 0 {
                subArray = Array(pieces.dropFirst())
            } else if i == pieces.count - 1 {
                subArray = Array(pieces.dropLast())
            } else {
                subArray = Array(pieces.prefix(i)+pieces.suffix(pieces.count - i - 1))
            }
            let (s,a) = cobble(subArray, join: next)
            if (s + 2*join) > strength {
                strength = 2 * join + s
                outArray = [pieces[i]] + a
                t = i
            }
        }
    }
//    if t != -1 {print(pieces[t],strength)}
    return (strength, outArray)
}

func strength(_ a:Array<component>) -> Int {
    return a.reduce(0, {$0 + $1.value()})
}

func assemble(_ pieces:Array<component>, join:Int) -> Array<Array<component>>{
    var outArray = Array<Array<component>>()
    if pieces.count == 0 {return outArray}
    for i in 0...pieces.count-1{
        let bit = pieces[i]
        if bit.ports.contains(join){
            var temp = [bit]
            var next = 0
            if bit.ports[0] == join { next = bit.ports[1]} else {next = bit.ports[0]}
            var subArray = pieces
            if i == 0 {
                subArray = Array(pieces.dropFirst())
            } else if i == pieces.count - 1 {
                subArray = Array(pieces.dropLast())
            } else {
                subArray = Array(pieces.prefix(i)+pieces.suffix(pieces.count - i - 1))
            }
            let a = assemble(subArray, join: next)
            if a.count == 0 {
                outArray.append([bit])
            } else {
                outArray.append(contentsOf: a.map({temp+$0}))
            }
        }
    }
    //    if t != -1 {print(pieces[t],strength)}
    return outArray
}


let bits = input.split(separator: "\n").map({component(String($0))})
let testBits = test.split(separator: "\n").map({component(String($0))})
let testBits2 = test2.split(separator: "\n").map({component(String($0))})

print(cobble(testBits, join:0))
print(cobble(testBits2, join:0))

let (v,a) = cobble(bits, join: 0)
let t = bits.reduce(0, {$0 + $1.value()})
print(v, a.count, t, bits.count)
print(a)
print("\n\n\n-----\tPart 2\t-----\n\n\n")

let bridges =  assemble(bits, join:0)
//print(bridges)
let b = bridges.sorted(by: {if $0.count == $1.count {return strength($0)>strength($1)} else {return $0.count > $1.count}})[0]
print(b.count, strength(b))
