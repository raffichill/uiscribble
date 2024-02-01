//
//  ContentView.swift
//  UI Scribbler
//
//  Created by Raffi Chilingaryan on 1/31/24.
//

import Foundation

import SwiftUI

struct ContentView: View {
    
    @State private var path = Path()
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let aspectRatio = screenHeight / screenWidth
        let padding: CGFloat = 50
        let canvasWidth: CGFloat = UIScreen.main.bounds.width - padding * 2
        let canvasHeight: CGFloat = canvasWidth * aspectRatio
        // let topPadding: CGFloat =
        
        ZStack {
            Color("bg").edgesIgnoringSafeArea(.all) // full screen background
            
            // Container VStack
            VStack (){
                
                // MAIN VIEW
                VStack {
                    

                }
                .frame(width: canvasWidth)
                .frame(height: canvasHeight)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.white) // White background for the MAIN VIEW
                )
                
                Spacer()
                // BUTTONS
                
                HStack(spacing: 20) {
                    Spacer()

                    UndoButton {
                        print("undo")
                    }

                    ShareButton {
                        print("share")
                    }

                    TrashButton {
                        print("trash")
                    }

                    Spacer()
                }
                // .frame(height: bottomBarHeight)
                // .padding(.top, 20)
                // .border(Color.white)
            }
            // .border(Color.white)
            .padding(.bottom, 4)
            .padding(.top, 26)
        }
    }
}




struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 19).weight(.semibold))
            .foregroundStyle(Color.white)
            .frame(width: 80, height: 56)
            .background(
                RoundedRectangle(cornerRadius: 27, style: .continuous) // Use .continuous for continuous corner smoothing
                    .fill(Color.white.opacity(0.07))
            )
    }
}

struct UndoButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "minus")
        }
        .buttonStyle(CustomButtonStyle())
    }
}

struct ShareButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action() // Call the provided action
        }) {
            Image(systemName: "arrow.up")
        }
        .buttonStyle(CustomButtonStyle())
    }
}

struct TrashButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action() // Call the provided action
        }) {
            Image(systemName: "trash")
        }
        .buttonStyle(CustomButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
