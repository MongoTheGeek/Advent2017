//
//  main.swift
//  25
//
//  Created by Mark Lively on 12/24/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation


enum State{
    case a,b,c,d,e,f
}

var tape = Dictionary<Int, Bool>()
var position = 0
var state = State.a

for _ in 1...12459852{
    var value = false
    if tape.keys.contains(position){
        value = tape[position]!
    } else {
        tape[position] = value
    }
    switch state {
    case .a:
        if value {
            tape[position]=true
            position -= 1
            state = .e
        } else {
            tape[position]=true
            position += 1
            state = .b
        }
    case .b:
        if value {
            tape[position]=true
            position += 1
            state = .f
        } else {
            tape[position]=true
            position += 1
            state = .c
        }
    case .c:
        if value {
            tape[position]=false
            position += 1
            state = .b
        } else {
            tape[position]=true
            position -= 1
            state = .d
        }
    case .d:
        if value {
            tape[position]=false
            position -= 1
            state = .c
        } else {
            tape[position]=true
            position += 1
            state = .e
        }
    case .e:
        if value {
            tape[position]=false
            position += 1
            state = .d
        } else {
            tape[position]=true
            position -= 1
            state = .a
        }
    case .f:
        if value {
            tape[position]=true
            position += 1
            state = .c
        } else {
            tape[position]=true
            position += 1
            state = .a
        }
    }
}

var total = 0
for  k in tape.keys{
    if tape[k]! {total += 1}
}
print(total)
