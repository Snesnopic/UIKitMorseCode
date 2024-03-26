//
//  QuickTranslateViewController.swift
//  UIKitExample
//
//  Created by Giuseppe Francione on 25/03/24.
//

import UIKit

class QuickTranslateViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        // display an edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.title = "Quick translate"
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        // code to create rows
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let sentence = sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = sentence.sentence
            cell.contentConfiguration = contentConfiguration
        }
        
        // code to initialize the array to the data
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        var sentenceTitles = [String]()
        for sentence in sampleData {
            sentenceTitles.append(sentence.sentence)
        }
        snapshot.appendItems(sentenceTitles)
        dataSource.apply(snapshot)
        collectionView.dataSource = dataSource
    }
    
    // list configuration
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    // function to move elements in the list
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedSentence = sampleData.remove(at: sourceIndexPath.row)
        sampleData.insert(movedSentence, at: destinationIndexPath.row)
    }
    
  
    
}
