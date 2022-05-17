//
//  News.swift
//  karhabti
//
//  Created by iMac on 14/5/2022.
//

import Foundation

struct News {
    internal init(status: String?=nil, totalResults: String?=nil, articles: [Articles]?=nil ) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles

    }
    
    let totalResults : String?
    let status : String?
    
    let articles : [Articles]?

}
