//
//  SVars.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import Foundation

class SVars {
    // HTTP allowed in Info.plist (don't do this in production)
    static var postsUrl: String = "http://bewellapp.test/get_posts.php"
    static var addPostUrl: String = "http://bewellapp.test/add_post.php"

    static var usersUrl: String = "http://bewellapp.test/get_users.php"
    static var categoriesUrl: String = "http://bewellapp.test/get_categories.php"
    static var likesUrl: String = "http://bewellapp.test/get_likes.php"

    static var uploadImageUrl: String = "http://bewellapp.test/upload_image.php"
    static var postImgUrl: String = "http://bewellapp.test/images/"

    static var signInUrl: String = "http://bewellapp.test/signin.php"
    static var signUpUrl: String = "http://bewellapp.test/signup.php"
}
