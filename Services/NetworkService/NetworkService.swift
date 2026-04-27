//
//  NetworkService.swift
//  Bank App
//
//  Created by Egor on 27.04.2026.
//

import Foundation

// MARK: – Network Errors
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data in response"
        case .httpError(let statusCode):
            return "HTTP Error \(statusCode)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

final class NetworkService {
    
    // MARK: – Singleton
    static let shared = NetworkService()
    
    // MARK: – Properties
    private let baseURL = "https://belarusbank.by/api"
    private let session: URLSession
    
    // MARK: – INIT
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        
        session = URLSession(configuration: configuration)
    }
    
    // MARK: – GCD подход (Completion Handler)
    
    func fetchExchangeRates(completion: @escaping (Result<[ExchangeRatesModel], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/kurs_cards") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let rates = try decoder.decode([ExchangeRatesModel].self, from: data)
                completion(.success(rates))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
}

