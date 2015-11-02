//
//  ViewController.swift
//  Creating Scrollable Content with UIScrollView
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView!;
    var scrollView: UIScrollView!;
    let image = UIImage(named: "fat_cat");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: image);
        scrollView = UIScrollView(frame: view.bounds);
        scrollView.addSubview(imageView);
        scrollView.contentSize = imageView.bounds.size;
        scrollView.delegate = self;
        scrollView.indicatorStyle = .White;
        view.addSubview(scrollView);
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.alpha = 0.5;
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.alpha != 1{
            scrollView.alpha = 1;
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.alpha != 1{
            scrollView.alpha = 1;
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

