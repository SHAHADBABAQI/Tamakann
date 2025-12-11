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
    @Query private var record :[RecordingModel]
    @State var progress: Double = 0.2
    @StateObject private var audioVM = AudioRecordingViewModel()
    @Environment(\.layoutDirection) var layoutDirection
    @Environment(\.modelContext) private var modelContext
    


    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image("Image1")
                            .frame(width: 180, height: 180)
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
                                RecordingCardView(
                                    id: rec.id,
                                    title: rec.recordname,
                                    date: rec.date,
                                    duration: rec.duration,
                                    progress: $progress,
                                    fileURL: rec.audiofile,
                                    isExpanded: expandedID == rec.id,
                                    onTap: {
                                        withAnimation {
                                            expandedID = (expandedID == rec.id ? nil : rec.id)
                                        }
                                    },
                                    
                                    onPlay: { url in
                                        audioVM.playRecording(from: url)
                                    },
                                    onPause: {
                                        audioVM.pauseRecording()
                                    },
                                    recordingModel: rec
                                    ,
                                    onDelete:{ recordingModel in
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            // Collapse the card if it's expanded
                                            if expandedID == recordingModel.id {
                                                expandedID = nil
                                            }
                                            // Delete the recording
                                            audioVM.deletRecording(recordObject: recordingModel)
                                        }
                                    }
                                )
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                            }
                            .animation(.easeInOut(duration: 0.3), value: record.count)
                            
                            }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
            }
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
    .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
    .onAppear {
        audioVM.context = modelContext
    }
        }//nav
}//view

}//struct


struct SecondView: View {
    var body: some View {
        Text("هذه الصفحة الثانية")
            .font(.largeTitle)
            .foregroundColor(.black)
    }
}
//



    
    
//
//func RecordingCardView(
//
//
//    id: UUID,
//    title: String,
//    date: Date,
//    duration: Double,
//    isExpanded: Bool,
//    prograss: Binding<Double>,
//    onTap: @escaping () -> Void
//) -> some View {
//
//
//
//    return VStack(alignment: .trailing, spacing: 12) {
//
//        HStack {
//            Text("\(duration)")
//                .foregroundColor(.primary.opacity(0.8))
//
//            Spacer()
//
//            VStack(alignment: .trailing, spacing: 4) {
//                Text(title)
//                    .foregroundColor(.primary)
//                    .font(.title3)
//                    .bold()
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//
//                Text("\(date)")
//                    .foregroundColor(.primary.opacity(0.6))
//                    .font(.caption)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//            }
//        }
//        .contentShape(Rectangle())
//        .onTapGesture { onTap() }
//
//        if isExpanded {
//            VStack(spacing: 12) {
//
//                Slider(value: prograss)
//                    .tint(.primary)
//                    .padding(.horizontal, 4)
//
//                HStack {
//                    Text("-1:10")
//                    Spacer()
//                    Text("0:00")
//                }
//                .font(.caption2)
//                .foregroundColor(.white.opacity(0.6))
//
//                HStack(spacing: 28) {
//                    Image(systemName: "text.bubble")
//                    Image(systemName: "gobackward.15")
//                    Image(systemName: "play.circle.fill")
//                        .font(.system(size: 42))
//                    Image(systemName: "goforward.15")
//                    Image(systemName: "trash")
//                }
//                .foregroundColor(.primary)
//                .padding(.top, 4)
//
//            }
//            .transition(.move(edge: .bottom).combined(with: .opacity))
//        }
//
//    }
//    .padding()
//    .frame(maxWidth: .infinity)
//    .frame(minHeight: isExpanded ? 200 : 80)
//    .background(
//        RoundedRectangle(cornerRadius: 25)
//            .fill(.primary.opacity(0.10))
//    )
//    .animation(.easeInOut, value: isExpanded)
//}
//struct RecordingCard: View {
//    let id: Int
//    var title: String
//    var date: String
//    var duration: String
//    var isExpanded: Bool
//    var onTap: () -> Void
//
//    @State private var progress: Double = 0.2
//
//    var body: some View {
//        VStack(alignment: .trailing, spacing: 12) {
//
//
//            HStack {
//                Text(duration)
//                       .foregroundColor(.primary.opacity(0.8))
//
//                   Spacer() // يفصل بين المدة والعنوان
//
//                VStack(alignment: .trailing, spacing: 4) {
//                    Text(title)
//                        .foregroundColor(.primary)
//                        .font(.title3)
//                        .bold()
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//
//                    Text(date)
//                        .foregroundColor(.primary.opacity(0.6))
//                        .font(.caption)
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//
//                }
//
//            }
//            .contentShape(Rectangle())
//            .onTapGesture { onTap() }
//
//            if isExpanded {
//                VStack(spacing: 12) {
//                    Slider(value: $progress)
//                        .tint(.primary)
//                        .padding(.horizontal, 4)
//
//                    HStack {
//                        Text("-1:10")
//                        Spacer()
//                        Text("0:00")
//                    }
//                    .font(.caption2)
//                    .foregroundColor(.white.opacity(0.6))
//
//
//
//                    HStack(spacing: 28) {
//                        Image(systemName: "text.bubble")
//                        Image(systemName: "gobackward.15")
//                        Image(systemName: "play.circle.fill")
//                            .font(.system(size: 42))
//                        Image(systemName: "goforward.15")
//                        Image(systemName: "trash")
//                    }
//                    .foregroundColor(.primary)
//                    .padding(.top, 4)
//                }
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity)
//        .frame(minHeight: isExpanded ? 200 : 80)
//        .background(
//            RoundedRectangle(cornerRadius: 25)
//                .fill(.primary.opacity(0.10))
//
//        )
//        .animation(.easeInOut, value: isExpanded)
//    }
//}

#Preview {
    records()
}

//import SwiftUI
//import SwiftData
//
////
//struct records: View {
//    @State private var searchText = ""
//    @State private var expandedID: UUID? = nil
//    @Query private var record :[RecordingModel]
//    @State var progress: Double = 0.2
//    @StateObject private var audioVM = AudioRecordingViewModel()
//    @Environment(\.layoutDirection) var layoutDirection
//
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color(.systemBackground)
//                    .ignoresSafeArea()
//                VStack {
//                    HStack {
//                        Image("Image1")
//                            .frame(width: 180, height: 180)
//                            .opacity(0.9)
//                            .padding(.leading, 10)
//                            .padding(.top, 0)
//                        Spacer()
//                    }
//                    Spacer()
//                }//v
//                
//                VStack(alignment: layoutDirection == .rightToLeft ? .trailing : .leading, spacing: 20) {
//                            Spacer()
//
//                            Text("Records")
//                                .font(.system(size: 32, weight: .bold))
//                                .foregroundColor(.primary)
//                                .frame(maxWidth: .infinity,
//                                       alignment: layoutDirection == .rightToLeft ? .trailing : .leading)
//                                .padding(.horizontal, 25)
//
//                            TextField("search...", text: $searchText)
//                                .padding(12)
//                                .foregroundColor(.primary)
//                                .background(.primary.opacity(0.08))
//                                .cornerRadius(14)
//                                .multilineTextAlignment(layoutDirection == .rightToLeft ? .trailing : .leading)
//                                .padding(.horizontal, 20)
//                    
//                    ScrollView {
//                        VStack(spacing: 18) {
////hereeeeeeeeeeeeeee
//                            
//                            
//                            ForEach(record) { rec in
//                                RecordingCardView(
//                                    id: rec.id,
//                                    title: rec.recordname,
//                                    date: rec.date,
//                                    duration: rec.duration,
//                                    progress: $progress,
//                                    fileURL: rec.audiofile,
//                                    isExpanded: expandedID == rec.id,
//                                    onTap: {
//                                        withAnimation {
//                                            expandedID = (expandedID == rec.id ? nil : rec.id)
//                                        }
//                                    },
//                                    onPlay: { url in
//                                        audioVM.playRecording(from: url)
//                                    },
//                                    onPause: {url in audioVM.pauseRecording}
//                                    
//                                )
//                            }
//                            
//                            }
//                .padding(.horizontal, 16)
//                .padding(.bottom, 40)
//            }
//        }
//        
//        VStack {
//            Spacer()
//            
//            ZStack {
//                Image("Image2")
//                    .frame(height: 180)
//                    .opacity(0.9)
//                    .cornerRadius(20)
//                    .padding(.bottom, -20)
//                
//                Image("Image3")
//                    .frame(height: 180)
//                    .opacity(0.9)
//                    .cornerRadius(20)
//                    .padding(.bottom, -15)
//                
//                NavigationLink(destination: recView()) {
//                    Image("mic11")
//                        .frame(width: 80, height: 80)
//                        .padding(.bottom, -50)
//                        .padding(.trailing,-5)
//                }
//            }
//            .padding(.bottom, -30)
//        }
//    }
//    .navigationBarBackButtonHidden(true)
//    .navigationBarHidden(true)
//        }//nav
//}//view
//
//}//struct
//
//
//struct SecondView: View {
//    var body: some View {
//        Text("هذه الصفحة الثانية")
//            .font(.largeTitle)
//            .foregroundColor(.black)
//    }
//}
////import SwiftUI
////import SwiftData
////
////struct records: View {
////    @Environment(\.modelContext) private var context
////    @State private var searchText = ""
////    @State private var expandedID: UUID? = nil
////    @Query private var record: [RecordingModel]
////    @State var progress: Double = 0.2
////    @Environment(\.layoutDirection) var layoutDirection
////    @StateObject private var audioVM = AudioRecordingViewModel()
////
////    var body: some View {
////        NavigationView {
////            ZStack {
////                Color(.systemBackground)
////                    .ignoresSafeArea()
////
////                // Background decorative image in the top-left
////                topLeftBackgroundImage
////
////                VStack(alignment: layoutDirection == .rightToLeft ? .trailing : .leading, spacing: 20) {
////                    Spacer()
////
////                    headerTitle
////
////                    searchField
////
////                    contentArea
////                }
////            }
////            .navigationBarBackButtonHidden(true)
////            .navigationBarHidden(true)
////            .onAppear {
////                // Provide SwiftData context if needed by the view model
////                audioVM.context = context
////            }
////        }
////    }
////
////    // MARK: - Extracted pieces
////
////    private var topLeftBackgroundImage: some View {
////        VStack {
////            HStack {
////                Image("Image1")
////                    .frame(width: 180, height: 180)
////                    .opacity(0.9)
////                    .padding(.leading, 10)
////                    .padding(.top, 0)
////                Spacer()
////            }
////            Spacer()
////        }
////    }
////
////    private var headerTitle: some View {
////        Text("Records")
////            .font(.system(size: 32, weight: .bold))
////            .foregroundColor(.primary)
////            .frame(maxWidth: .infinity,
////                   alignment: layoutDirection == .rightToLeft ? .trailing : .leading)
////            .padding(.horizontal, 25)
////    }
////
////    private var searchField: some View {
////        TextField("search...", text: $searchText)
////            .padding(12)
////            .foregroundColor(.primary)
////            .background(.primary.opacity(0.08))
////            .cornerRadius(14)
////            .multilineTextAlignment(layoutDirection == .rightToLeft ? .trailing : .leading)
////            .padding(.horizontal, 20)
////    }
////
////    private var contentArea: some View {
////        ZStack(alignment: .bottom) {
////            // 1. Scrollable list area
////            scrollList
////                .padding(.bottom, 50) // height of bottom bar
////                .clipped()            // prevent showing behind the bar
////
////            // 2. Bottom bar overlay
////            bottomBar
////                .padding(.bottom, -30)
////        }
////    }
////
////    private var scrollList: some View {
////        VStack {
////            ScrollView {
////                VStack(spacing: 18) {
////                    ForEach(filteredRecords) { rec in
////                        RecordingCardView(
////                            recording: rec,
////                            progress: $progress,
////                            isExpanded: expandedID == rec.id,
////                            onTap: {
////                                withAnimation {
////                                    expandedID = (expandedID == rec.id ? nil : rec.id)
////                                }
////                            },
////                            onPlay: {
////                                audioVM.playRecording(rec)
////                                print("recording is playing now 🎉")
////                            },
////                            onPause: {
////                                audioVM.pauseRecording()
////                                print("recording is paused now ☁️")
////                            }
////                        )
////                    }
////                }
////                .padding(.horizontal, 16)
////                .padding(.bottom, 40) // space above bar
////            }
////        }
////    }
////
////    private var bottomBar: some View {
////        ZStack {
////            Image("Image2")
////                .frame(height: 180)
////                .opacity(0.9)
////                .cornerRadius(20)
////                .padding(.bottom, -20)
////
////            Image("Image3")
////                .frame(height: 180)
////                .opacity(0.9)
////                .cornerRadius(20)
////                .padding(.bottom, -15)
////
////            NavigationLink(destination: recView()) {
////                Image("mic11")
////                    .frame(width: 80, height: 80)
////                    .padding(.bottom, -50)
////                    .padding(.trailing, -5)
////            }
////        }
////    }
////
////    // MARK: - Filtering helper
////
////    private var filteredRecords: [RecordingModel] {
////        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
////        guard !text.isEmpty else { return record }
////        return record.filter { rec in
////            rec.recordname.localizedCaseInsensitiveContains(text)
////            || rec.transcript.localizedCaseInsensitiveContains(text)
////        }
////    }
////}
////
////struct SecondView: View {
////    var body: some View {
////        Text("هذه الصفحة الثانية")
////            .font(.largeTitle)
////            .foregroundColor(.black)
////    }
////}
////
//#Preview {
//    records()
//}
