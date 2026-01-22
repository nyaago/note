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
    
    static func formatRelativeDate(date: Date) -> String {
        var formatStyle = Date.RelativeFormatStyle()
        let now = Date()
        let elapsedDays = Calendar.current.dateComponents([.day], from: date, to: now).day!
        if elapsedDays > 2 {
            formatStyle.presentation = .numeric
        }
        else {
            formatStyle.presentation = .named
        }
        formatStyle.unitsStyle = .spellOut
        return formatStyle.format(date)
    }
}
