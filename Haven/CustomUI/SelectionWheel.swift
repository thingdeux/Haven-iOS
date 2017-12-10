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
    typealias SelectionWheelCreationHandler = (_ wheel: SelectionWheel?) -> Void
    
    private(set) var baseView: UIView
    // Hold Reference for top / bottom button
    private var topButton: UIButton?
    private var bottomButton: UIButton?
    private var middleLabel: UILabel?
    
    private init(with base: UIView) {
        self.baseView = base
    }
    
    /// Create a selection circle
    static func create(size: CGSize, foreground: UIColor, background: UIColor, createdHandler: @escaping SelectionWheelCreationHandler) {
        DispatchQueue.main.async {
            do {
                let circle = try SelectionWheel.generateWheelLayers(size: size, foreground: foreground, background: background)
                let selectionWheel = SelectionWheel(with: circle)
                selectionWheel.generateLabels(on: selectionWheel.baseView, size: size)
                createdHandler(selectionWheel)
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
    fileprivate func generateLabels(on baseView: UIView, size: CGSize) {
        /*  End Results should be elements in this order.
               +
               6
               -
         */
        
        let elementSize = size.height / 4.0
        
        // Init and Add as Subview
        let topButton = UIButton()
        let middleLabel = UILabel()
        let bottomButton = UIButton()
        baseView.addSubview(topButton)
        baseView.addSubview(middleLabel)
        baseView.addSubview(bottomButton)
        
        topButton.setTitle("+", for: .normal)
        middleLabel.text = "- -"
        bottomButton.setTitle("-", for: .normal)
        // Color
        middleLabel.textColor = UIColor.blue
        topButton.setTitleColor(UIColor.gray, for: .normal)
        bottomButton.setTitleColor(UIColor.gray, for: .normal)
        // Formatting
        middleLabel.font = UIFont.boldSystemFont(ofSize: elementSize * 0.75)
        topButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: elementSize * 0.85)
        bottomButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: elementSize * 0.85)
        
        middleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(baseView)
            make.bottom.equalTo(bottomButton.snp.top).offset(15)
            make.height.equalTo(elementSize)
        }
        
        topButton.snp.makeConstraints { (make) in
            make.top.equalTo(baseView.snp.top).offset(10)
            make.bottom.equalTo(middleLabel.snp.top).offset(15)
            make.centerX.equalTo(middleLabel)
        }
        
        bottomButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(baseView.snp.bottom).offset(-10)
            make.centerX.equalTo(middleLabel)
        }
        
        self.topButton = topButton
        self.bottomButton = bottomButton
        self.middleLabel = middleLabel
    }
}



