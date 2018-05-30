//
//  GeoCalcTextField.swift
//  GeoCalculatoriOS
//
//  Created by Dimitri Haering on 29.05.18.
//  Copyright © 2018 Dimitri Haring. All rights reserved.
//

import UIKit

class GeoCalcTextField: DecimalMinusTextField {

    override func awakeFromNib() {
        
        // get decimalminustextfield settings
        super.awakeFromNib()
        
        // set foreground color to FOREGROUND_COLOR
        self.tintColor = FOREGROUND_COLOR
        
        // set background color to transparent
        self.backgroundColor = UIColor.clear
        
        // set placeholder text color to FOREGROUND_COLOR
        guard let ph = self.placeholder  else {
            return
        }
        self.attributedPlaceholder =
            NSAttributedString(string: ph, attributes: [NSAttributedStringKey.foregroundColor :
                FOREGROUND_COLOR])
        
        // set 1 point border with rounded corners with color FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        
        // set text to FOREGORUND_COLOR
        self.textColor = FOREGROUND_COLOR
    }


}
