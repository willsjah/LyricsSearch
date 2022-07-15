//
//  SearchHistoryManager.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import Foundation

class SearchHistoryManager {
        
    static let shared = SearchHistoryManager()
    private init() {}
        
    var historyList: [SearchHistory] = []
    
    func saveSearchHistory(artistName: String,
                           songTitle: String,
                           lyrics: String) {
        // Not Yet Implemented
        
        let history = SearchHistory(artist: artistName, title: songTitle, lyrics: lyrics)
        historyList.append(history)
    }
    
    func loadSearchHistory() {
        // Not Yet Implemented
    }

}
