//
//  APICaller.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 05/07/21.
//

import Foundation
import Combine

class APICaller {
    static let shared = APICaller()
    let urlString = "https://ghibliapi.herokuapp.com/films"
    
    public func fetchVideo<T: Codable>() -> AnyPublisher<[T],Never> {
        guard let url = URL(string: urlString) else {
            return Just([]).eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [T].self, decoder: JSONDecoder())
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
