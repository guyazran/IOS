//
//  Bouncer.swift
//  Bouncing Ball Exercise
//
//  Created by Guy Azran on 11/10/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class Bouncer {
    private var _squareView: UIView;
    private var velocityX:CGFloat;
    private var velocityY:CGFloat;
    private var colors = [UIColor.greenColor(), UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.purpleColor(), UIColor.orangeColor(), UIColor.blackColor()];
    
    init(x: CGFloat, y: CGFloat, velocityX: CGFloat, velocityY: CGFloat, color: Int){
        _squareView = UIView(frame: CGRect(x: x, y: y, width: 30, height: 30));
        if(color < colors.count && color >= 0){
            _squareView.backgroundColor = colors[color];
        } else{
            _squareView.backgroundColor = UIColor.greenColor();
        }
        
        self.velocityX = velocityX;
        self.velocityY = velocityY;
    }
    
    var squareView:UIView{
        get{
            return _squareView;
        }
    }
    
    func move(){
        _squareView.frame.origin.x += velocityX;
        _squareView.frame.origin.y += velocityY;
    }
    
    func checkBounceOffFrame(frame: CGRect){
        if _squareView.frame.origin.x + _squareView.frame.width >= frame.maxX || _squareView.frame.origin.x <= frame.origin.x{
            velocityX *= -1;
        }
        
        if _squareView.frame.origin.y + _squareView.frame.height >= frame.maxY || _squareView.frame.origin.y <= frame.origin.y{
            velocityY *= -1;
        }
    }
}