////////
////////  records.swift
////////  تمكّن
////////
////////  Created by noura on 01/12/2025.
////////
//import SwiftUI
//import SwiftData
//
////
////  records.swift
////  تمكّن
////
////  Created by noura on 01/12/2025.
////
////
////  Untitled.swift
////  تمكّن
////
////  Created by noura on 01/12/2025.
////
//
import SwiftUI
import SwiftData

//
//  records.swift
//  تمكّن
//
//  Created by noura on 01/12/2025.
//

import SwiftUI
import SwiftData

//
struct records: View {
    @State private var searchText = ""
    @State private var expandedID: UUID? = nil
//    @Query private var record :[RecordingModel]
    @Query(
        sort: \RecordingModel.date,
        order: .reverse
    ) var record: [RecordingModel]

    private func progressBinding(for recID: UUID) -> Binding<Double> {
        Binding<Double>(
            get: {
                audioVM.currentRecordingID == recID
                ? audioVM.playbackProgress
                : 0
            },
            set: { newValue in
                guard audioVM.currentRecordingID == recID else { return }
                audioVM.playbackProgress = newValue
                audioVM.seek(to: newValue)
            }
        )
    }

    // Remove duplicate/unused progress properties
    // @State var progress: Double = 0.2
    // let progress: Double

    @StateObject private var audioVM = AudioRecordingViewModel()
    @Environment(\.layoutDirection) var layoutDirection
    @Environment(\.modelContext) private var modelContext
    let bottomBarHeight: CGFloat = 200

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image("Image1")
                            .frame(width: 100, height: 50)
                            .opacity(0.9)
                            .padding(.leading, 10)
                            .padding(.top, 0)
                        Spacer()
                    }
                    Spacer()
                }//v
                
                VStack(alignment: layoutDirection == .rightToLeft ? .trailing : .leading, spacing: 20) {
                            Spacer()

                            Text("Records")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity,
                                       alignment: layoutDirection == .rightToLeft ? .trailing : .leading)
                                .padding(.horizontal, 25)

                            TextField("search...", text: $searchText)
                                .padding(12)
                                .foregroundColor(.primary)
                                .background(.primary.opacity(0.08))
                                .cornerRadius(14)
                                .multilineTextAlignment(layoutDirection == .rightToLeft ? .trailing : .leading)
                                .padding(.horizontal, 20)
                    
                    ScrollView {
                        VStack(spacing: 18) {
//hereeeeeeeeeeeeeee
                            
                            
                            ForEach(record) { rec in
//                                RecordingCardView(
//                                    id: rec.id,
//                                    title: rec.recordname,
//                                    date: rec.date,
//                                    duration: rec.duration,
//                                    progress: (audioVM.currentRecordingID == rec.id ? audioVM.playbackProgress : 0),
//                                    fileURL: rec.audiofile,
//                                    isExpanded: expandedID == rec.id,
//                                    onTap: {
//                                        withAnimation {
//                                            expandedID = (expandedID == rec.id ? nil : rec.id)
//                                        }
//                                    },
//                                    
//                                    onPlay: { url in
//                                        audioVM.playRecording(from: url, recordingID: rec.id)
//                                    },
//                                    onPause: {
//                                        audioVM.pauseRecording()
//                                    },
//                                    recordingModel: rec
//                                    ,
//                                    onDelete:{ recordingModel in
//                                        withAnimation(.easeInOut(duration: 0.3)) {
//                                            // Collapse the card if it's expanded
//                                            if expandedID == recordingModel.id {
//                                                expandedID = nil
//                                            }
//                                            // Delete the recording
//                                            audioVM.deletRecording(recordObject: recordingModel)
//                                        }
//                                    }, onRename: { newName in
//                                        audioVM.renameRecording(rec, to: newName)
//                                    }
//                                    //summary: {}
//                                
//                                
//                                )
                                
                                RecordingCardView(
                                    id: rec.id,
                                    title: rec.recordname,
                                    date: rec.date,
                                    duration: rec.duration,

//                                    progress: Binding(
//                                        get: {
//                                            audioVM.currentRecordingID == rec.id
//                                            ? audioVM.playbackProgress
//                                            : 0
//                                        },
//                                        set: { newValue in
//                                            guard audioVM.currentRecordingID == rec.id else { return }
//                                            audioVM.playbackProgress = newValue
//                                            audioVM.seek(to: newValue)
//                                        }
//                                    )
                                    
                                    progress: progressBinding(for: rec.id), isActive: true,
                                    

                                    fileURL: rec.audiofile,
                                    isExpanded: expandedID == rec.id,

                                    onTap: {
                                        withAnimation {
                                            expandedID = (expandedID == rec.id ? nil : rec.id)
                                        }
                                    },

                                    onPlay: { url in
                                        audioVM.playRecording(from: url, recordingID: rec.id)
                                    },

                                    onPause: {
                                        audioVM.pauseRecording()
                                    },

                                    onSeekStart: {
                                        audioVM.isUserSeeking = true
                                    },

                                    onSeekEnd: {
                                        audioVM.isUserSeeking = false
                                    },

                                    onForward: {
                                        guard audioVM.currentRecordingID == rec.id else { return }
                                        audioVM.forward()
                                    },

                                    onBackward: {
                                        guard audioVM.currentRecordingID == rec.id else { return }
                                        audioVM.backward()
                                    },

                                    recordingModel: rec,

                                    onDelete: { recordingModel in
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            if expandedID == recordingModel.id {
                                                expandedID = nil
                                            }
                                            audioVM.deletRecording(recordObject: recordingModel)
                                        }
                                    },

                                    onRename: { newName in
                                        audioVM.renameRecording(rec, to: newName)
                                    }
                                )

                                .transition(.move(edge: .trailing).combined(with: .opacity))
                            }
                            .animation(.easeInOut(duration: 0.3), value: record.count)
                            
                            }
                .padding(.bottom, bottomBarHeight) // 👈 WALL
                .padding(.horizontal, 16)
//                .padding(.bottom, 40)
            }
                    .clipped()
        }
        
        VStack {
            Spacer()
            
            ZStack {
                Image("Image2")
                    .frame(height: 180)
                    .opacity(0.9)
                    .cornerRadius(20)
                    .padding(.bottom, -20)
                
                Image("Image3")
                    .frame(height: 180)
                    .opacity(0.9)
                    .cornerRadius(20)
                    .padding(.bottom, -15)
                
                NavigationLink(destination: recView()) {
                    Image("mic11")
                        .frame(width: 80, height: 80)
                        .padding(.bottom, -50)
                        .padding(.trailing,-5)
                }
            }
            .padding(.bottom, -30)
        }
        
    }
    .ignoresSafeArea(.keyboard)
    .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
    .onAppear {
        audioVM.context = modelContext
    }
        }
        
        .navigationBarBackButtonHidden(true)
        //nav
}//view

}//struct


struct SecondView: View {
    var body: some View {
        Text("هذه الصفحة الثانية")
            .font(.largeTitle)
            .foregroundColor(.black)
    }
}

#Preview {
    records()
}
