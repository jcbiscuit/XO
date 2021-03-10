//
//  Player.swift
//  XO
//
//  Created by Jody Clelland on 10/3/21.
//

import Foundation

enum Player {
    case one
    case two
}

extension Player {
    
    var identity: String {
        switch self {
        case .one:
            return "x"
        default:
            return "o"
        }
    }
    
    mutating func toggle() {
        if self == .one {
            self = .two
        } else {
            self = .one
        }
    }
}
