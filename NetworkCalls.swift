//
//  NetworkCalls.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 29/11/20.
//

import Foundation
import Alamofire

class observer : ObservableObject
{
    @Published var data = [mainObject]()
    
    init() {
        Alamofire.Request("https://www.dropbox.com/s/q1ins5dsldsojzt/movies.json?dl=1").
    }
}
