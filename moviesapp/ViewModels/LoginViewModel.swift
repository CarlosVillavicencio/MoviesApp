//
//  LoginViewModel.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation

class LoginViewModel {
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Verificar las credenciales aquí
        let correctUsername = "admin"
        let correctPassword = "admin"
//        let correctUsername = "Admin"
//        let correctPassword = "Password*123"
        
        let isLoggedIn = (username == correctUsername) && (password == correctPassword)
        completion(isLoggedIn)
    }
}