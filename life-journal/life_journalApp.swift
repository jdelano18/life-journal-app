//
//  life_journalApp.swift
//  life-journal
//
//  Created by Jimmy DeLano on 9/17/23.
//

import SwiftUI

@main
struct life_journalApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
