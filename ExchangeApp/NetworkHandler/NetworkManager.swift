//
//  NetworkManager.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import Foundation

enum HttpType: String {
    case GET
    case post
    case PUT
}

enum NetworkResult<T> {
    case success(response: T)
    case failure(error: Error?)
}

struct ResponseType<T: Codable> {
    let responseType: T.Type
    static func type(_ type: T.Type) -> ResponseType {
        return self.init(responseType: type)
    }
}

#warning("Optimization is required in the next sprint.")
final class NetworkManager {
    static let shared = NetworkManager()
    func request<T>(_ endpoint: String, httpType: HttpType, forType: ResponseType<T>, callback: @escaping (NetworkResult<T>) -> Void) where T: Codable {
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = httpType.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                callback(.failure(error: error))
            }
            guard let data = data, let result = self?.decode(data, forType: T.self) else {
                callback(.failure(error: nil))
                return
            }
            callback(.success(response: result))
        }.resume()
    }
    
    func decode<T>(_ data: Data, forType: T.Type) -> T? where T: Decodable {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("decoding error : \(error)")
            return nil
        }
    }
}
