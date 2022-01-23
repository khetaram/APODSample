//
//  Date.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import UIKit

extension Date {
    func stringWith(format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
}
