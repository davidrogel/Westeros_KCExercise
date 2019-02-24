//
//  Sigil.swift
//  Westeros
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

final class Sigil
{
    // MARK: Properties
    let description: String
    let image: UIImage
    
    // MARK: Initialization
    init(image: UIImage, description: String)
    {
        self.description = description
        self.image = image
    }
}
