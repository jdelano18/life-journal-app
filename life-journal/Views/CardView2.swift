//
//  CardView2.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/18/23.
//

import Foundation
import SwiftUI

struct CardView2: View {
    let question: Question
    
    var weeklyData: [Question] {
        [question].mergedWithLastWeek()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.title)
                .font(.headline)
            Spacer()
            HStack {
                ForEach(weeklyData[0].answers) { answer in
                    VStack {
                        Rectangle()
                            .fill(answer.color)
                            .frame(width: 30, height: 30)
                        Text(answer.dayOfWeekShort)
                            .font(.caption)
                    }
                Spacer()
                }
                if (question.streak > 0) {
                    Text("\(question.streak) 🔥")
                        .labelStyle(.trailingIcon)
                }
            }
            .font(.caption)
        }
        .padding()
    }
}

struct CardView2_Previews: PreviewProvider {
    static var question = Question.sampleData[0]
    static var previews: some View {
        CardView2(question: question)
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
