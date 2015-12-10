//
//  View.swift
//  Graphics
//
//  Created by Guy Azran on 12/10/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class View: UIView {
    
    override func drawRect(rect: CGRect) {
        //drawText();
        //drawImage();
        //drawLine();
        //drawPath();
        //drawRectangle();
        //drawRectangles();
        //addShadowsToShapes();
        transformView();
    }
    
    func drawText(){
        let fontName = "HelveticaNeue-Bold";
        let helveticaBold = UIFont(name: fontName, size: 40.0);
        let string = "Some text" as NSString;
        string.drawAtPoint(CGPoint(x: 40, y: 180), withAttributes: [NSFontAttributeName : helveticaBold!]);
    }
    
    func drawImage(){
        let image = UIImage(named: "angry_birds_small");
        //image!.drawAtPoint(CGPoint(x: 20, y: 20));
        image!.drawInRect(CGRect(x: 20, y: 20, width: 100, height: 100));
    }
    
    func drawLine(){
        UIColor.brownColor().set();
        let context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 5);
        CGContextSetLineJoin(context, .Miter);
        CGContextMoveToPoint(context, 50, 20);
        CGContextAddLineToPoint(context, 100, 200);
        CGContextAddLineToPoint(context, 300, 100);
        CGContextAddLineToPoint(context, 50, 20);
        CGContextAddLineToPoint(context, 100, 200); //go over the last line to smooth line joint
        CGContextStrokePath(context);
    }
    
    func drawPath(){
        let path = CGPathCreateMutable();
        let screenBounds = UIScreen.mainScreen().bounds;
        CGPathMoveToPoint(path, nil, screenBounds.origin.x, screenBounds.origin.y);
        CGPathAddLineToPoint(path, nil, screenBounds.width, screenBounds.height);
        CGPathMoveToPoint(path, nil, screenBounds.width, screenBounds.origin.y);
        CGPathAddLineToPoint(path, nil, screenBounds.origin.x, screenBounds.height);
        let context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, path);
        UIColor.blueColor().setStroke();
        CGContextSetLineWidth(context, 5);
        CGContextDrawPath(context, .Stroke);
    }
    
    func drawRectangle(){
        let path = CGPathCreateMutable();
        let rectangle = CGRect(x: 10, y: 30, width: 200, height: 300);
        CGPathAddRect(path, nil, rectangle);
        let context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, path);
        UIColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 1.0).setFill();
        UIColor.brownColor().setStroke();
        CGContextSetLineWidth(context, 5);
        CGContextDrawPath(context, .FillStroke);
    }
    
    func drawRectangles(){
        let path = CGPathCreateMutable();
        let rectangle1 = CGRect(x: 10, y: 30, width: 200, height: 300);
        let rectangle2 = CGRect(x: 40, y: 100, width: 100, height: 300);
        let rectangles = [rectangle1, rectangle2];
        CGPathAddRects(path, nil, rectangles, 2);
        let context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, path);
        UIColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 1.0).setFill();
        UIColor.brownColor().setStroke();
        CGContextSetLineWidth(context, 5);
        CGContextDrawPath(context, .FillStroke);
    }
    
    func addShadowsToShapes(){
        let context = UIGraphicsGetCurrentContext();
        let offset = CGSize(width: 10, height: 10);
        CGContextSetShadowWithColor(context, offset, 20, UIColor.grayColor().CGColor);
        let path = CGPathCreateMutable();
        let firstRect = CGRect(x: 55, y: 60, width: 150, height: 150);
        CGPathAddRect(path, nil, firstRect);
        CGContextAddPath(context, path);
        UIColor(red: 1, green: 0.5, blue: 0.7, alpha: 1.0).setFill();
        CGContextDrawPath(context, .Fill);
    }
    
    func transformView(){
        let path = CGPathCreateMutable();
        let rectangle = CGRect(x: 10, y: 30, width: 200, height: 300);
        var translate = CGAffineTransformMakeTranslation(100, 0); //translate (move)
        var rotate = CGAffineTransformMakeRotation(CGFloat((45.0 * M_PI) / 180.0)); //rotation (the axis is the top left corner of the screen)
        var transform = CGAffineTransformTranslate(rotate, 200, 100) //add transformation property to an existing transform
        CGPathAddRect(path, &transform, rectangle);
        let context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, path);
        UIColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 1.0).setFill();
        UIColor.brownColor().setStroke();
        CGContextSetLineWidth(context, 5);
        CGContextDrawPath(context, .FillStroke);
    }
}




