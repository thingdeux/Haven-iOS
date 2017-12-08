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
    
    /// Create a selection circle
    static func create(size: CGSize, foreground: UIColor, background: UIColor, createdHandler: @escaping SelectionWheelCreationHandler) {
        DispatchQueue.main.async {
            do {
                let circle = try SelectionWheel.generateWheelLayers(size: size, foreground: foreground, background: background)
                SelectionWheel.generateLabels(on: circle)
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
    
    /// Generate 3 Labels - top label
    static fileprivate func generateLabels(on baseView: UIView) {
        let topButton = UIButton()
        let middleLabel = UILabel()
        let bottomButton = UIButton()
        
        topButton.titleLabel?.text = "+"
        middleLabel.text = "- -"
        bottomButton.titleLabel?.text = "-"
        
        baseView.addSubview(topButton)
        baseView.addSubview(middleLabel)
        baseView.addSubview(bottomButton)
        
        topButton.snp.makeConstraints { (make) in
            make.top.equalTo(baseView.snp.top).offset(20)
            make.bottom.equalTo(middleLabel.snp.top).offset(15)
            make.centerY.equalTo(middleLabel.snp.centerY)
        }
        
        middleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(baseView)
            make.bottom.equalTo(bottomButton.snp.top).offset(15)
        }
        
        bottomButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(baseView.snp.bottom).offset(-20)
            make.centerY.equalTo(middleLabel.snp.centerY)
        }
        
    }
}


/*
    +
  [ 6 ]
    -
*/
