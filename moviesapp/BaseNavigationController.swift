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
        self.navigationBar.tintColor = .green
        self.navigationBar.prefersLargeTitles = false
        if #available(iOS 15.0, *) {
        } else if #available(iOS 13.0, *) {
            self.navigationBar.barTintColor = .white
        }
        self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layoutIfNeeded()

    }
}
