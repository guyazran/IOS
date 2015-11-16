//
//  ViewController.swift
//  Learning CoreLocation and MapKit
//
//  Created by Guy Azran on 11/16/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, LocationDelegate, MKMapViewDelegate {

    var mapView: MKMapView!;
    var myAnnotation: MyAnnotation!;
    
    var counter:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView(frame: view.frame);
        mapView.mapType = .Standard;
        mapView.delegate = self;
        view.addSubview(mapView);
        addPinTopMapView(32.08494427, longitude: 34.800543);
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).locationDelegate = self;
    }
    
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
        let region = MKCoordinateRegion(center: location, span: span);
        mapView.setRegion(region, animated: true);
    }
    
    func addPinTopMapView(latitude: Double, longitude: Double){
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        if myAnnotation == nil{
            myAnnotation = MyAnnotation(coordinate: location, title: "My Title", subtitle: "My Subtitle");
        } else{
            myAnnotation.coordinate = location;
        }
        mapView.addAnnotation(myAnnotation);
        setCenterOfMapToLocation(location);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationChanged(latitude: Double, longitude: Double) {
        if myAnnotation != nil{
            mapView.removeAnnotation(myAnnotation);
        }
        addPinTopMapView(latitude, longitude: longitude);
        
        print("location changed \(latitude), \(longitude)");
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MyAnnotation == false{
            return nil;
        }
    
        let senderAnnotation = annotation as! MyAnnotation;
        
        let pinReusableIdentifier = "\(++counter)";
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(pinReusableIdentifier) as? MKPinAnnotationView;
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinReusableIdentifier);
            annotationView!.canShowCallout = true;
            annotationView!.pinTintColor = senderAnnotation.pinColor;
        } else{
            annotationView!.annotation = annotation;
        }
        
        return annotationView;
    }
}

