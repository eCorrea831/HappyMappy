//
//  ViewController.swift
//  HappyMappy
//
//  Created by Aditya Narayan on 6/9/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    let prefs = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    
    var correctAnswers:Int {
        get { return prefs.integerForKey("correct") } //if doesn't exist, returns 0
        set (newValue) { prefs.setInteger(newValue, forKey: "correct") }
        //newValue optional, because it automatically assumes "newValue" as the default value
    }
    
    var incorrectAnswers:Int {
        get { return prefs.integerForKey("incorrect") }
        set (newValue) { prefs.setInteger(newValue, forKey: "incorrect") }
    }
    
    var currentQuestionIndex:Int {
        get { return prefs.integerForKey("currentQuestion") }
        set (newValue) { prefs.setInteger(newValue, forKey: "currentQuestion") }
    }
    
    var currentQuestion:MapQuestion {
        return questions[self.currentQuestionIndex]
    }
    
    var questions = [MapQuestion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        getCurrentQuestion()
        
        self.mapView.mapType = .Satellite
        self.mapView.zoomEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getCurrentQuestion() {
        
        self.correctAnswerLabel.text = "\(self.correctAnswers) correct | \(self.incorrectAnswers) incorrect"
        
        let region = MKCoordinateRegionMakeWithDistance(self.currentQuestion.location, self.currentQuestion.regionSizeInMeters, self.currentQuestion.regionSizeInMeters)
        self.mapView.setRegion(region, animated: false)
        
        let answers = [String](self.currentQuestion.answers.keys)
        
        self.answer1Button.setTitle(answers[0], forState: .Normal)
        self.answer2Button.setTitle(answers[1], forState: .Normal)
        self.answer3Button.setTitle(answers[2], forState: .Normal)
    }

    @IBAction func checkAnswer(sender: UIButton) {
        
        var title:String = ""
        var subTitle:String = ""
        
        if self.currentQuestion.answers[sender.titleLabel!.text!] == true {
            title = "Great work, dude!"
            subTitle = "You might be the smartest person ever"
            self.correctAnswers += 1
        } else {
            title = "You suck at everything!"
            subTitle = "I mean seriously..."
            self.incorrectAnswers += 1
        }
        
        let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title:"OK", style:.Default) { (action) in
            
            if self.currentQuestionIndex < self.questions.count - 1 {
                self.currentQuestionIndex += 1
            } else {
                self.currentQuestionIndex = 0
            }
            self.getCurrentQuestion()
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func loadData() {
        
        let kb = MapQuestion(location: CLLocationCoordinate2D(latitude: 67.074411, longitude:-158.945477), regionSizeInMeters: 1000)
        kb.addAnswer("Alaska", isCorrect: true)
        kb.addAnswer("Sahara Desert", isCorrect: false)
        kb.addAnswer("Arizona", isCorrect: false)
        self.questions.append(kb)
        
        let ba = MapQuestion(location: CLLocationCoordinate2D(latitude: 44.499527, longitude: 33.598420), regionSizeInMeters: 500)
        ba.addAnswer("Turkey", isCorrect: false)
        ba.addAnswer("Russia", isCorrect: true)
        ba.addAnswer("Italy", isCorrect: false)
        self.questions.append(ba)
        
        let ca = MapQuestion(location: CLLocationCoordinate2D(latitude: 32.675831, longitude:-117.157526), regionSizeInMeters: 500)
        ca.addAnswer("California", isCorrect: true)
        ca.addAnswer("Germany", isCorrect: false)
        ca.addAnswer("Italy", isCorrect: false)
        self.questions.append(ca)
        
        let ar = MapQuestion(location: CLLocationCoordinate2D(latitude: -33.867886, longitude:-63.984500), regionSizeInMeters: 1500)
        ar.addAnswer("Tennessee", isCorrect: false)
        ar.addAnswer("Argentina", isCorrect: true)
        ar.addAnswer("New Mexico", isCorrect: false)
        self.questions.append(ar)
        
        let ch = MapQuestion(location: CLLocationCoordinate2D(latitude: 40.452107, longitude: 93.742118), regionSizeInMeters: 2500)
        ch.addAnswer("Peru", isCorrect: false)
        ch.addAnswer("China", isCorrect: true)
        ch.addAnswer("Egypt", isCorrect: false)
        self.questions.append(ch)
        
        let nv = MapQuestion(location: CLLocationCoordinate2D(latitude: 37.563936, longitude: -116.851230), regionSizeInMeters: 500)
        nv.addAnswer("Nevada", isCorrect: true)
        nv.addAnswer("China", isCorrect: false)
        nv.addAnswer("Egypt", isCorrect: false)
        self.questions.append(nv)
        
        let sa = MapQuestion(location: CLLocationCoordinate2D(latitude: 16.864841, longitude:  11.953808), regionSizeInMeters: 500)
        sa.addAnswer("Sahara Desert", isCorrect: true)
        sa.addAnswer("Nevada", isCorrect: false)
        sa.addAnswer("Egypt", isCorrect: false)
        self.questions.append(sa)
        
        
        let bs = MapQuestion(location: CLLocationCoordinate2D(latitude: 26.357896, longitude: 127.783809), regionSizeInMeters: 200)
        bs.addAnswer("Japan", isCorrect: true)
        bs.addAnswer("New York", isCorrect: false)
        bs.addAnswer("Tibet", isCorrect: false)
        self.questions.append(bs)
    }
}

