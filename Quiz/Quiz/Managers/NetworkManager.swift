//
//  NetworkManager.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/2/23.
//

import SwiftUI

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let headers = [
        "X-RapidAPI-Key": "3f13e8445emsh7ffe1b49d445fe1p11a5b4jsn68e5a53bf57a",
        "X-RapidAPI-Host": "ases-quiz-api1.p.rapidapi.com"
    ]
    
    private let linkCategories = "https://ases-quiz-api1.p.rapidapi.com/categories"
    private let linkQuestionsFor = "https://ases-quiz-api1.p.rapidapi.com/questions/category/"
    
    private init() {}
    
    func fetchQuestion(for category: String, completion: @escaping (Result<CategoryQuestions, NetworkError>) -> Void) {
        let link = NetworkManager.shared.linkQuestionsFor + category
        NetworkManager.shared.fetchData(link: link, completion: completion)
    }
    
    func fetchCategories(completion: @escaping (Result<Categories, NetworkError>) -> Void) {
        let link = NetworkManager.shared.linkCategories
        NetworkManager.shared.fetchData(link: link, completion: completion)
    }
    
    private func fetchData<T: Decodable>(link: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: link) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(.failure(.unableToComplete))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
            }
        }.resume()
    }
}


