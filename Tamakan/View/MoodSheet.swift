//
//  MoodSheet.swift
//  Tamakan
//
//  Created by Yasmin Alhabib on 15/12/2025.
//

import SwiftUI

struct MoodSheet: View {
    
    @State private var selectedMood: String? = nil
    @State private var moodNote: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            
            // العنوان
            Text("I'm Feeling...")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.primary)
                .padding(.top, 20)
            
            // الأيقونات
            HStack(spacing: 12) { // قللت المسافة من 16 إلى 12
                moodItem(imageName: "happy", title: "HAPPY")
                moodItem(imageName: "calm", title: "CALM")
                moodItem(imageName: "neutral", title: "NEUTRAL")
                moodItem(imageName: "stressed", title: "STRESSED")
                moodItem(imageName: "overwhelmed", title: "OVERWHELMED")
            }
            .padding(.horizontal, 16)
            
            // مربع النص
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.15), lineWidth: 1) // قللت من 0.2 إلى 0.15
                    )
                    .frame(height: 100)
                
                if moodNote.isEmpty {
                    Text("Write how you're feeling... (optional)")
                        .foregroundColor(.primary.opacity(0.4))
                        .font(.system(size: 15))
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                }
                
                TextEditor(text: $moodNote)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .font(.system(size: 15))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .frame(height: 100)
            }
            .padding(.horizontal, 20)
            
            // زر Done
            Button {
                // هنا تحفظ المود والنوت
                dismiss()
            } label: {
                Text("Done")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(.thinMaterial) // غيرت من ultraThinMaterial إلى thinMaterial عشان أشف أكثر
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1) // قللت من 0.2
                )
        )
        .presentationDetents([.height(420)])
        .presentationDragIndicator(.hidden)
    }
    
    private func moodItem(imageName: String, title: String) -> some View {
        Button {
            selectedMood = imageName
        } label: {
            VStack(spacing: 6) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                
                Text(title)
                    .font(.system(size: 8, weight: .semibold)) // صغرت من 9 إلى 8
                    .foregroundColor(.primary.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 58) // كبرت العرض من 55 إلى 58
                    .minimumScaleFactor(0.6) // خليته ينزل لحد 60% من الحجم
                    .fixedSize(horizontal: false, vertical: true) // يتكيف مع الارتفاع
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(selectedMood == imageName
                          ? Color.white.opacity(0.15)
                          : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.3)
            .ignoresSafeArea()
        
        MoodSheet()
    }
}
