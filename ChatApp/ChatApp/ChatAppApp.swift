//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Kushank Virdi on 2024-03-22.
//

import SwiftUI
import Firebase

@main
struct ChatAppApp: App {
    
    init(){
        
        FirebaseApp.configure()
        print("Firebase Configured")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
