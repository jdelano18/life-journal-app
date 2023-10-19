//
//  Question.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/17/23.
//


import Foundation
import SwiftUI

struct Answer: Identifiable, Codable {
    let id: UUID
    let date: Date
    let response: Int   // 1: yes, 0: no, -1: missing
    
    var color: Color {
        switch response {
        case 1:
            return Color.green
        case 0:
            return Color.red
        default:
            return Color.gray
        }
    }
    
    var dayOfWeekShort: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // This will give full form e.g., "Monday"
        if let firstChar = formatter.string(from: date).first {
            return String(firstChar) // Just the first character, e.g., "M"
        }
        return ""
    }

    
    init(id: UUID = UUID(), date: Date, response: Int) {
        self.id = id
        self.date = date
        self.response = response
    }
}

struct Question: Identifiable, Codable {
    let id: UUID
    let title: String
    var answers: [Answer]
    
    init(id: UUID = UUID(), title: String, answers: [Answer] = []) {
        self.id = id
        self.title = title
        self.answers = answers
    }
}


extension Question {
    static let sampleData: [Question] = [
        Question(title: "If today was your last day, would you want to do what you are going to do today?",
                 answers: [
                    Answer(date: Date(), response: 1),
                    Answer(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, response: 1),
                    Answer(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, response: 0)
                 ]),
        Question(title: "Did you snooze your alarm?",
                 answers: [
                    Answer(date: Date(), response: 0),
                    Answer(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, response: 0),
                    Answer(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, response: 0)
                 ])
    ]
}


extension Date {
    static func lastWeekDates() -> [Date] {
        var dates: [Date] = []
        let today = Date()
        let calendar = Calendar.current
        
        for dayIndex in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -dayIndex, to: today) {
                dates.append(date)
            }
        }
        return dates.reversed()
    }
}

extension Array where Element == Question {
    func mergedWithLastWeek() -> [Question] {
        let lastWeek = Date.lastWeekDates()
        var mergedQuestions: [Question] = []
        
        for question in self {
            var newAnswers: [Answer] = []
            for date in lastWeek {
                if let answerForDate = question.answers.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                    newAnswers.append(answerForDate)
                } else {
                    newAnswers.append(Answer(date: date, response: -1)) // Gray value
                }
            }
            let newQuestion = Question(id: question.id, title: question.title, answers: newAnswers)
            mergedQuestions.append(newQuestion)
        }
        return mergedQuestions
    }
}

