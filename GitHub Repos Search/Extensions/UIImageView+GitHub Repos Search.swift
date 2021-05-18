//
//  UIImageView+Brightskies.swift
//  itHub Repos Search
//
//  Created by ebtisam atef on 5/17/21.
//  


import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(image: String?, placeHolder: UIImage? = nil, complition: (() -> Void)? = nil){
        if let image = image, let url = URL(string: image) {
             self.kf.indicatorType = .activity
            (self.kf.indicator?.view as? UIActivityIndicatorView)?.color = .blue
             self.kf.setImage(with: url, placeholder: placeHolder, options: [.transition(.fade(0.5))]) { (result) in
                complition?()
            }
        }else{
            self.image = placeHolder
        }
        
    }
    
}
