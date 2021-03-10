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

struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 1) {
            
            ForEach(0...2, id: \.self) { i in
                HStack(spacing: 1) {
                ForEach(0...2, id: \.self) { j in
                                           Button(action: {
                                           
                                           }, label: {
                                           Text("x")
                                           })
                                           .buttonStyle(CustomButtonStyle())
            }
            }
        }
        }.background(Color.red) //changes border color of box selected
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
            .frame(width: 80, height: 80)
            .padding()
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
