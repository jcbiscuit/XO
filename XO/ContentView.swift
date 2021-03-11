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
    
    @State var viewModel = GameFlow()
    
    @State var player: Player = .one
    
    @State var wonPlayer: String = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
        VStack(spacing: 10){
            
        Text("Noughts and Crosses")
            .font(.largeTitle)
            .fontWeight(.bold).kerning(3)
            .bold()
            .foregroundColor(.blue)
            .padding(.top, 50)
            
            Spacer()
            
            ZStack {
                VStack(spacing: 1) {
                    
                    ForEach(0...2, id: \.self) { i in
                        HStack(spacing: 1) {
                        ForEach(0...2, id: \.self) { j in
                                                   Button(action: {
                                                    //self.remember = "\(i)\(j)"
                                                    self.buttonTapped(key: "\(i)\(j)")
                                                   }, label: {
                                                    Text(self.getValue(key: "\(i)\(j)"))

                                                   })
                                                   .buttonStyle(CustomButtonStyle())
                    }
                    }
                }
                }
                .background(LinearGradient(gradient: Gradient.init(colors: [.pink, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)) //changes border color of box selected
                .opacity(self.wonPlayer.isEmpty ? 1.0 : 0.7)
                .disabled(self.wonPlayer.isEmpty ? false : true)
                    
                    Text(wonPlayer.isEmpty ? "" : "The Winner is: \(wonPlayer)")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .opacity(wonPlayer.isEmpty ? 0.0 : 1.0)

            }
            
        
            
            Spacer()
            
            Button(action: {
                self.newGameButtonTapped()
            }, label: {
                Spacer()
                Text("New game")
                    .bold()
                    .foregroundColor(.blue)
                    .font(.system(size: 35, weight: .thin))
                Spacer()
                
            }).padding()
            .background(Color.black)
            .cornerRadius(20)
            .padding()
}
}
    }
    func buttonTapped(key: String) {
        if player == .one {
            viewModel.setValue(.cross, for: key)
        } else {
            viewModel.setValue(.circle, for: key)
        }
        
        if viewModel.isWin() {
            print("Win: \(player)")
            self.wonPlayer = player.identity
        } else {
        
        player.toggle()
    }
    }
    func getValue(key: String) -> String {
        viewModel.getValue(for: key).rawValue
    }
    
    func newGameButtonTapped() {
        viewModel.content = [:]
        player = .one
        
        wonPlayer = ""
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
    }
    
   
}




