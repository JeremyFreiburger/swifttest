//
//  ContentView.swift
//  tictactoe
//
//  Created by Jeremy Freiburger on 1/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
            // large title tic tac toe
                .navigationBarTitle(Text("Tic Tac Toe").font(.largeTitle), displayMode: .large)
                             // Center the title
                .preferredColorScheme(.dark)
                

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
