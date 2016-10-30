//: Playground - noun: a place where people can play

import UIKit

class Item {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let myArrayOfItemArrays = [[Item(name: "A")], [Item(name: "B")], [Item(name: "C")]]

// print out the name of all of the items in the above array
myArrayOfItemArrays.count
for i in 0..<myArrayOfItemArrays.count {
    print (myArrayOfItemArrays[i][0].name)
}