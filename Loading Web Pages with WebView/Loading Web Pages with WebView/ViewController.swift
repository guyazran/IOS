//
//  ViewController.swift
//  Loading Web Pages with WebView
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frame = view.bounds;
        frame.origin.y = UIApplication.sharedApplication().statusBarFrame.height;
        frame.size.height -= frame.origin.y;

        let webView = UIWebView(frame: frame);
        //let htmlString = "<h1>My Web Page</h1>";
        //webView.loadHTMLString(htmlString, baseURL: nil);
        let url = NSURL(string: "http://www.apple.com");
        let request = NSURLRequest(URL: url!);
        webView.loadRequest(request);
        webView.scalesPageToFit = true;
        webView.delegate = self;
        view.addSubview(webView);
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
    }
    
    //true will hide the status bar, false will show it
    override func prefersStatusBarHidden() -> Bool {
        return false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

