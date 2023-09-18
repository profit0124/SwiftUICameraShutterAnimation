//
//  ContentView.swift
//  ShutterButtonAnimation
//
//  Created by Sooik Kim on 2023/09/18.
//

import SwiftUI

struct ContentView: View {
    
    @State var buttonTapped: Bool = false
    @State var buttonColor: Color = .white
    @State var scale: CGFloat = 1
    
    var body: some View {
        ZStack{
            Color.black
            ZStack {
                Circle()
                    .stroke(lineWidth: 4)
                    .foregroundColor(.white)
                Circle()
                    .foregroundColor(buttonColor)
                    .frame(width: buttonTapped ? 56 : 60, height: buttonTapped ? 56 : 60)
                    .scaleEffect(scale)
                
            }
            .frame(width: 72, height: 72)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)){
                    buttonTapped.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.3)){
                        buttonTapped.toggle()
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        let tempScale: CGFloat = 75 / 60
                        if scale == 1 {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                buttonTapped.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    buttonTapped.toggle()
                                    buttonColor = .red
                                    scale = tempScale
                                }
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            if scale == tempScale {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    scale = 50 / 60
                                }
                            }
                        }
                    })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                            withAnimation(.spring(response: 0.2)) {
                                buttonColor = .white
                                scale = 1
                            }
                        }
                    })
            )
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
