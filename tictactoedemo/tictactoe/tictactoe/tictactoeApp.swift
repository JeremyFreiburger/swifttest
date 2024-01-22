//
//  tictactoeApp.swift
//  tictactoe
//
//  Created by Jeremy Freiburger on 1/19/24.
//

import SwiftUI

@main
struct tictactoeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ontentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// create me a tic tac toe ios game

struct Home: View {
    
    // moves
    @State var moves: [String] = Array(repeating: "", count: 9)
    // identify the current player
    @State var isPlaying = true
    // identify the winner
    @State var gameOver = false
    @State var msg = ""
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                ForEach(0..<9, id: \.self) { index in
                    ZStack {
                        // color the boxes
                        Color(moves[index] == "O" ? .red : .blue)
                        
                        // add the tap gesture
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        // add the moves
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                    }
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0
                    )
                    .onTapGesture(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "X" : "O"
                                isPlaying.toggle()
                            }
                        }
                    })
                }
            }
            .padding(15)
        }
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text("Play Again"), action: {
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        })
    }
    
    // calculate the width of the boxes
    func getWidth() -> CGFloat {
        // horizontal padding = 30
        // spacing = 30
        let width = UIScreen.main.bounds.width - (30 + 30)

        return width / 3
    }

    // check for the winner
    func checkWinner() {
        if checkMoves(player: "X") {
            msg = "Player X Won!!!"
            gameOver.toggle()
        } else if checkMoves(player: "O") {
            msg = "Player O Won!!!"
            gameOver.toggle()
        } else {
            // check for no moves
            let status = moves.contains { (value) -> Bool in
                return value == ""
            }
            
            if !status {
                msg = "Game Over Tied!!!"
                gameOver.toggle()
            }
        }
    }

    func checkMoves(player: String) -> Bool {
        // horizontal moves
        for contestant in stride(from: 0, to: 9, by: 3) {
            if moves[contestant] == player && moves[contestant+1] == player && moves[contestant+2] == player {
                return true
            }
        }

        // vertical moves
        for contestant in 0...2 {
            if moves[contestant] == player && moves[contestant+3] == player && moves[contestant+6] == player {
                return true
            }
        }

        // check for diagonal moves
        if moves[0] == player && moves[4] == player && moves[8] == player {
            return true
        }

        if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }

        return false
    }
}












