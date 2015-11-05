//
//  ViewController.swift
//  Snap Effect to UI Components
//
//  Created by Guy Azran on 11/5/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var squareView: UIView?;
    var animator: UIDynamicAnimator?;
    var snapBehavior: UISnapBehavior?;
    
    func createGestureRecognizer(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:");
        view.addGestureRecognizer(tapGestureRecognizer);
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        //get the angle between the center of the square view and the tap point
        let tapPoint = sender.locationInView(view);
        animator?.removeBehavior(snapBehavior!);
        
        snapBehavior! = UISnapBehavior(item: squareView!, snapToPoint: tapPoint);
        snapBehavior!.damping = 0.5;
        animator!.addBehavior(snapBehavior!);
    }
    
    func createSmallSquareView(){
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80));
        if let theSquareView = squareView{
            theSquareView.backgroundColor = UIColor.greenColor();
            theSquareView.center = view.center;
            view.addSubview(theSquareView);
        }
    }
    
    func createAnimatorAndBehaviors(){
        animator = UIDynamicAnimator(referenceView: view);
        
        let collision = UICollisionBehavior(items: [squareView!]);
        collision.translatesReferenceBoundsIntoBoundary = true;
        animator!.addBehavior(collision);
        
        snapBehavior = UISnapBehavior(item: squareView!, snapToPoint: squareView!.center);
        snapBehavior!.damping = 0.5;
        animator!.addBehavior(snapBehavior!);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSmallSquareView();
        createGestureRecognizer();
        createAnimatorAndBehaviors();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

