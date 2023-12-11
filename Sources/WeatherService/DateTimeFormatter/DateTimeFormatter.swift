//
//  DateTimeFormatter.swift
//
//
//  Created by Jayesh Kawli on 12/9/23.
//

import Foundation

/// An utility to format date and time
final class DateTimeFormatter {

    static let weatherAPIDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    static let weatherAPIDateTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        return dateFormatter
    }()
}
