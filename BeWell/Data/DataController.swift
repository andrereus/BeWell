//
//  DataController.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import Foundation

class DataController: ObservableObject {
    @Published var postsData: [Post] = []
    @Published var usersData: [User] = []

    @Published var pageIndex: Int = 0
    @Published var serverOutput: [String: String] = [:]
    // TODO: Implement alert
    @Published var showAlert: Bool = false

    init() {
        loadPostsData()
        loadUsersData()
        loadSignInData()
    }

    // Load posts
    // ------------------------------------------------------------
    
    func loadPostsData() {
        let url = URL(string: SVars.postsUrl)!
        let request = URLRequest(url: url)
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            print(String(decoding: data!, as: UTF8.self))
            
            let decoder = JSONDecoder()

            // TODO: Handle data when server is not running
            guard let posts = try? decoder.decode([Post].self, from: data!) else { return }

            DispatchQueue.main.async {
                self.postsData = posts
            }
        }

        task.resume()
    }
    
    // Load users
    // ------------------------------------------------------------
    
    func loadUsersData() {
        let url = URL(string: SVars.usersUrl)!
        let request = URLRequest(url: url)
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            print(String(decoding: data!, as: UTF8.self))
            
            let decoder = JSONDecoder()

            // TODO: Handle data when server is not running
            guard let users = try? decoder.decode([User].self, from: data!) else { return }

            DispatchQueue.main.async {
                self.usersData = users
            }
        }

        task.resume()
    }

    // Sign in
    // ------------------------------------------------------------
    
    func checkSignIn(email: String, password: String) {
        let urlPost = URL(string: SVars.signInUrl)!
        
        var request = URLRequest(url: urlPost)
        request.httpMethod = "POST"
        
        let postString = "email=\(email)&password=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            print(String(decoding: data!, as: UTF8.self))
            
            let dict = try! JSONSerialization.jsonObject(with: data ?? Data()) as! [String: String]
            
            DispatchQueue.main.async {
                self.checkServerOutputSignIn(dict: dict)
            }
        }
        
        task.resume()
    }
    
    func checkServerOutputSignIn(dict: [String: String]) {
        if dict["state"] == "1" {
            serverOutput = dict
            pageIndex = 1
            saveSignInData()
        } else {
            serverOutput = dict
            showAlert = true
        }
    }
    
    func saveSignInData() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.set(serverOutput, forKey: "serverOutput")
    }
    
    // Sign up
    // ------------------------------------------------------------
    
    func checkSignUp(email: String, password: String, username: String) {
        let urlPost = URL(string: SVars.signUpUrl)!
        
        var request = URLRequest(url: urlPost)
        request.httpMethod = "POST"
        
        let postString = "email=\(email)&password=\(password)&username=\(username)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            print(String(decoding: data!, as: UTF8.self))

            let dict = try! JSONSerialization.jsonObject(with: data ?? Data()) as! [String: String]

            DispatchQueue.main.async {
                self.checkServerOutputSignUp(dict: dict)
            }
        }

        task.resume()
    }
    
    func checkServerOutputSignUp(dict: [String: String]) {
        if dict["state"] == "1" {
            serverOutput = dict
            pageIndex = 0
            showAlert = true
        } else {
            serverOutput = dict
            showAlert = true
        }
    }
    
    // Sign out
    // ------------------------------------------------------------

    func signOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        pageIndex = 0
    }
    
    // Load sign in data
    // ------------------------------------------------------------

    func loadSignInData() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            serverOutput = UserDefaults.standard.object(forKey: "serverOutput") as! [String: String]
            print(serverOutput)
            pageIndex = 1
        } else {
            pageIndex = 0
        }
    }
}
