////
////  records.swift
////  تمكّن
////
////  Created by noura on 01/12/2025.
////

import SwiftUI
import SwiftData

struct records: View {
    @Environment(\.modelContext) private var context
    @State private var searchText = ""
    @State private var expandedID: UUID? = nil
    @Query private var record: [RecordingModel]
    @State var progress: Double = 0.2
    @Environment(\.layoutDirection) var layoutDirection
    @StateObject private var audioVM = AudioRecordingViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                // Background decorative image in the top-left
                topLeftBackgroundImage

                VStack(alignment: layoutDirection == .rightToLeft ? .trailing : .leading, spacing: 20) {
                    Spacer()

                    headerTitle

                    searchField

                    contentArea
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onAppear {
                // Provide SwiftData context if needed by the view model
                audioVM.context = context
            }
        }
    }

    // MARK: - Extracted pieces

    private var topLeftBackgroundImage: some View {
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
        }
    }

    private var headerTitle: some View {
        Text("Records")
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity,
                   alignment: layoutDirection == .rightToLeft ? .trailing : .leading)
            .padding(.horizontal, 25)
    }

    private var searchField: some View {
        TextField("search...", text: $searchText)
            .padding(12)
            .foregroundColor(.primary)
            .background(.primary.opacity(0.08))
            .cornerRadius(14)
            .multilineTextAlignment(layoutDirection == .rightToLeft ? .trailing : .leading)
            .padding(.horizontal, 20)
    }

    private var contentArea: some View {
        ZStack(alignment: .bottom) {
            // 1. Scrollable list area
            scrollList
                .padding(.bottom, 50) // height of bottom bar
                .clipped()            // prevent showing behind the bar

            // 2. Bottom bar overlay
            bottomBar
                .padding(.bottom, -30)
        }
    }

    private var scrollList: some View {
        VStack {
            ScrollView {
                VStack(spacing: 18) {
                    ForEach(filteredRecords) { rec in
                        RecordingCardView(
                            recording: rec,
                            progress: $progress,
                            isExpanded: expandedID == rec.id,
                            onTap: {
                                withAnimation {
                                    expandedID = (expandedID == rec.id ? nil : rec.id)
                                }
                            },
                            onPlay: {
                                audioVM.playRecording(rec)
                                print("recording is playing now 🎉")
                            },
                            onPause: {
                                audioVM.pauseRecording()
                                print("recording is paused now ☁️")
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40) // space above bar
            }
        }
    }

    private var bottomBar: some View {
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
                    .padding(.trailing, -5)
            }
        }
    }

    // MARK: - Filtering helper

    private var filteredRecords: [RecordingModel] {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return record }
        return record.filter { rec in
            rec.recordname.localizedCaseInsensitiveContains(text)
            || rec.transcript.localizedCaseInsensitiveContains(text)
        }
    }
}

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
