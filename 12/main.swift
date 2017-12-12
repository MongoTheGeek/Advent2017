//
//  main.swift
//  12
//
//  Created by Mark Lively on 12/12/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

class House {
    let i: Int
    var neighbors: Array<Int>
    var swept: Bool
    
    init(i:Int, neighbors:Array<Int>){
        self.i = i
        self.neighbors = neighbors
        self.swept = false
    }

}

var village = Array<House>()

// Fill Array
for line in input.split(separator: "\n"){
    let words = line.split(separator: " ")
    let i = Int(words[0])!
    var neigh = Array<Int>()
    for s in words[2...words.count-1]{
        if s.suffix(1)==","{
            neigh.append(Int(s.dropLast())!)
        } else {
            neigh.append(Int(s)!)
        }
    }
    village.append(House(i: i, neighbors: neigh))
}

var list = [0]
var i = 0
while i < list.count {
    let house = village[list[i]]
    for n in house.neighbors {
        if !list.contains(n){list.append(n)}
    }
    i += 1
}

print (list.count)



print("\n\n\n-----\tPart 2\t-----\n\n\n")

var group = 0
for h in village {
    if !h.swept {
        group += 1
        list = [h.i]
        i = 0
        while i < list.count {
            let house = village[list[i]]
            for n in house.neighbors {
                if !list.contains(n){list.append(n)}
            }
            house.swept = true
            i += 1
        }
        print(list)
    }
}

print(group)
