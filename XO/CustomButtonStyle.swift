//
//  CustomButtonStyle.swift
//  XO
//
//  Created by Jody Clelland on 10/3/21.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle).font(.system(size: 14, weight: .bold))
            .frame(width: 90, height: 90)
            .padding()
            .foregroundColor(.blue)
            .background(Color.black)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
