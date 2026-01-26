//
//  NetworkClient.swift
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

import Foundation
final class NetworkClient {

    static func get<T: Decodable>(_ url: URL,
                                 completion: @escaping (Result<T, Error>) -> Void) {

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let data else { return }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
