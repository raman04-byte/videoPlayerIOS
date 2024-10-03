//
//  VideoModel.swift
//  VideoPlayer
//
//  Created by Raman Tank on 03/10/24.
//

import Foundation

struct ResponseBody: Decodable{
    var page: Int
    var perPage: Int
    var totalResults: Int
    var url: String
    var videos: [Video]
}

struct Video: Identifiable, Decodable{
    var id: Int
    var image: String
    var duration: Int
    var user: User
    var videoFiles: [VideoFile]
    
    struct User: Identifiable, Decodable{
        var id: Int
        var name: String
        var url: String
    }
    struct VideoFile: Identifiable, Decodable{
        var id: Int
        var quality: String
        var fileType: String
        var link: String
    }
}
