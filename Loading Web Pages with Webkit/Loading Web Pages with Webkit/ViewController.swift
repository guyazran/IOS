//
//  ViewController.swift
//  Loading Web Pages with Webkit
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = WKPreferences();
        preferences.javaScriptEnabled = true;
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences;
        
        webView = WKWebView(frame: view.bounds, configuration: configuration);
        webView!.frame.origin = CGPoint(x: 0, y: 20);
        if let theWebView = webView{
            let url = NSURL(string: "http://www.ynet.co.il");
            let urlRequest = NSURLRequest(URL: url!);
            theWebView.loadRequest(urlRequest);
            theWebView.navigationDelegate = self;
            view.addSubview(theWebView);
        }
    }
    
    //this function is called when the request is sent in te loadRequest function
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
    }
    
    //this function is called when the web page has loaded
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
    }
    
    //this function is called when a navigation action occurs in the webView
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .LinkActivated{
            decisionHandler(.Cancel)
            let alertController = UIAlertController(title: "Action not allowed!", message: "links are not allowed", preferredStyle: .Alert);
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil));
            presentViewController(alertController, animated: true, completion: nil);
            return;
        }
        decisionHandler(.Allow);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

