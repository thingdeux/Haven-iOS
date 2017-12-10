//
//  UIColor+Extensions.swift
//  Haven
//
//  Created by Josh on 12/7/17.
//  Copyright © 2017 Josh Land. All rights reserved.
//

import UIKit

extension UIColor {
    // Safe to force unwrap all of these - they're color literals
    // Defined in Assets
    static var LightGray = UIColor(named: "LightGray")!
    static var TextLightGray = UIColor(named: "TextLightGray")!
    static var BabyBlue = UIColor(named: "BabyBlue")!
}

/*
    Reference - Colors from Android Build
 <color name="light_blue_50">#E1F5FE</color>
 <color name="light_blue_100">#B3E5FC</color>
 <color name="light_blue_200">#81D4FA</color>
 <color name="light_blue_300">#4FC3F7</color>
 <color name="light_blue_400">#29B6F6</color>
 <color name="light_blue_500">#03A9F4</color>
 <color name="light_blue_600">#039BE5</color>
 <color name="light_blue_700">#0288D1</color>
 <color name="light_blue_800">#0277BD</color>
 <color name="light_blue_900">#01579B</color>
 <color name="light_blue_A100">#80D8FF</color>
 <color name="light_blue_A200">#40C4FF</color>
 <color name="light_blue_A400">#00B0FF</color>
 <color name="light_blue_A700">#0091EA</color>
 
 <color name="app_accent">#69F0AE</color>
 
 <!-- Colors for the app -->
 <color name="primary">@color/light_blue_500</color>
 <color name="primary_dark">@color/light_blue_700</color>
 <color name="accent">@color/app_accent</color>
 <color name="colorPrimary">@color/light_blue_500</color>
 <color name="colorPrimaryDark">@color/light_blue_700</color>
 <color name="colorAccent">@color/app_accent</color>

 
 
 */
