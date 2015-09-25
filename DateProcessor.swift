//
//  DateProcessor.swift
//  owlympics
//
//  Created by Martin Zhou on 9/10/15.
//  Copyright (c) 2015 Martin Zhou. All rights reserved.
//

import Foundation

/*   Return an integer that indicates today's date. */
func getDay(date:NSDate) -> Int {
    
    let dayFormatter = NSDateFormatter()
    
//    Format of the return value. It has two digits
    dayFormatter.dateFormat = "dd"
    let dayString = dayFormatter.stringFromDate(date)
    let day = dayString.toInt()
    return day!
}

/*    Return a string that indicates which day of the week it is */
func getDayOfWeek(date:NSDate) -> String {
    
    let dayofweekFormatter = NSDateFormatter()
    
//    Format of the return value. It has three letters
    dayofweekFormatter.dateFormat = "EEE"
    let dayofweekString = dayofweekFormatter.stringFromDate(date)
    return dayofweekString
}

/*    Return a string that indicates which month of which year it is.
        The return style would be like "2015, 9"    */
func getMonthOfYear(date:NSDate) -> String {
    
    let monthofyearFormatter = NSDateFormatter()
    
    //    Format of the return value. It has three letters
    monthofyearFormatter.dateFormat = "YYYY, M"
    let monthofyearString = monthofyearFormatter.stringFromDate(date)
    return monthofyearString
}

/*    Return a string that indicates the exact time.
The return style would be like "2015-September-09, 7:00 am"    */
func getExactDay(date:NSDate) -> String {
    
    let exactDayFormatter = NSDateFormatter()
    
    //    Format of the return value. It has three letters
    exactDayFormatter.dateFormat = "YYYY-MMMM-dd, h:mm a"
    let exactDayString = exactDayFormatter.stringFromDate(date)
    return exactDayString
}

/*    Return a string that indicates the exact time.
The return style would be like "2015"    */
func getYear(date:NSDate) -> String {
    
    let yearFormatter = NSDateFormatter()
    
    //    Format of the return value. It has three letters
    yearFormatter.dateFormat = "YYYY"
    let yearString = yearFormatter.stringFromDate(date)
    return yearString
}

/* Calculate the days between two NSDate */
func calculateDaysBetween(date1:NSDate, date2:NSDate) -> Int {
    
    let cal = NSCalendar.currentCalendar()
    let unit:NSCalendarUnit = .CalendarUnitDay
    let components = cal.components(unit, fromDate: date1, toDate: date2, options: nil)
    let daysBetween = components.day
    return daysBetween
}

