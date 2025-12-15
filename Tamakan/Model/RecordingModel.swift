//
//  RecordingModel.swift
//  تمكّن
//
//  Created by nouransalah on 08/06/1447 AH.
//
import SwiftUI
import SwiftData
//need init
@Model
class RecordingModel: Identifiable {
    //var id:UUID
    @Attribute(.unique) var id: UUID
    var recordname: String
    var duration: Double
    var date: Date
    var transcript: String
    var audiofile: URL
    var countStutter: Int = 0
    var moodRating: Int = 0
    var emothionText: String = ""
    //i have to intilise all data i can not init some of data
    init(recordname: String, duration: Double, date: Date, transcript: String, audiofile: URL , countStutter: Int, moodRating: Int ,
         emothionText: String) {
        self.id = UUID()
        self.recordname = recordname
        self.duration = duration
        self.date = date
        self.transcript = transcript
        self.audiofile = audiofile
        self.countStutter = countStutter
        self.moodRating = moodRating
        self.emothionText = emothionText
        
    }
    
    
}//class

enum StutteringTypes: String , Codable{
       case repetition
       case prolongation
       case block
}

