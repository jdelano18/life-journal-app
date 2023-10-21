//
//  HistoryChart.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/20/23.
//

import SwiftUI

struct AnswerChartView: View {
    let answers: [Answer]
    let monthYearLabels: [String]
    
    var body: some View {
        HStack {
            // Month Labels
            // 20 is the height of the rectangle; 4 is roughly weeks in a month
            VStack(alignment: .leading, spacing: 20 * 4) {
                ForEach(monthYearLabels, id: \.self) { monthYear in
                    Text(monthYear)
                }
            }
            
            VStack(spacing: 5) {
                // Days of the Week Labels
                HStack {
                    ForEach(["M", "T", "W", "T", "F", "S", "S"], id: \.self) { day in
                        Text(day)
                            .frame(width: 20)
                    }
                }
                
                // Answers Data
                ForEach(0..<24) { weekIndex in
                    HStack {
                        ForEach(0..<7) { dayIndex in
                            let answer = getAnswer(for: weekIndex * 7 + dayIndex)
                            Rectangle()
                                .fill(answer.color)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func getAnswer(for index: Int) -> Answer {
        if index < answers.count {
            return answers[answers.count - 1 - index]
        }
        // Return a default answer for missing data
        return Answer(date: Date(), response: -1)
    }
}

// Helper method to generate last 6 month names with year
func getLastSixMonthYearLabels() -> [String] {
    let calendar = Calendar.current
    var currentDate = Date()
    var monthYearLabels: [String] = []
    let dateFormatter = DateFormatter()
    
    for _ in 0..<6 {
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate) % 100 // To get the last two digits of the year
        if let monthName = dateFormatter.shortMonthSymbols?[month - 1] {
            monthYearLabels.insert("\(monthName) '\(String(format: "%02d", year))", at: 0)
        }
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = newDate
        }
    }
    return monthYearLabels.reversed()
}


struct ContentView: View {
    // Generate some sample data
    var sampleAnswers: [Answer] = {
        var answers: [Answer] = []
        let calendar = Calendar.current
        for day in 0..<180 { // Last 6 months
            if let date = calendar.date(byAdding: .day, value: -day, to: Date()) {
                answers.append(Answer(date: date, response: [1, 0, -1].randomElement()!))
            }
        }
        return answers
    }()
    
    var body: some View {
        AnswerChartView(answers: sampleAnswers, monthYearLabels: getLastSixMonthYearLabels())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
