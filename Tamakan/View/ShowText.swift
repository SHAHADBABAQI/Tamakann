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
    @State private var text = ""
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
            
            Text("اليوم")
                .font(.title2.bold())
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Divider()
                .background(dividerColor)
            
            TextEditor(text: $text)
                .font(.system(size: 18))
                .foregroundColor(textColor)
                .scrollContentBackground(.hidden)
                .frame(minHeight: 150, alignment: .topTrailing)
            
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
    ShowText()
}
