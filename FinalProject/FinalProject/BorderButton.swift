//
//  BorderButton.swift
//  FinalProject
//
//  Created by Aleks on 4/28/18.
//  Copyright © 2018 Aleks. All rights reserved.
//

import UIKit

class BorderButton: UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth=1/UIScreen.main.nativeScale
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.setBackgroundColor(color: UIColor.white, for: .normal)
//        self.setBackgroundColor(color: UIColor.white, for: .disabled)
//        self.setBackgroundColor(color: UIColor.white, for: .selected)
//        self.setBackgroundColor(color: UIColor.white, for: .focused)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/8
        layer.borderColor = tintColor.cgColor
    }
}
