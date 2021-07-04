//
//  HomeViewController.swift
//  VidioTestCase
//
//  Created by Puras Handharmahua on 03/07/21.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    static let topHeaderId = "topHeaderID"
    @IBOutlet weak var homeCollectionView: UICollectionView!
    var homeViewModel: HomeViewModel?
    var videoSubscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel = HomeViewModel()
        videoSubscription = homeViewModel?.dataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.homeCollectionView.reloadData()
            })

        setupCollectionView()
    }
    
    private func setupCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.collectionViewLayout = createLayout()
        
        homeCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        homeCollectionView.register(CollectionSectionHeader.self, forSupplementaryViewOfKind: HomeViewController.topHeaderId, withReuseIdentifier: CollectionSectionHeader.identifier)
        homeCollectionView.register(VideoCollectionViewCell.nib(), forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel?.getSectionItems(section) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeViewModel?.getDataCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        defaultCell.backgroundColor = .systemPink
        defaultCell.layer.cornerRadius = 8
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else {
            return defaultCell
        }
        
        guard let model = homeViewModel?.dataPublisher.value[indexPath.section][indexPath.row]  else {return defaultCell}
        cell.setupUI(model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionSectionHeader.identifier, for: indexPath) as! CollectionSectionHeader
        
        if indexPath.section == 0 {
            header.textLabel.text = "Top Picks For You"
        } else if indexPath.section == 1 {
            header.textLabel.text = "Ghibli Studio Original"
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = homeViewModel?.dataPublisher.value[indexPath.section][indexPath.row]  else {return}
        
        let vc = DetailVideoViewController()
        vc.model = model
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { section, _ in
            if section == 0 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/2),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(250)
                    ),
                    subitem: item,
                    count: 2
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: HomeViewController.topHeaderId,
                        alignment: .topLeading
                    )
                ]
                
                return section
            }
            else if section == 1 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/2),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(250)
                    ),
                    subitem: item,
                    count: 2
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)

                // section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                section.boundarySupplementaryItems = [
                    .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(50)
                        ),
                        elementKind: HomeViewController.topHeaderId,
                        alignment: .topLeading
                    )
                ]
                
                return section
            }
            
            return nil
        }
    }
}
