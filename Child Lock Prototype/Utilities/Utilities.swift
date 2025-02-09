//
//  Utilities.swift
//  Child Lock Prototype
//
//  Created by Yevin Warnapura on 2024-05-01.
//

import Foundation
import UIKit

final class Utilities {
    
    static let shared = Utilities()
    private init() {}
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
