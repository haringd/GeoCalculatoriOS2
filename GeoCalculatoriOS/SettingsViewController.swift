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
    
    @IBOutlet weak var calculateButtonoutlet: UIButton!
    
    var distanceUnits: String = ""
    var bearingUnits: String = ""
    
    var pickerData: [String] = [String]()
    var selection : String = ""
    var delegate : SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let d = self.delegate {
            d.settingsChanged(distanceUnits: "test1", bearingUnits: "test2")
        }
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
    }
}
