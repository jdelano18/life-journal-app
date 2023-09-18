//
//  life_journalApp.swift
//  life-journal
//
//  Created by Jimmy DeLano on 9/17/23.
//

import SwiftUI

@main
struct life_journalApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
