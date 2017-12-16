//
//  main.swift
//  16
//
//  Created by Mark Lively on 12/16/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let start = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]

let test = "s1,x3/4,pe/b"
let testStart =  ["a","b","c","d","e"]

func output(_ input:Array<String>) ->String{
    var temp = ""
    for a in input {
        temp.append(a)
    }
    return temp
}

var current =  start
for t in input.split(separator: ","){
    let s = String(t)
    switch s.first!{
    case "s":
        let n = Int(t.dropFirst())!%current.count
        let a = Array(current[current.count - n ... current.count-1])
        let b = Array(current[0...current.count - n - 1])
        current = a + b
    case "x":
        let temp = s.dropFirst()
        let a = Int(temp.split(separator: "/")[0])!
        let b = Int(temp.split(separator: "/")[1])!
        let letter = current[a]
        current[a] = current[b]
        current[b] = letter
    case "p":
        let temp = String(s.dropFirst())
        let a1 = String(temp.split(separator: "/")[0])
        let b1 = String(temp.split(separator: "/")[1])
        let a = current.index(of: a1)!
        let b = current.index(of: b1)!
        let letter = current[a]
        current[a] = current[b]
        current[b] = letter
    default:
        assert(false)
    }
}
print(output(current))

print("\n\n\n-----\tPart 2\t-----\n\n\n")

// Ugly way.  Ain't nobody got time for that.

//for _ in 0...999999999{
//    var current =  start
//    for t in input.split(separator: ","){
//        let s = String(t)
//        switch s.first!{
//        case "s":
//            let n = Int(t.dropFirst())!%current.count
//            let a = Array(current[current.count - n ... current.count-1])
//            let b = Array(current[0...current.count - n - 1])
//            current = a + b
//        case "x":
//            let temp = s.dropFirst()
//            let a = Int(temp.split(separator: "/")[0])!
//            let b = Int(temp.split(separator: "/")[1])!
//            let letter = current[a]
//            current[a] = current[b]
//            current[b] = letter
//        case "p":
//            let temp = String(s.dropFirst())
//            let a1 = String(temp.split(separator: "/")[0])
//            let b1 = String(temp.split(separator: "/")[1])
//            let a = current.index(of: a1)!
//            let b = current.index(of: b1)!
//            let letter = current[a]
//            current[a] = current[b]
//            current[b] = letter
//        default:
//            assert(false)
//        }
//    }
//}

var mapping = Array<Int>()
for a in current {
    mapping.append(start.index(of: a)!)
}


//guess at how long to repeat
var j = 1
for _ in 0...100{
    for t in input.split(separator: ","){
        let s = String(t)
        switch s.first!{
        case "s":
            let n = Int(t.dropFirst())!%current.count
            let a = Array(current[current.count - n ... current.count-1])
            let b = Array(current[0...current.count - n - 1])
            current = a + b
        case "x":
            let temp = s.dropFirst()
            let a = Int(temp.split(separator: "/")[0])!
            let b = Int(temp.split(separator: "/")[1])!
            let letter = current[a]
            current[a] = current[b]
            current[b] = letter
        case "p":
            let temp = String(s.dropFirst())
            let a1 = String(temp.split(separator: "/")[0])
            let b1 = String(temp.split(separator: "/")[1])
            let a = current.index(of: a1)!
            let b = current.index(of: b1)!
            let letter = current[a]
            current[a] = current[b]
            current[b] = letter
        default:
            assert(false)
        }
    }
    j += 1
    if current == start {break}
}
print(j)

//modulo test
current = start
for _ in 1...j{
    for t in input.split(separator: ","){
        let s = String(t)
        switch s.first!{
        case "s":
            let n = Int(t.dropFirst())!%current.count
            let a = Array(current[current.count - n ... current.count-1])
            let b = Array(current[0...current.count - n - 1])
            current = a + b
        case "x":
            let temp = s.dropFirst()
            let a = Int(temp.split(separator: "/")[0])!
            let b = Int(temp.split(separator: "/")[1])!
            let letter = current[a]
            current[a] = current[b]
            current[b] = letter
        case "p":
            let temp = String(s.dropFirst())
            let a1 = String(temp.split(separator: "/")[0])
            let b1 = String(temp.split(separator: "/")[1])
            let a = current.index(of: a1)!
            let b = current.index(of: b1)!
            let letter = current[a]
            current[a] = current[b]
            current[b] = letter
        default:
            assert(false)
        }
    }
}
print("modulo test")
print(output(start))
print(output(current))

//modulo test 2
current = start
for _ in 1...(1)%j{
    var next = Array<String>()
    for i in mapping{
        next.append(current[i])
    }
    current = next
}
print("modulo test 2")
print(output(start))
print(output(current))

//modulo test 3
current = start
print("modulo test 3")
print(output(start))
for _ in 1...(8){
    for _ in 1...(10)%j{
        var next = Array<String>()
        for i in mapping{
            next.append(current[i])
        }
        current = next
    }
    print(output(current))
}



current = start
print("Billion")
let count = 1000000000 % j
print(count)
for k in 1...(count){
    for t in input.split(separator: ","){
        let s = String(t)
        switch s.first!{
        case "s":
            let n = Int(t.dropFirst())!%current.count
            let a = Array(current[current.count - n ... current.count-1])
            let b = Array(current[0...current.count - n - 1])
            current = a + b
        case "x":
            let temp = s.dropFirst()
            let a = Int(temp.split(separator: "/")[0])!
            let b = Int(temp.split(separator: "/")[1])!
            let letter = current[a]
            current[a] = current[b]
            current[b] = letter
        case "p":
            let temp = String(s.dropFirst())
            let a1 = String(temp.split(separator: "/")[0])
            let b1 = String(temp.split(separator: "/")[1])
            let a = current.index(of: a1)!
            let b = current.index(of: b1)!
            let letter = current[a]
            current[a] = current[b]
            current[b] = letter
        default:
            assert(false)
        }
    }
    j += 1
    print(k, output(current))
}
print(output(current))
