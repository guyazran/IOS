//
//  ViewController.swift
//  Animating Your UI Components with Push
//
//  Created by Guy Azran on 11/5/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var squareView: UIView?;
    var animator: UIDynamicAnimator?;
    var pushBehavior: UIPushBehavior?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSmallSquareView();
        createGestureRecognizer();
        createAnimatorAndBehaviors()
        
    }
    
    func createSmallSquareView(){
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80));
        if let theSquareView = squareView{
            theSquareView.backgroundColor = UIColor.greenColor();
            theSquareView.center = view.center;
            view.addSubview(theSquareView);
        }
    }
    
    func createGestureRecognizer(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:");
        view.addGestureRecognizer(tapGestureRecognizer);
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        //get the angle between the center of the square view and the tap point
        let tapPoint = sender.locationInView(view);
        
        //calculate the angle between the center point of the square and the tap point to find out the angle of the push
        let deltaX = tapPoint.x - squareView!.center.x;
        let deltaY = tapPoint.y - squareView!.center.y;
        let angle = atan2(deltaY, deltaX);
        
        pushBehavior!.angle = angle;
        
        //use the distancebetween the tap point and the center of the square view to calculate the magnitude of the push
        let distanceBetweenPoints = sqrt(deltaX * deltaX + deltaY * deltaY);
        pushBehavior!.magnitude = distanceBetweenPoints / 200;
    }
    
    func createAnimatorAndBehaviors(){
        animator = UIDynamicAnimator(referenceView: view);
        
        if let theSquareView = squareView{
            //create collision detection
            let collision = UICollisionBehavior(items: [theSquareView]);
            collision.translatesReferenceBoundsIntoBoundary = true;
            //create push detection
            pushBehavior = UIPushBehavior(items: [theSquareView], mode: .Continuous);
            animator!.addBehavior(collision);
            animator!.addBehavior(pushBehavior!);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

