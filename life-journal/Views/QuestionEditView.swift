//
//  QuestionEditView.swift
//  life-journal
//
//  Created by Jimmy DeLano on 10/19/23.
//

import SwiftUI


struct QuestionEditView: View {
    @Binding var question: Question
//    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Ask yourself")){
                TextField("Question", text: $question.title, axis: .vertical)
                    .padding()
            }
            Section(header: Text("About this question")){
                Text("y/n **todo")
            }
            // add in notif time
        }
    }
}

struct QuestionEditView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionEditView(question: .constant(Question.sampleData[0]))
    }
}
