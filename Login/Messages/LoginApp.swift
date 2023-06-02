//
//  LoginApp.swift
//  Login
//
//  Created by Wayne Chen on 2023-05-30.
//

import SwiftUI



@main
struct LoginApp: App {
    @StateObject var spotVM = SaveViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(spotVM)
        }
    }
}
//update

