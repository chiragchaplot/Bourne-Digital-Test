//
//  MovieObject.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 29/11/20.
//

import Foundation


struct MainObject: Codable {
    let title: String
    let movies: [Movie]
}

struct Movie: Codable {
    let title: String!
    let imageHref: String!
    let rating: Double!
    let releaseDate: String!
}


