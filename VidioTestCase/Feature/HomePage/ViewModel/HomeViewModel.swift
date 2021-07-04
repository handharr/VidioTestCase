//
//  HomeViewModel.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 03/07/21.
//

import Foundation
import Combine

class HomeViewModel {
    
    let urlString = "https://ghibliapi.herokuapp.com/films"
    var subcription: AnyCancellable?
    var dataPublisher = CurrentValueSubject<[[Video]], Never>([[]])
    
    init() {
        subcription = fetchVideo().sink(receiveValue: { [weak self] videos in
            let top = Array(videos[0...4])
            let others = Array(videos[5...])
            
            self?.dataPublisher.value = [top, others]
        })
    }
    
    private func fetchVideo() -> AnyPublisher<[Video],Never> {
        guard let url = URL(string: urlString) else {
            return Just([]).eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [Video].self, decoder: JSONDecoder())
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
    

    public func getSectionItems(_ section: Int) -> Int {
        return dataPublisher.value[section].count
    }
    
    public func getDataCount() -> Int {
        return dataPublisher.value.count
    }
}
