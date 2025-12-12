//
//  Untitled.swift
//  تمكّن
//
//  Created by Ghady Al Omar on 10/06/1447 AH.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct ShowText: View {
    let recording: RecordingModel
    @State private var text: String
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var todayDate: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ar_SA")
        f.dateFormat = "d MMMM yyyy"
        return f.string(from: Date())
    }
    
    var sheetBackground: Color {
        if colorScheme == .dark {
            return Color(red: 0.13, green: 0.13, blue: 0.13)
        } else {
            return Color(.systemGray6)
        }
    }
    
    var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var dividerColor: Color {
        if colorScheme == .dark {
            return Color.white.opacity(0.9)
        } else {
            return Color.black.opacity(0.15)
        }
    }
     
    init(recording: RecordingModel) {
        self.recording = recording
        _text = State(initialValue: recording.transcript)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            ZStack {
                Text(todayDate)
                    .foregroundColor(textColor)
                
                HStack {
                  
                    
                    
                    Spacer()
                    
                    Button("إنهاء") {
                        dismiss()
                    }
                    .foregroundColor(textColor)
                }
            }
            .font(.system(size: 18, weight: .regular))
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("الملخص")
                    .font(.title2.bold())
                    .foregroundColor(textColor)
                
                HStack {
                    Label(todayDate, systemImage: "calendar")
                    Spacer()
                    Label("\(recording.countStutter) تكرار", systemImage: "waveform")
                }
                .font(.subheadline)
                .foregroundColor(textColor.opacity(0.8))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Divider()
                .background(dividerColor)
            
            ScrollView {
                Text(text.isEmpty ? "لا يوجد نص نهائي" : text)
                    .font(.system(size: 18))
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
            }
            
            Spacer(minLength: 0)
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .top)
        .background(sheetBackground) // هنا التبديل بين الرمادي الغامق والفاتح
        .clipShape(RoundedCorner(radius: 32, corners: [.topLeft, .topRight]))
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .environment(\.layoutDirection, .rightToLeft)
    }
}

#Preview {
    ShowText(
        recording: RecordingModel(
            recordname: "تسجيل تجريبي",
            duration: 10.5,
            date: .now,
            transcript: "هذا نص تجريبي للتأكد من العرض.",
            audiofile: URL(string: "file:///tmp/sample.caf")!,
            countStutter: 3
        )
    )
}
