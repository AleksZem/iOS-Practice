//
//  UIButton+BackgroundColor.swift
//  FinalProject
//
//  Created by Aleks on 4/28/18.
//  Copyright © 2018 Aleks. All rights reserved.
//

import UIKit

extension UIButton{
    func colorToImage(withColor color: UIColor) -> UIImage?{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func setBackgroundColor(color: UIColor, for state: UIControlState){
        self.setBackgroundImage(colorToImage(withColor: color), for: state)
    }
}
