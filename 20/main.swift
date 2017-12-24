//
//  main.swift
//  20
//
//  Created by Mark Lively on 12/20/17.
//  Copyright © 2017 Livelys. All rights reserved.
//

import Foundation

struct particle {
    let id:Int
    let px:Int
    let py:Int
    let pz:Int
    let vx:Int
    let vy:Int
    let vz:Int
    let ax:Int
    let ay:Int
    let az:Int
    //p=<-4897,3080,2133>, v=<-58,-15,-78>, a=<17,-7,0>
    init(_ line:String, id: Int) {
        let words = line.split(separator: " ")
        let position = words[0].split(separator: ",")
        let velocity = words[1].split(separator: ",")
        let accelleration = words[2].split(separator: ",")
        self.px = Int(position[0].dropFirst(3))!
        self.py = Int(position[1])!
        self.pz = Int(position[2].dropLast())!

        self.vx = Int(velocity[0].dropFirst(3))!
        self.vy = Int(velocity[1])!
        self.vz = Int(velocity[2].dropLast())!

        self.ax = Int(accelleration[0].dropFirst(3))!
        self.ay = Int(accelleration[1])!
        self.az = Int(accelleration[2].dropLast())!
        
        self.id = id
    }

    func accMan()->Int {
        return abs(ax)+abs(ay)+abs(az)
    }
    
    func distMan(t:Int)->Int{
        let x = px + t * vx + t * (t + 1) * ax / 2
        let y = py + t * vy + t * (t + 1) * ay / 2
        let z = pz + t * vz + t * (t + 1) * az / 2
        return abs(x)+abs(y)+abs(z)
    }
    
    func position(at:Int)->(Int,Int,Int){
        let x = px + at * vx + at * (at + 1) * ax / 2
        let y = py + at * vy + at * (at + 1) * ay / 2
        let z = pz + at * vz + at * (at + 1) * az / 2
        return (x,y,z)
    }
}
var i = 0
var array = Array<particle>()
for line in input.split(separator: "\n"){
    array.append(particle(String(line), id:i))
    i+=1
}

var t = 1000
for _ in 1...10 {
    t *= 2
    print(array.sorted(by:{$0.distMan(t:t) < $1.distMan(t:t)})[0].id)
}


print("\n\n\n-----\tPart 2\t-----\n\n\n")

//let test2 = """
//p=<-6,0,0>, v=<3,0,0>, a=<0,0,0>
//p=<-4,0,0>, v=<2,0,0>, a=<0,0,0>
//p=<-2,0,0>, v=<1,0,0>, a=<0,0,0>
//p=<3,0,0>, v=<-1,0,0>, a=<0,0,0>
//"""
//
//array = Array<particle>()
//for line in test2.split(separator: "\n"){
//    array.append(particle(String(line), id:i))
//    i+=1
//}
//

print(array.count)
for t in 0...400{
    var posArray = Array<(Int,(Int,Int,Int))>()
    var delArray = Array<Int>()
    for particle in array {
        let pos = particle.position(at: t)
        for particle2 in posArray{
            let (id, (x, y, z)) = particle2
            let (x1, y1, z1) = pos
            if x == x1 && y == y1 && z == z1 {
                print("Bang!!!\(id), \(particle.id)")
                if !delArray.contains(id){delArray.append(id)}
                delArray.append(particle.id)
            }
        }
        posArray.append((particle.id, pos))
    }
    array = array.filter({!delArray.contains($0.id)})
    print(array.count)
}


