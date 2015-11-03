//
//  ViewController.swift
//  Adding Gravity to your UI Components
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var squareViews = [UIView]() ;
    var animator: UIDynamicAnimator?;
    let bottomBoundary = "bottomBoundary";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        
        let colors = [UIColor.redColor(), UIColor.greenColor()];
        
        var currentCenterPoint = view.center;
        currentCenterPoint.y = 20;
        let eachViewSize = CGSize(width: 50, height: 50);
        for counter in 0 ..< 2{
            let newView = UIView(frame: CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height));
            newView.backgroundColor = colors[counter];
            newView.center = currentCenterPoint;
            currentCenterPoint.y += eachViewSize.height + 10;
            squareViews.append(newView);
            view.addSubview(newView);
        }
        
        animator = UIDynamicAnimator(referenceView: view);
        if let theAnimator = animator{
            let gravity = UIGravityBehavior(items: squareViews);
            theAnimator.addBehavior(gravity);
            
            let collision = UICollisionBehavior(items: squareViews);
            collision.translatesReferenceBoundsIntoBoundary = true;
            theAnimator.addBehavior(collision);
            collision.collisionDelegate = self;
            let fromPoint = CGPoint(x: 100, y: 300);
            let toPoint = CGPoint(x: view.frame.maxX, y: 200);
            collision.addBoundaryWithIdentifier(bottomBoundary, fromPoint: fromPoint, toPoint: toPoint);
            
        }
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        if identifier as? String == bottomBoundary{
            
            UIView.animateWithDuration(2, animations: { () -> Void in
                let view = item as! UIView;
                view.backgroundColor = UIColor.redColor();
                view.alpha = 0.0;
                view.transform = CGAffineTransformMakeScale(1, 1);
                }, completion: { (finished: Bool) -> Void in
                    let view = item as! UIView;
                    behavior.removeItem(item);
                    view.removeFromSuperview();
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

