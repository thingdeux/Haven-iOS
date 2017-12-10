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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.TextLightGray
        
        self.setupDualPaneBackground()
        
        SelectionWheel.create(size: CGSize(width: 175, height: 175), foreground: UIColor.LightGray, background: UIColor.white) { (circle) in
            guard let circle = circle else { return }
            self.view.addSubview(circle.baseView)
            circle.baseView.snp.makeConstraints({ (make) in
                make.center.equalTo(self.view)
            })
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
    }
    
    
}
