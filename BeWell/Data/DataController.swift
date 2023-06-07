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
    @Published var categoriesData: [Category] = []
    @Published var likesData: [Like] = []

    @Published var pageIndex: Int = 0
    @Published var serverOutput: [String: String] = [:]
    // TODO: Implement alert
    @Published var showAlert: Bool = false

    init() {
        loadPostsData()
        loadUsersData()
        loadCategoriesData()
        loadLikesData()
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
    
    // Add post
    // ------------------------------------------------------------
    
    func addPost(type: String, image: Data, quote: String, quoteAuthor: String, uid: String, category: String, reported: String) {
        let urlPost = URL(string: SVars.addPostUrl)!
        
        var request = URLRequest(url: urlPost)
        request.httpMethod = "POST"
        
        // TODO
        let postString = "type=\(type)&image=\(image)&quote=\(quote)&quoteAuthor=\(quoteAuthor)&uid=\(uid)&category=\(category)&reported=\(reported)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            print(String(decoding: data!, as: UTF8.self))
            
            let dict = try! JSONSerialization.jsonObject(with: data ?? Data()) as! [String: String]
            
            DispatchQueue.main.async {
                self.loadPostsData()
                self.pageIndex = 1
            }
        }
        
        task.resume()
    }
    
    // Upload image
    // ------------------------------------------------------------
    
    func uploadImage(postForm: PostForm) {
        let url = URL(string: SVars.uploadImageUrl)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()

        let fname = "\(postForm.id).png"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        let mimetype = "image/png"

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append(
            "Content-Disposition:form-data; name=\"fileToUpload\"; filename=\"\(fname)\"\r\n".data(
                using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(postForm.image)
        body.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        request.httpBody = body

        let uploadTask = URLSession.shared.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                let dat = String(data: data!, encoding: .utf8)
                print(dat)
            })

        uploadTask.resume()
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
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
    
    // Load categories
    // ------------------------------------------------------------
    
    func loadCategoriesData() {
        let url = URL(string: SVars.categoriesUrl)!
        let request = URLRequest(url: url)
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            print(String(decoding: data!, as: UTF8.self))
            
            let decoder = JSONDecoder()

            // TODO: Handle data when server is not running
            guard let categories = try? decoder.decode([Category].self, from: data!) else { return }

            DispatchQueue.main.async {
                self.categoriesData = categories
            }
        }

        task.resume()
    }
    
    // Load likes
    // ------------------------------------------------------------
    
    func loadLikesData() {
        let url = URL(string: SVars.likesUrl)!
        let request = URLRequest(url: url)
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            print(String(decoding: data!, as: UTF8.self))
            
            let decoder = JSONDecoder()

            // TODO: Handle data when server is not running
            guard let likes = try? decoder.decode([Like].self, from: data!) else { return }

            DispatchQueue.main.async {
                self.likesData = likes
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
