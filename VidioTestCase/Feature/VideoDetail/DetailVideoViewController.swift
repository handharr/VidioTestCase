//
//  DetailVideoViewController.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 04/07/21.
//

import UIKit

class DetailVideoViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var model: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        guard let model = model,
              let image = UIImage(named: model.id) else {return}
        
        posterImageView.image = image
        videoTitle.text = model.title
        directorLabel.text = model.director
        descLabel.text = model.description
        releaseDateLabel.text = "· \(model.releaseDate)"
    }
}
