//
//  VideoCollectionViewCell.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 04/07/21.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "VideoCollectionViewCell", bundle: nil)
    }

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
    
    public func setupUI(_ model: Video) {
        if let image = UIImage(named: model.id) {
            posterImageView.image = image
        } else {
            posterImageView.backgroundColor = .lightGray
        }
    }
}
