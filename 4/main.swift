//
//  main.swift
//  4
//
//  Created by Mark Lively on 12/3/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

var count = 0
for aline in input.split(separator: "\n"){
    var good = true
    var words = aline.split(separator: " ")
    while words.count > 1 {
        let word = words.popLast()
        if words.contains(word!) {good = false}
    }
    if good {count += 1}
}

print(count)
print("\n\n\n-----\tPart 2\t-----\n\n\n")

count = 0
for aline in input.split(separator: "\n"){
    var good = true
    var words = aline.split(separator: " ").map { (s) -> String in
        String(s.sorted())
    }
    while words.count > 1 {
        let word = words.popLast()
        if words.contains(word!) {good = false}
    }
    if good {count += 1}
}

print(count)
