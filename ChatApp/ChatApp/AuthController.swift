//
//  FunctionHandler.swift
//  ChatApp
//
//  Created by Kushank Virdi on 2024-03-28.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseStorage






class AuthController: ObservableObject {
    @Published var loginMessage = ""
    @Published var isAuthenticated = false
    @Published var image: UIImage?
    
    func handleButtonClick(isLogged: Bool, authModel:AuthModel) {
        if isLogged {
            loginUser(authModel: authModel)
            // Implement login functionality here
        } else {
            createNewAccount(authModel: authModel)
            // Implement registration functionality here
        }
    }
    
    func createNewAccount(authModel:AuthModel){
        
        Auth.auth().createUser(withEmail: authModel.email, password:authModel.password) { result, err in
            if err != nil{
                self.loginMessage = "Failed User Creation \(String(describing: err))"
                print(self.loginMessage)
                return
                
            }
            self.isAuthenticated = true
            self.loginMessage = "Successfully created a user"
            
            self.persistImageToStorage()
        }
        
    }
    
    private func persistImageToStorage(){
        //let filename = UUID().uuidString
        guard let uid = Auth.auth().currentUser?.uid
        else{return}
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5)else{
            return
        }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err{
                self.loginMessage = "Failed to push image into Firebase Storage: \(err)"
                return
            }
            ref.downloadURL { url, err in
                if let err = err{
                    self.loginMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                self.loginMessage = "Successfully store Image with URL \(url?.absoluteString ?? "")"
            }
            
        }
    }
    
    
    func loginUser(authModel:AuthModel){
        
        Auth.auth().signIn(withEmail: authModel.email, password:authModel.password) { result, err in
            if err != nil{
                self.loginMessage = "Failed to Log In User \(String(describing: err))"
                print(self.loginMessage)
                return
                
            }
            self.isAuthenticated = true
            self.loginMessage = "Successfully Logged in"
        }
        
        
    }
    
}


