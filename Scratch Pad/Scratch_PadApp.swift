//
//  Scratch_PadApp.swift
//  Scratch Pad
//
//  Created by Harshit Agarwal on 28/12/23.
//

import SwiftUI

@main
struct Scratch_PadApp: App {
    var body: some Scene {
        WindowGroup {
            PadListView()
//                .modelContainer(for: Pad.self)
                .modelContainer(for: Draw.self)
        }
    }
}
