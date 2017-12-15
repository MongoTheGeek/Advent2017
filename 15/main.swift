//
//  main.swift
//  15
//
//  Created by Mark Lively on 12/15/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

let input = [591, 393]
let test = [65, 8921]
let factors = [16807, 48271]
let modulo = [2147483647, 2147483647]

var values = input

func update(_ array:Array<Int>)->Array<Int>{
    var output = Array<Int>()
    for i in 0...array.count-1{
        output.append(array[i]*factors[i]%modulo[i])
    }
    return output
}

func judge(_ a:Int, _ b:Int) -> Bool{
    return (a%65536 == b%65536)
}


var count=0
for _ in 0...39999999{
    values = update(values)
    if (judge(values[0],values[1])){count+=1}
}
print(count)


print("\n\n\n-----\tPart 2\t-----\n\n\n")

let check = [4, 8]
func updateWithCheck(_ array:Array<Int>)->Array<Int>{
    var output = Array<Int>()
    for i in 0...array.count-1{
        var n = array[i]
        repeat{
            n = n * factors[i] % modulo[i]
        } while (n % check[i]) != 0
        output.append(n)
    }
    return output
}

count=0
for _ in 0...4999999{
    values = updateWithCheck(values)
    if (judge(values[0],values[1])){count+=1}
}
print(count)
