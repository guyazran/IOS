//
//  MyAnnotation.swift
//  Learning CoreLocation and MapKit
//
//  Created by Guy Azran on 11/16/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0);
    var title: String?;
    var subtitle: String?;
    var pinColor: UIColor!;
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, pinColor: UIColor) {
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
        self.pinColor = pinColor;
        super.init();
    }
    
    convenience init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.init(coordinate: coordinate, title: title, subtitle: subtitle, pinColor: UIColor.greenColor());
    }
}



