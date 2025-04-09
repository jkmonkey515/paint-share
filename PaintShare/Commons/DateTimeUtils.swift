//
//  DateTimeUtils.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import Foundation

class DateTimeUtils {
    
    public static func timestampToStrHourMinute(timestamp: UInt64) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp)/1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "JST") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    public static func timestampToStr(timestamp: UInt64) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp)/1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "JST") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    public static func timestampToStrFormat(timestamp: UInt64) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp)/1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "JST") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy年MM月dd日" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    public static func dateToStr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "JST") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy/MM/dd" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    public static func dateStrFormat(dateStr: String) -> String {
        // String to Date
        if dateStr.count == 0 {
            return dateStr
        }
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "JST") //Set timezone that you want
        formatter.locale = NSLocale.current
        formatter.dateFormat = "yyyy/MM/dd" //Specify your format that you want
        let newDaate: Date = formatter.date(from: dateStr)!
        // Date to String
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "JST")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        let strDate = dateFormatter.string(from: newDaate)
        return strDate
    }
    
}
