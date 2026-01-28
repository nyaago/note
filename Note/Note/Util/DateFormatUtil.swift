//
//  DateFormatUtil.swift
//  Note
//
//  Created by nyaago on 2026/01/20.
//

import Foundation

class DateFormatUtil {
    
    static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }

    static func formatYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func formatRelativeDate(date: Date) -> String {
        let now = Date()
        let elapsedDays = Calendar.current.dateComponents([.day], from: date, to: now).day!
        if elapsedDays == 0 {
            return "today"
        }
        if elapsedDays <= 6 {
            return "recently"
        }
        if elapsedDays <= 7 {
            return "this past week"
        }
        if elapsedDays <= 31 {
            return "this past month"
        }
        else {
            var formatStyle = Date.RelativeFormatStyle()
            formatStyle.presentation = .named
            formatStyle.unitsStyle = .spellOut
            return formatStyle.format(date)
        }
    }
}
