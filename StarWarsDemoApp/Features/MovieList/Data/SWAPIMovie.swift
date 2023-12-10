//
//  SWAPIMovie.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation

// Documentation for this type can be found here: https://swapi.dev/documentation#films

struct SWAPIMovie {
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: Date
// Note: Leaving out more complex data types because of time constraints
//    let species: Array
//    let starships: Array
//    let vehicles: Array
//    let characters: Array
//    let planets: Array
    let url: String
//    let created: Date
//    let edited: Date
}

extension SWAPIMovie {
    init?(json: [String: Any]) {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [.withFullDate]
        guard let title = json["title"] as? String,
              let episodeId = json["episode_id"] as? Int,
              let openingCrawl = json["opening_crawl"] as? String,
              let director = json["director"] as? String,
              let producer = json["producer"] as? String,
              let releaseDate = json["release_date"] is String
                                ? isoDateFormatter.date(from: json["release_date"] as! String)
                                : nil,
              let url = json["url"] as? String
        else {
            return nil
        }
        
        self.title = title
        self.episodeId = episodeId
        self.openingCrawl = openingCrawl
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.url = url
    }
}
