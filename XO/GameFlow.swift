//
//  GameFlow.swift
//  XO
//
//  Created by Jody Clelland on 10/3/21.
//

import Foundation

enum ButtonState: String {
    case cross = "x"
    case circle = "o"
    case none = ""
}

struct GameFlow {
    
    var content: [String: ButtonState] = [:]
    
    private var winningPossibilities: [[String]] = [["00", "01", "02"],
                                                    ["10", "11", "12"],
                                                    ["20", "21", "22"],
                                                    ["00", "10", "20"],
                                                    ["01", "11", "21"],
                                                    ["02", "12", "22"],
                                                    ["00", "11", "22"],
                                                    ["22", "11", "20"]]
    
    func getValue(for key: String) -> ButtonState {
        if let value = content[key] {
            return value
        } else {
            return .none
        }
    }
    
    mutating func setValue(_ state: ButtonState, for key: String) {
        content[key] = state
    }
    func validate() {
        
    }
    
    func isWin() -> Bool {
        
        for possibility in winningPossibilities {
            
            if content[possibility[0]] != nil {

                print(content[possibility[0]] as Any, content[possibility[1]] as Any)
                if content[possibility[0]] == content[possibility[1]], content[possibility[1]] == content[possibility[2]] {
                    return true
                }
            }
                
           
        }
         return false 
    }
}
