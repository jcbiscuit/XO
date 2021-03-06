//
//  ContentView.swift
//  XO
//
//  Created by Jody Clelland on 10/3/21.
//

import SwiftUI


//MARK: - Start of SplashScreenView

struct SplashScreenView: View {
    
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        
        Color("splashscreencolor")
        VStack{
            Image("oxlogo3")
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
        
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(Animation.easeIn(duration: 1.0)) {
                
                animate.toggle()
            }
        }
    }
    
}
//MARK: - End of SplashScreenView


struct ContentView: View {
    
    @State var viewModel = GameFlow()
    @State var player: Player = .one
    @State var wonPlayer: String = ""
    

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(){
                Image("oxlogo3")
                    .padding(.top, 50)
                
                ZStack {
                    VStack(spacing: 3) {
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
                        .font(.system(size: 35))
                        //                        .fontWeight(.thin)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.blue)
                        .cornerRadius(20)
                        .opacity(wonPlayer.isEmpty ? 0.0 : 1.0)
                }
                
                Spacer()
                
                Button(action: {
                    self.newGameButtonTapped()
                }, label: {
                    Spacer()
                    Text("New game")
                        .kerning(2)
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .bold))
                    Spacer()
                    
                }).padding(.bottom, 150)
                .padding(.top, 50)
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




