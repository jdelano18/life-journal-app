//
//  QuestionEditView.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/19/23.
//

import SwiftUI


struct QuestionEditView: View {
    @Binding var question: Question
    @State private var selectedTime: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Ask yourself")){
                TextField("Question", text: $question.title, axis: .vertical)
                    .padding()
            }
            Section(header: Text("About this question")){
                Toggle("'Yes' is a positive answer", isOn: $question.yesIsPositive)
            }
            Section(header: Text("When to answer")) {
                DatePicker("Select a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .onAppear {
                        // If the notificationTime is nil, keep the default (current time)
                        if let notificationTime = question.notificationTime {
                            self.selectedTime = notificationTime
                        }
                    }
                // When the user picks a new time, update the question's notificationTime
                    .onChange(of: selectedTime) {
                        question.notificationTime = selectedTime
                    }
            }
        }
    }
}

struct QuestionEditView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionEditView(question: .constant(Question.sampleData[0]))
    }
}
