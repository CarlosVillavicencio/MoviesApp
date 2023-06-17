//
//  BaseNavigationController.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation
import UIKit

open class BaseNavigationController: UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = .black
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layoutIfNeeded()

    }
}
