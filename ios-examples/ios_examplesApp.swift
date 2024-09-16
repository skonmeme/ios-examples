//
//  ios_examplesApp.swift
//  ios-examples
//
//  Created by Sung Gon Yi on 9/5/24.
//

import SwiftUI

@main
struct ios_examplesApp: App {
@State private var applicationData = ApplicationData()
//@State private var tableData = TableData()

    var body: some Scene {
        WindowGroup {
            //ContentView()
            //    .environment(applicationData)
            //TableView()
            //    .environment(TableData())
            //ContentTabView()
            //    .environment(applicationData)
            ConcurrentCotentView()
        }
    }
}
