//
//  NightLightViewController.swift
//  Haven
//
//  Created by Josh on 12/6/17.
//  Copyright © 2017 Josh Land. All rights reserved.
//

import UIKit
import SnapKit

class NightLightViewController: UIViewController {
    private var commandCollectionView: UICollectionView?
    private var commandCollectionViewManager: APICommandCollectionViewManager?
    // Custom UI Elements
    private var backgroundSlice: UIView?
    private var selectionWheel: SelectionWheel?
    
    enum Constants {
        static let baseBackgroundColor = UIColor.TextLightGray
        static let commandCollectionSpacing = 120
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.baseBackgroundColor
        
        self.setupDualPaneBackground()
        self.setupCollectionView()
        
        SelectionWheel.create(size: CGSize(width: 175, height: 175), foreground: UIColor.LightGray, background: UIColor.white) { (circle) in
            guard let circle = circle else { return }
            self.view.addSubview(circle.baseView)
            self.selectionWheel = circle
            self.selectionWheel?.setButtonHandlers(topButton: { [weak self] in
                self?.topButtonPressed()
            }, bottomButton: { [weak self] in
                self?.bottomButtonPressed()
            })
            
            self.selectionWheel?.baseView.snp.makeConstraints({ (make) in
                make.center.equalTo(self.view)
            })
        }
    }
    
    // Note: Potential race condition - make sure the background slice exists before
    // Constraining against it - won't crash but won't do anything either - if you're having problems
    // POtentially start here.
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        self.view.addSubview(collectionView)
        self.commandCollectionView = collectionView
        self.commandCollectionView?.backgroundColor = Constants.baseBackgroundColor
        
        let setBrightnessApiCommand = APICommand(title: "Set Brightness", commandImage: #imageLiteral(resourceName: "SetTemp")) { [weak self] in
            print("Set Brightness!! \(self.debugDescription)")
        }
        self.commandCollectionViewManager = APICommandCollectionViewManager(with: [setBrightnessApiCommand, setBrightnessApiCommand, setBrightnessApiCommand],
                                                                            collectionView: collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            guard let backgroundSlice = self.backgroundSlice else { return }
            
            make.top.equalTo(backgroundSlice.snp.bottom).offset(Constants.commandCollectionSpacing)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.commandCollectionView?.reloadData()
        }
        
    }
    
    private func setupDualPaneBackground() {
        let topBackgroundSlice = UIView()
        self.view.addSubview(topBackgroundSlice)
        topBackgroundSlice.backgroundColor = UIColor.BabyBlue
        
        topBackgroundSlice.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-self.view.bounds.height / 2)
        }
        self.backgroundSlice = topBackgroundSlice
    }
    
    deinit {
        self.backgroundSlice = nil
        self.commandCollectionViewManager = nil
        self.commandCollectionView = nil
        self.selectionWheel = nil
    }
    
    private func topButtonPressed() {
        // TODO: API Call
    }
    
    private func bottomButtonPressed() {
        // TODO: API Call
    }
}
