//
//  APICommandCollectionViewCell.swift
//  Haven
//
//  Created by Josh on 12/10/17.
//  Copyright © 2017 Josh Land. All rights reserved.
//

import UIKit

class APICommandCollectionViewCell: UICollectionViewCell {
    private var button: UIButton?
    
    enum Constants {
        static let nibName = "APICommandCollectionViewCell"
        static let reuseId = "APICommandCollectionViewCell"
    }        
    
    override func prepareForReuse() {
        self.button = nil
    }
    
    func setup(with apiCommand: APICommandDisplayable) {
        self.setupUI()
        self.button?.setTitle(apiCommand.title, for: .normal)
        self.button?.setImage(apiCommand.image, for: .normal)
    }

    private func setupUI() {
        let button = UIButton()
        let backgroundView = UIView()
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        
        self.contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        self.contentView.layer.shadowRadius = 2
        self.contentView.layer.shadowOpacity = 0.20
        self.contentView.layer.masksToBounds = false
        
        backgroundView.backgroundColor = UIColor.BabyBlue
        
        self.contentView.addSubview(backgroundView)
        self.contentView.addSubview(button)

        backgroundView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        button.snp.makeConstraints { (make) in
            // TODO: Polish - Trimp Asset for API Image and remove this.
            make.left.equalTo(self.contentView.snp.left).offset(-24)
            make.right.equalTo(self.contentView.snp.right)
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.button = button

    }
}

