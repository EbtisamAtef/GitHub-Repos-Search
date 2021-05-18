//
//  Navigator.swift
//  GitHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//

import UIKit

struct Navigator {
    
    
    enum DisplayVCType {
        case push
        case present
    }
    
    private var viewController: UIViewController
    static private var mainSBName = ""
    
    
    init(vc: UIViewController , mainSBName:String) {
        self.viewController = vc
        Navigator.mainSBName = mainSBName
    }
    
    
    public func instantiateVC<T>(withDestinationViewControllerType vcType: T.Type, andStoryboardName sbName: String = mainSBName) -> T? where T: UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: sbName, bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: String(describing: vcType.self))
        return destinationVC as? T
    }
    
    public func goToNextScreen(viewController destinationVC: UIViewController,withDisplayVCType type: DisplayVCType = .present, andModalPresentationStyle style: UIModalPresentationStyle = .overFullScreen) {
        switch type {
        case .push:
            viewController.navigationController?.pushViewController(destinationVC, animated: true)
        case .present:
            destinationVC.modalPresentationStyle = style
            viewController.present(destinationVC, animated: true, completion: nil)
        }
    }
    
}
