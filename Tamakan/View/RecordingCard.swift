//
//  RecordingCard.swift
//  tamakan333333
//
//  Created by nouransalah on 13/06/1447 AH.
//
import SwiftUI
struct RecordingCardView: View {
    let id: UUID
    let title: String
    let date: Date
    let duration: Double
    @Binding var progress: Double
    let isActive: Bool
    let fileURL: URL
    var isExpanded: Bool
    let onTap: () -> Void
    let onPlay: (URL) -> Void
    let onPause: () -> Void
    let onSeekStart: () -> Void
    let onSeekEnd: () -> Void
    let onForward: () -> Void
    let onBackward: () -> Void
    let recordingModel : RecordingModel
    let onDelete: (RecordingModel) -> Void
    let onRename: (String) -> Void   // 👈 NEW
    @State var isPlaying = false
    @State private var showTextSheet = false

    
    //let summary: (RecordingModel) -> Void
    


    var body: some View {
        
        
        VStack(alignment: .trailing, spacing: 12) {

            // Top part
            HStack {
                Text(smartFormatDuration(duration))
                    .foregroundColor(.primary.opacity(0.8))


                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    if isExpanded {
                        TextField("Title", text: Binding(
                            get: { title },
                            set: { newValue in onRename(newValue) }   // call update
                        ))
                        .foregroundColor(.primary)
                        .font(.title3)
                        .bold()
                    } else {
                        Text(title)
                            .foregroundColor(.primary)
                            .font(.title3)
                            .bold()
                    }


                    Text(date.formatted())
                        .foregroundColor(.primary.opacity(0.6))
                        .font(.caption)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture { onTap() }

            // Expanded section
            if isExpanded {
                VStack(spacing: 12) {

                    Slider(
                        value: $progress,
                        in: 0...1,
                        onEditingChanged: { editing in
                            if editing {
                                onSeekStart()
                            } else {
                                onSeekEnd()
                            }
                        }
                    )
                    .disabled(!isActive)


//                    HStack {
//                        Text("-1:10")
//                        Spacer()
//                        Text("0:00")
//                    }
//                    .font(.caption2)
//                    .foregroundColor(.primary.opacity(0.6))

                    // Action buttons
                    HStack(spacing: 28) {
                        Button(action: {
                                showTextSheet = true
                            }) {
                                Image(systemName: "text.bubble")
                                    .font(.title2)
                            }
                            .sheet(isPresented: $showTextSheet) {
                                ShowText(recording: recordingModel)
                            }
                     
                        
                        
                        Button(action: onForward) {
                                Image(systemName: "goforward.10")
                                    .font(.title2)
                            }
                        .disabled(!isActive)

                        
                        Button {
                            if isPlaying {
                                onPause()
                            } else {
                                onPlay(fileURL)
                            }
                            isPlaying.toggle()
                        } label: {
                            Image(isPlaying ? "pauseButton" : "playButton")
                                 .resizable()
                                 .frame(width: 35, height: 35)
                                 .font(.system(size: 42))
                        }


                        Button(action: onBackward) {
                                Image(systemName: "gobackward.10")
                                    .font(.title2)
                            }
                        .disabled(!isActive)

                        Button {
                            
                            onDelete(recordingModel)
                        }label:{
                            Image(systemName: "trash")
                        }
                        
                        
                        
                        
                    }
                    .foregroundColor(.primary)

                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(minHeight: isExpanded ? 200 : 80)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.primary.opacity(0.10))
        )
    
        .animation(.easeInOut, value: isExpanded)
    }
    
    func smartFormatDuration(_ time: Double) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
        if minutes > 0 {
            return String(format: "%d:%02d", minutes, seconds)
        }
        if time < 10 {
            return String(format: "%01d.%02d", seconds, milliseconds)
        }
        return "\(seconds)s"
    }


}
