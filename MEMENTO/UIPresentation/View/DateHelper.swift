//
// DateHepler.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/10.
//
import UIKit

struct DateStringFormatter {
    let date: Date
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    func getByDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    func getByMinute() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    func getContentTimeComment() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH시 mm분의 기록"
        
        return dateFormatter.string(from: date)
    }
}
