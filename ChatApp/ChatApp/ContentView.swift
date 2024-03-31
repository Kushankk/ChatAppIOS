//
//  ContentView.swift
//  ChatApp
//
//  Created by Kushank Virdi on 2024-03-22.
//

import SwiftUI
import FirebaseAnalytics

struct ContentView: View {
    
    @State var authModel = AuthModel(email: "", password: "")
    @State var islogged = false
    @State var emailText = ""
    @State var passText = ""
    
    @State var showImagePicker = false
    //@State var image: UIImage?
    @ObservedObject var viewModel = AuthController()
    var body: some View {
        ZStack{
            
            //If authentication Succeeds, Go to Chat Screen
            if(viewModel.isAuthenticated){
                ChatView()
            }
            //Else show the Login/Sign up page
            else{
                VStack{
                    
                    //Adding A Navigation bar at the top for Login/Signup Scroll
                    //The tag here can modify the selection variable
                    //Changing this tag as true would change @state isLogged to true
                    NavigationView{  
                        ScrollView{
                            Picker(selection: $islogged, label: Text("Selector")){
                                Text("Sign Up")
                                    .tag(false)
                                
                                Text("Log In")
                                    .tag(true)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(30)
                            .onChange(of: islogged) { newValue in
                                viewModel.loginMessage = ""
                            }

                            
                            //User Image(If you are in create account)
                            if(!islogged){
                                Button{
                                    showImagePicker.toggle()
                                }label: {
                                    VStack{
                                        if let image = viewModel.image{
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 128, height: 128)
                                                .cornerRadius(64)
                                        }else{
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 64))
                                                .padding()
                                                .foregroundColor(Color(.label))
                                        }
                                    }
                                    .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3)
                                    
                                    )
                                    
                                    
                                    
                                }
                            }
                            
                            
                            
                            
                            TextField("Email", text: $authModel.email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(12)
                                .background(.inputFieldGray)
                                .cornerRadius(3.0)
                                .foregroundStyle(.black)
                            
                            
                            SecureField("Password", text: $authModel.password)
                                .padding(12)
                                .background(.inputFieldGray)
                                .cornerRadius(3.0)
                                .foregroundStyle(.black)
                            
                            Button{
                                
                                
                                viewModel.handleButtonClick(isLogged: islogged, authModel: authModel)
                            }label: {
                                HStack{
                                    Spacer()
                                    Text(islogged ? "Log In" : "Create Account")
                                        .foregroundColor(.white)
                                    
                                        .padding(.vertical, 10)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .background(.blue)
                                .cornerRadius(3.0)
                                
                                
                            }
                            Text(viewModel.loginMessage)
                                .foregroundColor(.red)
                            
                            
                        }
                        //.navigationTitle("RepMax")
                        .navigationBarItems(leading: Image(.logoREP).resizable().frame(width: 150, height: 80))
                        
                        
                    }
                    .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil, content: {
                        ImagePicker(image: $viewModel.image)
                    })
                    .padding()
                    //.frame(height: 600)
                    Spacer()
                    
                    
                    
                    
                    
                }
                .padding(5)
            }
        }
    }

}

#Preview {
    ContentView()
}
