//
//  EmailSignUpUIView.swift
//  Child Lock Prototype
//
//  Created by Yevin Warnapura on 2024-04-26.
//

import SwiftUI
import AuthenticationServices
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct SignUpUIView: View {
    @State private var signupEmail = ""
    @State private var signupPassword = ""
    @State private var retypePassword = ""
    @State private var signupWrongEmail = 0
    @State private var signupWrongPassword = 0
    @State private var signupWrongRetypePass = 0
    @State private var isAccountViewPresented = false
    @State private var isViewable = false
    @State private var imageString = "eye.slash"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.8)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.55)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Email", text: $signupEmail)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .border(.red, width: CGFloat(signupWrongEmail))
                    
                    if isViewable == false {
                        SecureField("Password", text: $signupPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .border(.red, width: CGFloat(signupWrongPassword))
                            .overlay (
                                HStack {
                                    Button(action: {
                                        imageString = isViewable ? "eye.slash" : "eye"
                                        isViewable = !isViewable
                                    }) {
                                        Image(systemName: imageString)
                                            .resizable()
                                            .frame(width: 28, height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing], 9)
                            )
                        
                        SecureField("Confirm Password", text: $retypePassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .border(.red, width: CGFloat(signupWrongRetypePass))
                            .overlay (
                                HStack {
                                    Button(action: {
                                        imageString = isViewable ? "eye.slash" : "eye"
                                        isViewable = !isViewable
                                    }) {
                                        Image(systemName: imageString)
                                            .resizable()
                                            .frame(width: 28, height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing], 9)
                            )
                    } else {
                        TextField("Password", text: $signupPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .border(.red, width: CGFloat(signupWrongPassword))
                            .overlay (
                                HStack {
                                    Button(action: {
                                        imageString = isViewable ? "eye.slash" : "eye"
                                        isViewable = !isViewable
                                    }) {
                                        Image(systemName: imageString)
                                            .resizable()
                                            .frame(width: 28, height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing], 9)
                            )
                        
                        TextField("Confirm Password", text: $retypePassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(.black.opacity(0.05))
                            .cornerRadius(10)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .border(.red, width: CGFloat(signupWrongRetypePass))
                            .overlay (
                                HStack {
                                    Button(action: {
                                        imageString = isViewable ? "eye.slash" : "eye"
                                        isViewable = !isViewable
                                    }) {
                                        Image(systemName: imageString)
                                            .resizable()
                                            .frame(width: 28, height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding([.trailing], 9)
                            )
                    }
                    
                    //Save Data
                    WelcomeButton(title: "Sign Up", backgroundColor: .blue, textColor: .white) {
                        register()
                    }
                    .padding([.top], 8)
                    .fullScreenCover(isPresented: $isAccountViewPresented) {
                        AccountInfoUIView()
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
                    
                    //Google SignUp Button
                    RoundedButton(title: "Sign up with Google", foregroundColor: .black, backgroundColor: .clear, logo: Image("g-Logo"), logoHeight: 18, logoWidth: 18) {
                        Task {
                           try await signInWithGoogle()
                        }
                    }
                    .padding([.top], 5)
                    
                    //Apple SignUp Button
                    SignInWithAppleButton(.signUp) { request in
                        //buy developper shit
                    } onCompletion: { result in
                        
                    }
                    .frame(width: 350, height: 53)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .padding([.top], 5)
                    
                    HStack {
                        Text("HAVE AN ACCOUNT?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        NavigationLink("LOGIN", destination: LoginUIView())
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    func register() {
        if signupPassword == retypePassword {
            Auth.auth().createUser(withEmail: signupEmail, password: signupPassword) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    isAccountViewPresented = true
                }
            }
        } else {
            print("Passwords dont match")
            signupWrongRetypePass = 2
        }
    }
    
    func signInWithGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cancelled)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let acessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: acessToken)
        let authDataResult = try await Auth.auth().signIn(with: credential)
    }

        
}

#Preview {
    SignUpUIView()
}
