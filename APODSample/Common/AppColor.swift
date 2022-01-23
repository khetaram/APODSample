//
//  AppColor.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation
import UIKit

struct AppColor {

    static let bannerBackground = UIColor(red: 0.25, green: 0.70, blue: 0.64, alpha: 1.00)
    static let lightText = AppColor.getColor(lightColor: .gray, darkColor: .white)

    static let infoBackground = UIColor(red: 0.25, green: 0.70, blue: 0.64, alpha: 1.00)
    static let errorBackground = UIColor.red

    static func getColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightColor : darkColor
        }
    }
}
