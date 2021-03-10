//
//  Player.swift
//  XO
//
//  Created by Jody Clelland on 10/3/21.
//

import Foundation

enum Player: String {
    case one = "x"
    case two = "o"
}

extension Player {
    
    mutating func toggle() {
        if self == .one {
            self = .two
        } else {
            self = .one
        }
    }
}
