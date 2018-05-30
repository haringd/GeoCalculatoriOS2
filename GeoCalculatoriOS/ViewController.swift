//
//  ViewController.swift
//  GeoCalculatoriOS
//
//  Created by Dimitri Haering on 29.05.18.
//  Copyright © 2018 Dimitri Haring. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, SettingsViewControllerDelegate {

    
    @IBOutlet weak var latitudeP1TextField: UITextField!
    @IBOutlet weak var longtitudeP1TextField: UITextField!
    @IBOutlet weak var latitudeP2TextField: UITextField!
    @IBOutlet weak var longtitudeP2TextField: UITextField!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var distanceUnits: String = "Kilometers"
    var bearingUnits: String = "Degrees"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set background color to BACKGORUND_COLOR
        self.view.backgroundColor = BACKGROUND_COLOR
        
        // dismiss keyboard when tapping outside oftext fields
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navVC = segue.destination as? UINavigationController {
            if let settingsVC = navVC.viewControllers.first as? SettingsViewController {
                settingsVC.delegate = self
                settingsVC.distanceUnits = self.distanceUnits
                settingsVC.bearingUnits = self.bearingUnits
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/// Dismisses the Keyboard
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // protocol from settings view
    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        self.distanceUnits = distanceUnits
        self.bearingUnits = bearingUnits
       calculateButton.sendActions(for: .touchUpInside)
        
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        print("calculate Button")
        calculateDistanceBearing()
    }
    
    func calculateDistanceBearing () {
            
           // dismiss keyboard when button pressed
        self.dismissKeyboard()
        
        // used to check for valid points
        var pointsOk: Bool = false
        
        // if optionals not nil
        if let p1Lat = self.latitudeP1TextField.text, let p1Long = self.longtitudeP1TextField.text, let p2Lat = self.latitudeP2TextField.text, let p2Long = self.longtitudeP2TextField.text {
            
            // if text fields not empty strings
            if p1Lat != "", p1Long != "", p2Lat != "", p2Long != "" {
                
                // all points valid
                pointsOk = true
            }
        }
        
        // if all points valid
        if pointsOk {
            
            // create CLLocation (points) from latitudes and longitudes
            let p1: CLLocation = CLLocation(latitude: Double(self.latitudeP1TextField.text!)!, longitude: Double(self.longtitudeP1TextField.text!)!)
            let p2: CLLocation = CLLocation(latitude: Double(self.latitudeP2TextField.text!)!, longitude: Double(self.longtitudeP2TextField.text!)!)
            
            // calculate distance between p1 and p2 in km. round to 2 decimal places
            var distance: Double = p1.distance(from: p2) / 1000
            distance = (distance * 100).rounded() / 100
            
            // convert distance to miles if distance units is miles
            if distanceUnits == "Miles" {
                distance = (distance * 0.621371 * 100).rounded() / 100
            }
            
            // set distance label
            self.distanceLabel.text = "Distance: \(distance) " + distanceUnits
            
            // calculate and set bearing between p1 and p2 in decimal degrees
            var bearing: Double = p1.bearingToPoint(point: p2)
            bearing = (bearing * 100).rounded() / 100
            
            // convert degrees to mils if bearing units is mils
            if bearingUnits == "Mils" {
                bearing = (bearing * 17.777777777778 * 100).rounded() / 100
            }
            
            // set bearing label
            self.bearingLabel.text = "Bearing: \(bearing) " + bearingUnits
            
        } else {
            self.distanceLabel.text = "Distance:"
            self.bearingLabel.text = "Bearing:"
        }
        
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        // dismiss keyboard when button pressed
        self.dismissKeyboard()
        
        latitudeP1TextField.text = ""
        latitudeP2TextField.text = ""
        longtitudeP1TextField.text = ""
        longtitudeP2TextField.text = ""
        
        distanceLabel.text = "Distance:"
        bearingLabel.text = "Bearing:"
    }
    
    @IBAction func settingsButton(_ sender: UIButton) {
    }
}

