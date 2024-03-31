//
//  ChatView.swift
//  ChatApp
//
//  Created by Kushank Virdi on 2024-03-29.
//

import SwiftUI

struct ChatView: View {
    
    //@ObservedObject var viewModel = AuthController()
    @State var shouldShowLogOutOptions = false
    @ObservedObject var chatController = ChatViewController()
    
   
    private var messageView: some View{
        
        ScrollView{
            ForEach(0..<10, id: \.self){ num in
                VStack{
                    HStack(spacing: 16){
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                .stroke(Color(.label),lineWidth: 1)
                            )
                        VStack(alignment: .leading){
                            Text("Username")
                                .font(.system(size: 16, weight: .bold))
                            Text("Message sent to user")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.lightGray))
                        }
                        Spacer()
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
                        .padding(.vertical, 8)
                    
                }.padding(.horizontal)
                
                
            }.padding(.bottom, 50)
            
        }
    }
    
    
    private var customNavBar: some View{
        
        HStack(spacing: 16){
            
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
               
            
            VStack(alignment:.leading, spacing: 4){
                Text("USERNAME")
                    .font(.system(size: 24, weight: .bold))
                
                HStack{
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
                
            }
            
            Spacer()
            Button{
                shouldShowLogOutOptions.toggle()
                
            }label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
            
            
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions, content: {
            .init(title: Text("Settings"), message: Text("Do you want to Sign Out?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    print("Sign Out Handler")
                }),
                .cancel()
            ])
        })
    }
    
    private var newMessageButton: some View{
        
        Button{
            
        }label: {
            HStack{
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
            
        }
    }
    var body: some View {
        
        NavigationView{
            
            
            VStack{
                //custom Nav bar
                Text("CURRENT USER ID:\(chatController.ChatControllerErrorMessage)")
                customNavBar
                
                
                messageView
            }
            .overlay(
                
                newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
            
            //.navigationTitle("Main Message view")
        }
        
        
    }
}

#Preview {
    ChatView()
}
