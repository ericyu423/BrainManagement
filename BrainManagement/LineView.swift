//
//  lineView.swift
//  BrainManagement
//
//  Created by eric yu on 5/13/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    var isCrossed = false
    
    var path: UIBezierPath = {
        let p = UIBezierPath()
        UIColor.black.setStroke()
        p.lineWidth = 0.5
        return p
    }()
    
    let shapeLayer:CAShapeLayer = {
        let sl = CAShapeLayer()
        sl.strokeColor = UIColor.red.cgColor
        sl.fillColor = UIColor.clear.cgColor
        sl.lineWidth = 0.5
        sl.lineCap = kCALineCapRound
        return sl
    }()
    
    let animation:CABasicAnimation = {
        let an = CABasicAnimation(keyPath: "strokeEnd")
        an.fromValue = 0.0
        an.toValue = 1.0
        an.duration = 0.5
        an.fillMode = kCAFillModeForwards
        an.isRemovedOnCompletion = false
        return an
    }()
    
    
    func crossOff(){
        if isCrossed == false {
            isCrossed = true
            
            path.move(to: CGPoint(x: 0, y: getRandomHeight()))
            path.addLine(to: CGPoint(x: self.bounds.width, y: getRandomHeight()))
    
            shapeLayer.path = path.cgPath
        
            layer.addSublayer(shapeLayer)
            shapeLayer.add(animation, forKey: "drawLineAnimation")
            
        }else{
           clear()
        }
    }
    
    func clear(){
        isCrossed = false
        
        guard let sublayers = self.layer.sublayers else {return}
        
        for layer in sublayers {
            
            layer.removeFromSuperlayer()
        }
        path.removeAllPoints()
    }
    
    func getRandomHeight()-> CGFloat{
        //random height within frame
        return self.bounds.height * CGFloat(drand48())
    }
  


}
