//
//  GeoCalcButton.swift
//  GeoCalculatoriOS
//
//  Created by Dimitri Haering on 29.05.18.
//  Copyright © 2018 Dimitri Haring. All rights reserved.
//

import UIKit

class GeoCalcButton: UIButton {


    override func awakeFromNib() {
        
        // set background color to FOREGROUND_COLOR
        self.backgroundColor = FOREGROUND_COLOR
        
        // set foreground color to BACKGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        
        // rounded corners
        self.layer.cornerRadius = 5.0
    }

}
