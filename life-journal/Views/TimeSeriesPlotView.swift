//
//  TimeSeriesPlotView.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/17/23.
//

import SwiftUI
import Charts


struct TimeSeriesPlotView: View {
    @Binding var data: [Question]
    
    // This computed property merges the provided data with the last week's answers.
    var mergedData: [Question] {
        data.mergedWithLastWeek()
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Weekly Outlook")
                .font(.title)
            ForEach(mergedData) { question in
                VStack(spacing: 5) {
                    CardView2(question: question)
                }
            }
        }
        .padding()
    }
}


struct TimeSeriesPlotView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSeriesPlotView(data: .constant(Question.sampleData))
    }
}

