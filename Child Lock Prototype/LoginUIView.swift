//
//  WelcomePageUIView.swift
//  Child Lock Prototype
//
//  Created by Yevin Warnapura on 2024-04-23.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct LoginUIView: View {
    @State private var loginEmail = ""
    @State private var loginPassword = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var isAccountUIView = false
    @State private var isViewableLogin = false
    @State private var imageStringLogin = "eye.slash"

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    VStack {
                        TextField("Email", text: $loginEmail)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .border(.red, width: CGFloat(wrongEmail))
                    if isViewableLogin == false {
                        
                        SecureField("Password", text: $loginPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.black.opacity(0.05))
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .cornerRadius(10)
                            .overlay (
                                HStack {
                                    Button(action: {
                                        imageStringLogin = isViewableLogin ? "eye.slash" : "eye"
                                        isViewableLogin = !isViewableLogin
                                    }) {
                                        Image(systemName: imageStringLogin)
                                            .resizable()
                                            .frame(width: 28, height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing], 9)
                            )
                    } else {
                        TextField("Password", text: $loginPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.black.opacity(0.05))
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .cornerRadius(10)
                            .overlay (
                                HStack {
                                    Button(action: {
                                        imageStringLogin = isViewableLogin ? "eye.slash" : "eye"
                                        isViewableLogin = !isViewableLogin
                                    }) {
                                        Image(systemName: imageStringLogin)
                                            .resizable()
                                            .frame(width: 28, height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing], 9)
                            )
                    }
                        WelcomeButton(title: "Login", backgroundColor: .blue, textColor: .white) {
                            login()
                        }
                        .padding([.top], 8)
                        .fullScreenCover(isPresented: $isAccountUIView) {
                            AccountInfoUIView()
                        }
                    }

                    //or Divider
                    HStack {
                        VStack {
                            Divider()
                        }
                        Text("or")
                            .font(.title3)
                            .foregroundColor(.black)
                        VStack {
                            Divider()
                        }
                    }
                    
                    //Alternate Sign in methods
                    VStack {
                        
                        //Google SignUp Button
                        RoundedButton(title: "Sign in with Google", foregroundColor: .black, backgroundColor: .white, logo: Image("g-Logo"), logoHeight: 18, logoWidth: 18) {
                            
                            print("google")
                            
                        }
                        
                        //Apple SignUp Button
                        SignInWithAppleButton(.signIn) { request in
                            
                        } onCompletion: { result in
                            
                        }
                        .frame(width: 350, height: 53)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .padding([.top], 5)
                        
                        HStack {
                            Text("DON'T HAVE AN ACCOUNT?")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            NavigationLink("SIGN UP", destination: SignUpUIView())
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }
                    .padding([.top], 5)
                }
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: loginEmail, password: loginPassword) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                isAccountUIView = true
            }
        }
    }
}

#Preview {
    LoginUIView()
}

struct RoundedButton: View {
    var title: String
    var foregroundColor: Color
    var backgroundColor: Color
    var logo: Image
    var logoHeight: CGFloat = 30
    var logoWidth: CGFloat = 30
    var height: CGFloat = 50
    var action: () -> Void
    
    private var cornerRadius: CGFloat {
        return height / 2
    }
    
    var body: some View {
        Button(action: action) {
           RoundedRectangle(cornerRadius: 25.0)
                .stroke(Color.gray, lineWidth: 3.0)
                .fill(backgroundColor)
                .frame(width: 350, height: 53)
                .overlay (
            HStack {
                logo
                    .resizable()
                    .frame(width: logoWidth, height: logoHeight, alignment: .leading)
                    .foregroundColor(foregroundColor)
                Text(title)
                    .frame(alignment: .center)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(foregroundColor)                
            }
            )
        }
    }
}
