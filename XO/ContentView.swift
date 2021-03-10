//
//  ContentView.swift
//  XO
//
//  Created by Jody Clelland on 10/3/21.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        
        Image("arrows")
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: animate ? nil : 45, height: animate ? nil: 45)
            .scaleEffect(animate ? 3 : 1)
            .frame(width: UIScreen.main.bounds.width)
            
            
            .ignoresSafeArea(.all, edges: .all)
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
        
        
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(Animation.easeOut(duration: 1.0)) {
                animate.toggle()
            }
        }
        
    }
}


enum Player: String {
    case one
    case two
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

struct ContentView: View {
    
   // @State var remember: String = ""
    @State var viewModel = GameFlow()
    
    @State var player: Player = .one
    
    var body: some View {
        VStack(spacing: 10){
            
        Text("Noughts and Crosses")
            .font(.largeTitle)
            .bold()
            
            Spacer()
            
        VStack(spacing: 1) {
            
            ForEach(0...2, id: \.self) { i in
                HStack(spacing: 1) {
                ForEach(0...2, id: \.self) { j in
                                           Button(action: {
                                            //self.remember = "\(i)\(j)"
                                            self.buttonTapped(key: "\(i)\(j)")
                                           }, label: {
                                            Text(self.getValue(key: "\(i)\(j)"))
//                                            Text(self.remember == "\(i)\(j)" ? "x" : "")
                                           })
                                           .buttonStyle(CustomButtonStyle())
            }
            }
        }
        }
        .background(Color.red) //changes border color of box selected
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Spacer()
                Text("New game")
                    .bold()
                    .foregroundColor(.black)
                Spacer()
                
            }).padding()
            .background(Color.purple)
            .cornerRadius(20)
            .padding()
}
}
    
    func buttonTapped(key: String) {
        if player == .one {
            viewModel.setValue(.cross, for: key)
        } else {
            viewModel.setValue(.circle, for: key)
        }
        player.toggle()
    }
    
    func getValue(key: String) -> String {
        viewModel.getValue(for: key).rawValue
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
    }
    
   
}

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

enum ButtonState: String {
    case cross = "x"
    case circle = "o"
    case none = ""
}

struct GameFlow {
    
    var content: [String: ButtonState] = [:]
    
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
}
