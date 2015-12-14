//
//  ViewController.swift
//  Animating Views
//
//  Created by Guy Azran on 12/10/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!;
    var image = UIImage(named: "smiley_4_small");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: image);
        imageView.frame = CGRect(x: 0, y: 30, width: 100, height: 100);
        view.addSubview(imageView);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        let endRect = CGRect(x: view.bounds.width - 100, y: view.bounds.height - 100, width: 100, height: 100);
        UIView.animateWithDuration(5.0, animations: { [weak self]() -> Void in
            self!.imageView.frame = endRect;
            self!.imageView.alpha = 0;
            let scale = CGAffineTransformMakeScale(2, 2);
            let rotation = CGAffineTransformMakeRotation(CGFloat((90.0 * M_PI) / 180.0));
            self!.imageView.transform = CGAffineTransformConcat(scale, rotation);
            }) { [weak self](completed) -> Void in
                print("finished");
                self!.imageView.removeFromSuperview();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

