//
//  GeoCalcLabel.swift
//  GeoCalculatoriOS
//
//  Created by Dimitri Haering on 29.05.18.
//  Copyright © 2018 Dimitri Haring. All rights reserved.
//

import UIKit

class GeoCalcLabel: UILabel {

    override func awakeFromNib() {
        
        // set foreground color to FOREGROUND_COLOR
        self.tintColor = FOREGROUND_COLOR
        
        // set text to FOREGORUND_COLOR
        self.textColor = FOREGROUND_COLOR
    }
}
