//
//  DateTimeFormatterTests.swift
//  
//
//  Created by Jayesh Kawli on 12/11/23.
//

import XCTest
@testable import WeatherService

final class DateTimeFormatterTests: XCTestCase {

    private var sampleDate: Date!

    override func setUp() {
        super.setUp()
        sampleDate = createCustomDate(from: 2008, month: 12, day: 11, hours: 09, minutes: 23, seconds: 40)
    }

    func testThatDateFormatterCorrectlyFormatsTheInputDate() {
        XCTAssertEqual(DateTimeFormatter.weatherAPIDateFormatter.string(from: sampleDate), "2008-12-11", "Actual date and the date expected from date formatter do not match")
    }

    func testThatDateTimeFormatterCorrectlyFormatsTheInputDate() {
        XCTAssertEqual(DateTimeFormatter.weatherAPIDateTimeFormatter.string(from: sampleDate), "2008-12-11 09:23", "Actual date time and the date time expected from date time formatter do not match")
    }

    private func createCustomDate(from year: Int, month: Int, day: Int, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = seconds
        guard let date = Calendar(identifier: .gregorian).date(from: dateComponents) else {
            XCTFail("Failed to create expected date from given input. Expected valid date")
            return nil
        }
        return date
    }

}
