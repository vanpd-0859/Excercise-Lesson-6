//
//  GithubAccount.swift
//  Lesson 6
//
//  Created by Phan Dinh Van on 3/14/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import Foundation
import ObjectMapper

class GoogleRepos: Mappable {
    var id: String!
    var name: String!
    var html_url: String!
    var description: String!
    var stargazers_count: Int! = 0
    var watchers_count: Int! = 0
    var forks_count: Int! = 0
    var language: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        html_url            <- map["html_url"]
        description         <- map["description"]
        stargazers_count    <- map["stargazers_count"]
        watchers_count      <- map["watchers_count"]
        forks_count         <- map["forks_count"]
        language            <- map["language"]
    }
    
    
}
