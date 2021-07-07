//
//  HomeViewModel.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 03/07/21.
//

import Foundation
import Combine

class HomeViewModel {

    var subscription: AnyCancellable?
    var dataPublisher = CurrentValueSubject<[[Video]], Never>([[]])
    
    public func fetchVideo() {
        let fetchPublisher: AnyPublisher<[Video],Never> = APICaller.shared.fetchVideo()
        
        self.subscription = fetchPublisher.sink { [weak self] videos in
            
            let top = Array(videos[0...4])
            let others = Array(videos[5...])
            
            self?.dataPublisher.value = [top, others]
        }
    }

    public func getSectionItems(_ section: Int) -> Int {
        return dataPublisher.value[section].count
    }
    
    public func getDataCount() -> Int {
        return dataPublisher.value.count
    }
}
