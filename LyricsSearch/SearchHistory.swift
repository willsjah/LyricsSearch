//
//  SearchHistory.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import Foundation

struct SearchHistory: Codable {
    let artist: String
    let title: String
    let lyrics: String
}
