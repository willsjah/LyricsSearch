//
//  NetworkSession.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import Foundation

protocol SessionProtocol {
    func execute(url: URL?) async throws -> Data
}

enum NetworkError: Error {
    case invalidURL
    case missingData
}

class NetworkSession: SessionProtocol {
    func execute(url: URL?) async throws -> Data {
        guard let url = url else { throw NetworkError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
