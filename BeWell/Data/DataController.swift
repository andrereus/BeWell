//
//  DataController.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import Foundation

class DataController: ObservableObject {
    @Published var allDataOriginal: [Post] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        let url = URL(string: SVars.getPostsUrl)!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let posts = try? decoder.decode([Post].self, from: data!) else { return }
            
            DispatchQueue.main.async {
                self.allDataOriginal = posts
            }
        }
        
        task.resume()
    }
}
