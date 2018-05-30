//
//  SettingsViewController.swift
//  GeoCalculatoriOS
//
//  Created by Dimitri Haering on 29.05.18.
//  Copyright © 2018 Dimitri Haring. All rights reserved.
//

import UIKit

// used to handover data from SettingsViewController to ViewController
protocol SettingsViewControllerDelegate {
     func settingsChanged(distanceUnits: String, bearingUnits: String)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var picksUnit: UIPickerView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
    var distanceUnits: String = "test1"
    var bearingUnits: String = "test2"
    
    var pickerData: [String] = [String]()
    var selection : String = "hello"
    var delegate : SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // open uipickerview for distance when distance label clicked
        let detectDistanceTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.showDistanceUnitsPickerView))
        self.distanceLabel.addGestureRecognizer(detectDistanceTouch)
        
        // open uipickerview for bearing when bearing label clicked
        let detectBearingTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.showBearingUnitsPickerView))
        self.bearingLabel.addGestureRecognizer(detectBearingTouch)
        
        self.picksUnit.delegate = self
        self.picksUnit.dataSource = self
        
        // dismiss pickerview when tapping outside of picker
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissPickerView))
        self.view.addGestureRecognizer(detectTouch)
        
        self.distanceLabel.text = self.distanceUnits
        self.bearingLabel.text = self.bearingUnits
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showDistanceUnitsPickerView() {
        print("distance picker view") //debug only
        // show picker and load distance data
        self.picksUnit.isHidden = false
        self.pickerData = ["Kilometers", "Miles"]
        
        // reload picker with bearing components
        self.picksUnit.reloadAllComponents()
        
        // start picker view with current distance selection
        self.selection = self.distanceLabel.text!
        
        //print(self.selection + self.distanceUnitsLabel.text!)
        if let row: Int = self.pickerData.index(of: self.selection) {
            self.picksUnit.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    @objc func showBearingUnitsPickerView() {
        
        // show picker and load bearing data
        self.picksUnit.isHidden = false
        self.pickerData = ["Degrees", "Mils"]
        
        // reload picker with bearing components
        self.picksUnit.reloadAllComponents()
        
        // start picker with curretn bearing selection
        self.selection = self.bearingLabel.text!
        if let row: Int = self.pickerData.index(of: self.selection) {
            self.picksUnit.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    @objc func dismissPickerView() {
        self.picksUnit.isHidden = true
        
        /*        // set distance units label if picker was selecting distance units
         if self.selection == "Kilometers" || selection == "Miles" {
         self.distanceUnitsLabel.text = selection
         }
         
         // else set bearing units label
         if selection == "Degrees" || selection == "Mils" {
         self.bearingUnitsLabel.text = selection
         }
         */
        
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let d = self.delegate {
            d.settingsChanged(distanceUnits: distanceLabel.text!, bearingUnits: bearingLabel.text!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}


extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selection = self.pickerData[row]
        
        // set distance units label if picker was selecting distance units
        if self.selection == "Kilometers" || selection == "Miles" {
            self.distanceLabel.text = selection
        }
        
        // else set bearing units label
        if selection == "Degrees" || selection == "Mils" {
            self.bearingLabel.text = selection
        }
    }
}
