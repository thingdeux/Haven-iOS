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

    override func viewDidLoad() {
        super.viewDidLoad()
        SelectionWheel.create(size: CGSize(width: 175, height: 175), foreground: UIColor.LightGray, background: UIColor.black) { (circle) in
            guard let circle = circle else { return }
            self.view.addSubview(circle)
            circle.snp.makeConstraints({ (make) in
//                make.center.equalTo(self.view)
            })
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
