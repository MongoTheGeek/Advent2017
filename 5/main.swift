//
//  main.swift
//  5
//
//  Created by Mark Lively on 12/5/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

var count = 0
var i = 0
var array = input.split(separator: "\n").map{Int($0)!}
while i < array.count{
    let temp = i + array[i]
    count += 1
    array[i]+=1
    i = temp
}
print(count)
print("\n\n\n-----\tPart 2\t-----\n\n\n")

count = 0
i = 0
array = input.split(separator: "\n").map{Int($0)!}
while i < array.count{
    let temp = i + array[i]
    count += 1
    array[i] = array[i] >= 3 ? array[i] - 1 : array[i] + 1
    i = temp
}
print(count)
