//
//  ContentView.swift
//  UI Scribbler
//
//  Created by Raffi Chilingaryan on 1/31/24.
//

import Foundation

import SwiftUI

struct ContentView: View {
    
    @State private var drawing: [Path] = []
    @State private var currentPath = Path()
    
    @State private var drawingView = DrawingView()
    @State private var showShareSheet = false
    @State private var shareItems: [Any] = []
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let aspectRatio = screenHeight / screenWidth
        let padding: CGFloat = 44
        let canvasWidth: CGFloat = UIScreen.main.bounds.width - padding * 2
        let canvasHeight: CGFloat = canvasWidth * aspectRatio
        
        ZStack {
            // Color("bg").edgesIgnoringSafeArea(.all) // full screen background
            Color.black.edgesIgnoringSafeArea(.all) // full screen background
            
            // Container VStack
            VStack (){
                
                //                Rectangle()
                //                    .fill(Color.clear)
                //                    .contentShape(Rectangle())
                //                    .gesture(
                //                        DragGesture(minimumDistance: 0)
                //                            .onChanged { value in
                //                                // Handle drag gestures here
                //                                let location = value.location
                //                                currentPath.addLine(to: location)
                //                                print("drag Queen")
                //                            }
                //                            .onEnded { _ in
                //                                // Handle end of drag gesture
                //                                drawing.append(currentPath)
                //                                currentPath = Path() // Reset the current path
                //                                print("drag Queen done dragging")
                //                            }
                //                    )
                //                    .frame(width: canvasWidth, height: canvasHeight)
                //                    .background(
                //                        RoundedRectangle(cornerRadius: 40)
                //                            .fill(Color("surface"))
                //                    )
                //                    .overlay(
                //                        ForEach(0..<drawing.count, id: \.self) { index in
                //                            drawing[index].stroke(Color.black, lineWidth: 3)
                //                        }
                //                    )
                
                DrawingViewRepresentable(drawingView: $drawingView)
                    .border(Color.black, width: 1) // Optional: Adds a border around the drawing area
                    .padding()
                
                Spacer()
                // BUTTONS
                
                HStack(spacing: 20) {
                    Spacer()
                    
                    UndoButton {
                        drawingView.undo()
                    }
                    
                    ShareButton {
                        if let image = drawingView.imageFromDrawing() {
                            shareItems = [image]
                            showShareSheet = true
                        }
                    }
                    
                    TrashButton {
                        drawingView.clear()
                    }
                    
                    Spacer()
                }
                // .frame(height: bottomBarHeight)
                .padding(.top, 12)
                // .border(Color.white)
            }
            // .border(Color.white)
            .padding(.bottom, 10)
            .padding(.top, 8)
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: shareItems)
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
                    .fill(Color.white.opacity(0.14))
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

struct DrawingViewRepresentable: UIViewRepresentable {
    @Binding var drawingView: DrawingView
    
    func makeUIView(context: Context) -> some UIView {
        return drawingView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update the view if needed
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
