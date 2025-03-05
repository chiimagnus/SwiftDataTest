//
//  Item.swift
//  SwiftDataTest
//
//  Created by chii_magnus on 2025/3/5.
//

import Foundation
import SwiftData

@Model
final class Item {
    var articles: String
    var note: String
    var tag: String
    var timestamp: Date
    
    init(articles: String, note: String, tag: String, timestamp: Date) {
        self.articles = articles
        self.note = note
        self.tag = tag
        self.timestamp = timestamp
    }
}
