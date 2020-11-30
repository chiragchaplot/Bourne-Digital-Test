//
//  MovieObject.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 29/11/20.
//

import Foundation


struct MainObject: Codable {
    var title: String
    var movies: [Movie]
}

struct Movie: Codable {
    var title: String!
    var imageHref: String!
    var rating: Double!
    var releaseDate: String!
}


