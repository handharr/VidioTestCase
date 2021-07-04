//
//  CollectionSectionHeader.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 04/07/21.
//

import UIKit

class CollectionSectionHeader: UICollectionReusableView {
    
    static let identifier = "CollectionSectionHeader"
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        label.text = "Header"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        textLabel.frame = .init(x: 0, y: 20, width: frame.size.width, height: frame.size.height-20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
