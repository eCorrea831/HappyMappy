//
//  MapQuestion.swift
//  HappyMappy
//
//  Created by Aditya Narayan on 6/9/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

import UIKit
import MapKit

class MapQuestion {
    
    var location:CLLocationCoordinate2D
    var regionSizeInMeters:Double
    var answers:Dictionary<String, Bool> = [:]
    
    init(location:CLLocationCoordinate2D, regionSizeInMeters:Double) {
        self.location = location
        self.regionSizeInMeters = regionSizeInMeters
    }
    
    func addAnswer(name:String, isCorrect:Bool) {
        
        if isCorrect == true && self.answers.values.contains(true) {
            return
        }
        
        answers[name] = isCorrect
    }
}

