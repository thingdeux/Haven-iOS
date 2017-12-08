//
//  SelectionWheel.swift
//  Haven
//
//  Created by Josh on 12/7/17.
//  Copyright © 2017 Josh Land. All rights reserved.
//

import UIKit

enum SelectionWheelError: Error {
    case sizeNotEqual
}

class SelectionWheel {
    enum Constants {
        // Smaller value = thicker line
        static let lineThickness: CGFloat = 0.97
    }
    typealias SelectionWheelCreationHandler = (_ wheel: UIView?) -> Void
    
    private init() {}
    
    static func create(size: CGSize, foreground: UIColor, background: UIColor, createdHandler: @escaping SelectionWheelCreationHandler) {
        DispatchQueue.main.async {
            do {
                let circle = try SelectionWheel.generateWheelLayers(size: size, foreground: foreground, background: background)
                createdHandler(circle)
            } catch {
                createdHandler(nil)
            }
        }
    }
    
    static fileprivate func generateWheelLayers(size: CGSize, foreground: UIColor, background: UIColor) throws -> UIView {
        guard size.width == size.height else {
            print("😤 Your Circle must have an equal Width and Height")
            throw SelectionWheelError.sizeNotEqual
        }
        // Create what will be the circle border
        let circleBackground = UIView()
        circleBackground.layer.cornerRadius = size.height / 2
        circleBackground.backgroundColor = background
        circleBackground.snp.makeConstraints { (make) in
            make.height.equalTo(size.height)
            make.width.equalTo(size.width)
        }
        // 2. Create Inner Circle
        let circleForeground = UIView()
        circleForeground.layer.cornerRadius = (size.height * Constants.lineThickness) / 2
        circleForeground.backgroundColor = foreground
        circleBackground.addSubview(circleForeground)
        circleForeground.snp.makeConstraints { (make) in
            make.center.equalTo(circleBackground)
            make.height.equalTo(size.height * Constants.lineThickness)
            make.width.equalTo(size.width * Constants.lineThickness)
        }
        
        return circleBackground
    }
    
    private func generateLabels() {
        
    }
}


/*
    +
  [ 6 ]
    -
*/
