//
//  String.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation

extension String {
    func dateWith(format: String) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.date(from: self)
    }
}
