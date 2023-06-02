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
