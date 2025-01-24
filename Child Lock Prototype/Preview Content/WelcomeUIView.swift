//
//  WelcomeUIView.swift
//  Child Lock Prototype
//
//  Created by Yevin Warnapura on 2024-04-26.
//

import SwiftUI

struct WelcomeUIView: View {
    
    @State private var isLoginViewPresented = false
    @State private var isSignUpViewPresented = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            Text("Example App")
                .font(.largeTitle)
                .fontWeight(.bold)
            VStack {
                //Login Button
                WelcomeButton(title: "Login", backgroundColor: .white, textColor: .blue) {
                    self.isLoginViewPresented = true
                }
                .fullScreenCover(isPresented: $isLoginViewPresented) {
                    LoginUIView()
                }
                
                //Sign Up Button
                WelcomeButton(title: "Sign Up", backgroundColor: .blue, textColor: .white) {
                    self.isSignUpViewPresented = true
                }
                .padding([.top], 10)
                .fullScreenCover(isPresented: $isSignUpViewPresented) {
                    SignUpUIView()
                }
            }
            .padding([.top], 200)
        }
    }
}

#Preview {
    WelcomeUIView()
}

struct WelcomeButton: View {
    var title: String
    var backgroundColor: Color
    var height: CGFloat = 50
    var textColor: Color
    var action: () -> Void
    
    private var cornerRadius: CGFloat {
        return height / 2
    }
    
        var body: some View {
            Button(action: action) {
               RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color.gray, lineWidth: 2.0)
                    .fill(backgroundColor)
                    .overlay (
                    Text(title)
                        .frame(alignment: .center)
                        .font(.title2)
                        .foregroundColor(textColor)
                        .fontWeight(.heavy)
                )
            }
            .frame(width: 350, height: 53)
        }
    
}
