//
//  String+Date.swift
//  MBL (iOS)
//
//  Created by Adrien PEREA on 14/01/2022.
//

import Foundation

extension String {
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self)!
    }
}
