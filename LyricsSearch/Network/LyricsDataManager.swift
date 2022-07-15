//
//  LyricsDataManager.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import Foundation

class LyricsDataManager {
    
    private let session: SessionProtocol
    
    init(session: SessionProtocol) {
        self.session = session
    }
    
    func getLyrics(artist: String, title: String) async throws -> LyricsModel {
        print(#function)
        
        let artistParam = artist.encodeUrl()
        let titleParam = title.encodeUrl()
        let urlString =  "https://api.lyrics.ovh/v1/\(artistParam)/\(titleParam)"
        
        print("artistParam: \(artistParam)")
        print("titleParam: \(titleParam)")
        print("urlString: \(urlString)")
        
        guard let url = URL(string:urlString) else { throw NetworkError.invalidURL }
        let data = try await session.execute(url: url)
        return try JSONDecoder().decode(LyricsModel.self, from: data)
    }
    
}

extension String {
    func encodeUrl() -> String {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
    func decodeUrl() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
