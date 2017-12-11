//
//  APICommandCollectionViewManager
//  Haven
//
//  Created by Josh on 12/10/17.
//  Copyright © 2017 Josh Land. All rights reserved.
//

import UIKit

class APICommandCollectionViewManager : NSObject {
    private weak var collectionView: UICollectionView?
    private var commands = [APICommandDisplayable]()
    
    init(with commands: [APICommandDisplayable], collectionView: UICollectionView) {
        super.init()
        self.commands = commands
        collectionView.delegate = self
        collectionView.dataSource = self                
        collectionView.register(APICommandCollectionViewCell.self, forCellWithReuseIdentifier: APICommandCollectionViewCell.Constants.reuseId)
        
        self.collectionView = collectionView
    }
}

extension APICommandCollectionViewManager : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < self.commands.count,
            let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: APICommandCollectionViewCell.Constants.reuseId, for: indexPath) as? APICommandCollectionViewCell {
            
            let apiCommand = self.commands[indexPath.row]
            cell.setup(with: apiCommand)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.commands.count
    }
}


extension APICommandCollectionViewManager : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < self.commands.count {
            let apiCommand = self.commands[indexPath.row]
            apiCommand.tappedHandler?()
        }
    }
}

// MARK : UICollectionViewDelegateFlowLayout
extension APICommandCollectionViewManager : UICollectionViewDelegateFlowLayout {    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        // Adjust size so at least 12 buttons should be able to fit on the screen
        let size = CGSize(width: screenWidth / 2.15, height: screenHeight * 0.06)
        return size
    }
}
