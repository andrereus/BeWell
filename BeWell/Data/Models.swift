//
//  Post.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let type: String
    let image: String
    let quote: String
    let quoteAuthor: String
    let uid: String
    let category: String
    let reported: String
    let timestamp: String
}

struct PostForm {
    let type: String
    let image: String
    let quote: String
    let quoteAuthor: String
    let uid: String
    let category: String
    let reported: String
}

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let username: String
    let registered: String
    let reported: String
    let timestamp: String
}

struct Category: Codable, Identifiable {
    let id: String
    let name: String
    let timestamp: String
}

struct Like: Codable, Identifiable {
    var id: UUID = UUID()
    let uid: String
    let postId: String
    let timestamp: String
}
