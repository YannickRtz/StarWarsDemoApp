//
//  Movie.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation

struct Movie: Equatable, Identifiable, Hashable {
    let title: String
    let id: Int
    let date: Date
}
