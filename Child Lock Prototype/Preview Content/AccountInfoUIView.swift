//
//  AccountInfoUIView.swift
//  Child Lock Prototype
//
//  Created by Yevin Warnapura on 2024-04-30.
//

import SwiftUI


struct AccountInfoUIView: View {
    @State private var userName = ""
    @State private var childName = ""
    @State private var parentalPin = ""
    @State private var parentalPinHint = ""
    @State private var googleLinked = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.9)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.55)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Account Info")
                        .fontWeight(.medium)
                        .font(.title)
                    TextField("Guiardian's First Name", text: $userName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled()
                    TextField("Child's First Name", text: $childName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled()
                    SecureField("Parental Pin (4 Digits)", text: $parentalPin)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                        .overlay (
                            Button(action: {
                                //pop up with info
                            }) {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                                    .padding([.trailing], 9)
                            }
                        )
                    TextField("Hint for Pin", text: $parentalPinHint)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    Text("Connect Child's Google Classroom")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding([.top], 10)
                    
                    //Child GC Link
                    RoundedButton(title: "Link Google Classroom", foregroundColor: .black, backgroundColor: .black.opacity(0.07), logo: Image("gc-Logo"), logoHeight: 20, logoWidth: 20) {
                        
                        //Connect childs google classroom account
                        
                    }
                    
                    WelcomeButton(title: "Next", backgroundColor: .blue, textColor: .white) {
                        googleLinked = true
                    }
                    .padding([.top], 10)
                    .fullScreenCover(isPresented: $googleLinked) {
                        DashboardUIView()
                    }
                }
            }
        }
    }
}

#Preview {
    AccountInfoUIView()
}
