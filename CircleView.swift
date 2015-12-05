//
//  CircleView.swift
//  owlympics
//
//  Created by Martin Zhou on 9/11/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import UIKit

class CircleView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.whiteColor().setFill()
        path.fill()
    }

}
