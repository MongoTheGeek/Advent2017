//
//  main.swift
//  21
//
//  Created by Mark Lively on 12/21/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let base = [".#./..#/###"]

let test = """
../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#
"""

var mapping = Dictionary<String, String>()

func flip(_ input:String)->Array<String> {
    let l = input.split(separator: "/")
    var outPut = [input]
    outPut.append(l.reversed().joined(separator: "/"))
    outPut.append(l.map({String($0.reversed())}).joined(separator: "/"))
    outPut.append(l.reversed().map({String($0.reversed())}).joined(separator: "/"))
    return outPut
}

func permute(_ rules:String)->Dictionary<String, String>{
    var output = Dictionary<String, String>()
    for line in rules.split(separator:"\n"){
        let c = line.split(separator:" ")[0].replacingOccurrences(of: "/", with: "").map{String($0)}
        let outPat = String(line.split(separator:" ")[2])
//because we have to do 2 first this doesn't work
//        if c.count == 9 {
//            let l = outPat[0].split(separator: "/")
//            outPat = [l[0].prefix(2)+"/"+l[1].prefix(2)]
//            outPat.append(l[0].suffix(2)+"/"+l[1].suffix(2))
//            outPat.append(l[2].prefix(2)+"/"+l[3].prefix(2))
//            outPat.append(l[2].suffix(2)+"/"+l[3].suffix(2))
//        }
        var inPat = Array<String>()
        if c.count == 4 {
            inPat.append(contentsOf: flip(c[0]+c[1]+"/"+c[2]+c[3]))
            inPat.append(contentsOf: flip(c[1]+c[3]+"/"+c[0]+c[2]))
        } else {
            inPat.append(contentsOf: flip(c[0]+c[1]+c[2]+"/"+c[3]+c[4]+c[5]+"/"+c[6]+c[7]+c[8]))
            inPat.append(contentsOf: flip(c[2]+c[5]+c[8]+"/"+c[1]+c[4]+c[7]+"/"+c[0]+c[3]+c[6]))
        }
        for i in inPat{
            if !output.keys.contains(i){
                output[i]=outPat
            }
        }
    }
    return output
}

//
// niaeve stupid and wrong.
//func replace(_ input:Array<String>) ->Array<String>{
//    var output = Array<String>()
//    for i in input{
//        output.append(contentsOf: mapping[i]!)
//    }
//    return output
//}

func replace(_ input:Array<String>) ->Array<String>{
    var output = Array<String>()
    for i in input{
        if i.count == 11 {
            output.append(mapping[i]!)
        } else {
            let l = i.split(separator: "/")
            if l.count == 4 {
                var temp1 = mapping[l[0].prefix(2)+"/"+l[1].prefix(2)]!.split(separator: "/")
                var temp2 = mapping[l[0].suffix(2)+"/"+l[1].suffix(2)]!.split(separator: "/")
                var temp3 = mapping[l[2].prefix(2)+"/"+l[3].prefix(2)]!.split(separator: "/")
                var temp4 = mapping[l[2].suffix(2)+"/"+l[3].suffix(2)]!.split(separator: "/")
                let ol1 = [temp1[0], temp2[0], "/", temp1[1], temp2[1], "/", temp1[2], temp2[2]].joined()
                let ol2 = [temp3[0], temp4[0], "/", temp3[1], temp4[1], "/", temp3[2], temp4[2]].joined()
                output.append(ol1 + "/" + ol2)
            } else if l.count == 6 {
                output.append(mapping[l[0].prefix(2)+"/"+l[1].prefix(2)]!)
                output.append(mapping[l[0].suffix(2)+"/"+l[1].suffix(2)]!)
                output.append(mapping[l[2].prefix(2)+"/"+l[3].prefix(2)]!)
                output.append(mapping[l[2].suffix(2)+"/"+l[3].suffix(2)]!)
                output.append(mapping[l[4].prefix(2)+"/"+l[5].prefix(2)]!)
                output.append(mapping[l[4].suffix(2)+"/"+l[5].suffix(2)]!)
                let t0 = l[0].dropFirst(2)
                let t2 = l[2].dropFirst(2)
                let t4 = l[4].dropFirst(2)
                output.append(mapping[t0.prefix(2)+"/"+(l[1].dropFirst(2)).prefix(2)]!)
                output.append(mapping[t2.prefix(2)+"/"+(l[3].dropFirst(2)).prefix(2)]!)
                output.append(mapping[t4.prefix(2)+"/"+(l[5].dropFirst(2)).prefix(2)]!)
       } else {
                assert(false)
            }
        }
    }
    return output
}


mapping = permute(test)
var next = replace(base)
next = replace(next)
print(next.joined().reduce(0, {$0 + ($1 == "#" ? 1 : 0)}))

mapping = permute(input)
next = base
print("\n\n\n------------------------------\n\n\n")
for i in 1...5 {
    next = replace(next)
    print(i, next.count, next.joined().reduce(0, {$0 + ($1 == "#" ? 1 : 0)}))
}
print(next.joined().reduce(0, {$0 + ($1 == "#" ? 1 : 0)}))


print("\n\n\n-----\tPart 2\t-----\n\n\n")

next = base

for i in 1...18 {
    next = replace(next)
    print(i, next.count, next.joined().reduce(0, {$0 + ($1 == "#" ? 1 : 0)}))
}
print(next.joined().reduce(0, {$0 + ($1 == "#" ? 1 : 0)}))
