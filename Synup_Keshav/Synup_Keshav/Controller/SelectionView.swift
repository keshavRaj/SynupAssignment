//
//  SelectionView.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import UIKit

@IBDesignable class SelectionView: UIView {
    
    @IBInspectable var isSelected: Int = 1 {
        didSet {
            _isSelected = isSelected > 0 ? true : false
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var defaultColor: UIColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var selectionColor: UIColor = UIColor.green {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var _isSelected = true
    private let strokeWidth: CGFloat = 1

    override func draw(_ rect: CGRect) {
        print("isselected = \(_isSelected)")
        let color = _isSelected ? selectionColor : defaultColor
        let radius = (min(rect.width, rect.height) - strokeWidth) / 2
        let startAngle = CGFloat.pi
        let endAngle = 2 * CGFloat.pi + startAngle
        let strokePath = UIBezierPath(arcCenter: CGPoint(x: rect.width / 2, y: rect.height / 2), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        color.setStroke()
        strokePath.stroke()
      
        if _isSelected {
            let fillPath =  UIBezierPath(arcCenter: CGPoint(x: rect.width / 2, y: rect.height / 2), radius: radius * 0.6, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            color.setFill()
            fillPath.fill()
        }
        
    }

}
