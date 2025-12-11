//
//  TamakanApp.swift
//  Tamakan
//
//  Created by shahad khaled on 27/05/1447 AH.
//

import SwiftUI
import SwiftData


@main
struct TamakanApp: App {
    @StateObject private var recViewModel = RecViewModel()
    var body: some Scene {
        WindowGroup {
            
                        GetStarted()
                            .environmentObject(RecViewModel())
//            recView()
//                .environmentObject(recViewModel)
        }.modelContainer(for: RecordingModel.self)
//        WindowGroup {
//            //GetStarted()
//            GetStarted()
//                .environmentObject(RecViewModel())
//                //.environmentObject(recViewModel)
//        }.modelContainer(for: RecordingModel.self)
    }
}
