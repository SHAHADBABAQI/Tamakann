//
//  ViewModel.swift
//  تمكّن
//
//  Created by nouransalah on 08/06/1447 AH.
//
//
//  ViewModel.swift
//  تمكّن
//
//  Created by nouransalah on 08/06/1447 AH.
//

import AVFoundation
import Combine
import SwiftUI
class RecViewModel : ObservableObject{
    @Published var size :CGFloat = 1
    @Published var size1 :CGFloat = 1
    @Published var animationTimer: Timer?
    @Published var time = 0.0
    @Published var timer: Timer?
    
    
//    func startSizeLoop() {
//        // Reset before starting
//        size = 1
//        size1 = 1
//
//        // Invalidate any old timer
//        animationTimer?.invalidate()
//
//        // Make a timer that fires every 1 second
//        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
//            withAnimation(.easeInOut(duration: 0.8)) {
//                self.size = (self.size == 1) ? 1.2 : 1
//                self.size1 = (self.size1 == 1.3) ? 1 : 1.3
//            }
//        }
//    }
//
//    func stopSizeLoop() {
//        animationTimer?.invalidate()
//        animationTimer = nil
//        size = 1
//    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.time += 0.01
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        
    }
    
    func startSizeLoop() {
        // Reset before starting
        size = 1
        size1 = 1
        
        // Invalidate any old timer
        animationTimer?.invalidate()
        
        // Make a timer that fires every 1 second
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.8)) {
                self.size = (self.size == 1) ? 1.2 : 1
                self.size1 = (self.size1 == 1.3) ? 1 : 1.3
            }
        }
    }

    func stopSizeLoop() {
        animationTimer?.invalidate()
        animationTimer = nil
        size = 1
    }
}

//import AVFoundation
//import Combine
//import SwiftUI
////
////// موديل كل تسجيل يظهر في صفحة records
////struct Recording: Identifiable {
////    let id: Int
////    let title: String
////    let date: String
////    let duration: String
////}
//
//class RecViewModel: ObservableObject {
//    @Published var size: CGFloat = 1
//    @Published var size1: CGFloat = 1
//    @Published var animationTimer: Timer?
//    @Published var time: Double = 0.0
//    @Published var timer: Timer?
//
////    // 👈 هنا قائمة التسجيلات الحقيقية
////    @Published var recordings: [Recording] = []
//
//    // MARK: - تايمر الوقت
//
//    func startTimer() {
//        time = 0                      // نعيد من صفر كل تسجيل
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
//            self.time += 0.01
//        }
//    }
//
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    // MARK: - أنيميشن الدوائر
//
//    func startSizeLoop() {
//        size = 1
//        size1 = 1
//        animationTimer?.invalidate()
//
//        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
//            withAnimation(.easeInOut(duration: 0.8)) {
//                self.size = (self.size == 1) ? 1.2 : 1
//                self.size1 = (self.size1 == 1.3) ? 1 : 1.3
//            }
//        }
//    }
//
//    func stopSizeLoop() {
//        animationTimer?.invalidate()
//        animationTimer = nil
//        size = 1
//        size1 = 1
//    }

    // MARK: - إضافة تسجيل جديد بعد ما نوقف في recView
//
//    func addCurrentRecording() {
//        let newID = (recordings.first?.id ?? 0) + 1
//
//        // تاريخ بالعربي
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ar_SA")
//        formatter.dateFormat = "d MMMM yyyy"
//        let dateString = formatter.string(from: Date())
//
//        // مدة بصيغة دقائق:ثواني
//        let minutes = Int(time) / 60
//        let seconds = Int(time) % 60
//        let durationString = String(format: "%d:%02d", minutes, seconds)
//
//        let rec = Recording(
//            id: newID,
//            title: String(format: "تسجيل جديد %02d", newID),
//            date: dateString,
//            duration: durationString
//        )
//
//        recordings.insert(rec, at: 0) // يطلع الكرت الجديد فوق أول واحد
//    }
//}




//    func startSizeLoop() {
//        // Reset before starting
//        size = 1
//        size1 = 1
//
//        // Invalidate any old timer
//        animationTimer?.invalidate()
//
//        // Make a timer that fires every 1 second
//        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
//            withAnimation(.easeInOut(duration: 0.8)) {
//                self.size = (self.size == 1) ? 1.2 : 1
//                self.size1 = (self.size1 == 1.3) ? 1 : 1.3
//            }
//        }
//    }
//
//    func stopSizeLoop() {
//        animationTimer?.invalidate()
//        animationTimer = nil
//        size = 1
//    }
