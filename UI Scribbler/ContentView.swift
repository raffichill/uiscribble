//
//  ContentView.swift
//  UI Scribbler
//
//  Created by Raffi Chilingaryan on 1/31/24.
//

import Foundation

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            // empty VStack
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(contentMode: .fit)
        .padding(.top, 16)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.black)
        )
        .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
