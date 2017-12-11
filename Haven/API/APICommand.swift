//
//  APICommand.swift
//  Haven
//
//  Created by Josh on 12/10/17.
//  Copyright © 2017 Josh Land. All rights reserved.
//

import UIKit

protocol APICommandDisplayable {
    var title: String { get }
    var image: UIImage { get }
    var tappedHandler: EmptyCompletionHandler? { get set }
}

struct APICommand : APICommandDisplayable {
    var title: String
    var image: UIImage
    var tappedHandler: EmptyCompletionHandler?
    
    init(title: String, commandImage: UIImage, tappedHandler: EmptyCompletionHandler?) {
        self.image = commandImage
        self.title = title
        self.tappedHandler = tappedHandler
    }
}
