//
//  HistoryChart.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/20/23.
//

import Charts
import SwiftUI
    
struct HistoryChart: View {
    @Binding var question: Question
//    @State private var editingQuestion = DailyScrum.emptyScrum
//    @State private var isPresentingEditView = false
    
    
    var body: some View {
        Chart {
            ForEach(question.answers) { answer in
                RectangleMark(x: .value(answer.dayOfWeekShort, answer.response),
                              y: .value("Oct '23", answer.date))
            }
        }
    }
}
    
struct HistoryChart_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HistoryChart(question: .constant(Question.sampleData[0]))
        }
    }
}
