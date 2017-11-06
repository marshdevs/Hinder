/*
 This file is to declare constants, such as font sizes, 
 custom colors, UIFonts, etc, that we want to be consistent
 across the app
 
 Add functions as needed
 
 */

import Foundation
import UIKit

func hinderBlue() -> UIColor {
    return  UIColor(red: 153/255, green: 206/255, blue: 230/255, alpha: 1.0)
}

let CommonInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)

func TitleFont(size: CGFloat = 18) -> UIFont {
    //return UIFont(name: "OCRAStd", size: size)!
    return UIFont(name:"Arial-BoldMT", size: 28.0)!
}

