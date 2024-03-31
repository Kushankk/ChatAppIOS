//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Kushank Virdi on 2024-03-30.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: ObservableObject{

    
    @Published var ChatControllerErrorMessage = ""
    
    init(){
       
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        
        guard let uid = Auth.auth().currentUser?.uid
        
        else{
            self.ChatControllerErrorMessage = "Could not get the firebase uid"
            return
        }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, err in
            if err != nil{
                self.ChatControllerErrorMessage = "Failed to fetch Current User\(String(describing: err))"
                print("Failed to fetch Current User")  
                return
            }
            guard let data = snapshot?.data() else{
                self.ChatControllerErrorMessage = "Could not find user data"
                return
            }
            //print(data)
            self.ChatControllerErrorMessage = "Data: \(data.description)"
        }
    }
    
}
