//
//  UIViewControllerNavigation.swift
//  Westeros
//
//  Created by david rogel pernas on 06/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

extension UIViewController
{
    func wrappedInNavigation() -> UINavigationController
    {
        return UINavigationController(rootViewController: self)
    }
}

