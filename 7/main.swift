//
//  main.swift
//  7
//
//  Created by Mark Lively on 12/7/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

print("Hello, World!")

class Node {
    var children = Array<Node>()
    let name: String
    let weight: Int
    var parent: Node?
    
    init(_ name:String, _ weight:Int){
        self.name = name
        self.weight = weight
    }
    
    func effective()->Int {
        if children.count == 0 {return weight}
        return children.reduce(weight, {$0 + $1.effective()})
    }
    
    func description() -> String {
            return "\(name), \(weight), \(effective())"
    }
    
    func test() -> Bool {
        var balanced = true
        for c in children{
            balanced = balanced && c.test()
        }
        if children.count > 1 {
            let base = children[0].effective()
            for c in children[1...]{
                if c.effective() != base {
                    print(name,children.map{$0.description()})
                }
            }
        }
        return balanced
    }
}

var nodes = Dictionary<String, Node>()
var children = Array<(String, String)>()

for aline in input.split(separator: "\n"){
    let tokens = aline.split(separator: " ")
    let name = String(tokens[0])
    let weight = Int(String(tokens[1]).trimmingCharacters(in: CharacterSet(charactersIn: "()")))!
    nodes[name] = Node(name,weight)
    if tokens.count > 2 {
        for new in tokens[3...]{
            children.append((String(new).trimmingCharacters(in: CharacterSet(charactersIn: ",")),name))
        }
    }
}

for pair in children{
    let (child, parent) = pair
    nodes[parent]!.children.append(nodes[child]!)
    nodes[child]!.parent = nodes[parent]!
}

var root: Node?
for name in nodes.keys {
    if nodes[name]!.parent == nil {root = nodes[name]}
}

print(root!.name)

print("\n\n\n-----\tPart 2\t-----\n\n\n")

root!.test()
