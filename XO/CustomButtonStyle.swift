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
            .font(.largeTitle)
            .frame(width: 90, height: 90)
            .padding()
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
