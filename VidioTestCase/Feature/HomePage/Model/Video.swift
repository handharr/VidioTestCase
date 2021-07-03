//
//  Video.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 03/07/21.
//

import Foundation

struct Video: Codable {
    let id: String
    let title: String
    let description: String
    let releaseDate: String
    let director: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case releaseDate = "release_date"
        case director
    }
}
