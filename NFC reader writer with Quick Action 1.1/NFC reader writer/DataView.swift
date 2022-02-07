//
//  secondview.swift
//  NFC reader writer
//
//  Created by XIAOTIAN WU on 4/1/22.
//

import SwiftUI
import CoreNFC

struct DataView: View {
    @Environment(\.dismiss) var dismiss
    //@State private var animationAmount = 1.0
    
    
    //@StateObject  private var reader = NFCReader()
    
    //var int_value_0x0b_max_filter_use_time : UInt32
    
    let dataview_0x00_0 : String
    let dataview_0x00_1 : String
    let dataview_0x00_2 : String
    let dataview_0x00_3 : String
    
    let dataview_0x01_0 : String
    let dataview_0x01_1 : String
    let dataview_0x01_2 : String
    let dataview_0x01_3 : String
    
    let dataview_0x02_0 : String
    let dataview_0x02_1 : String
    let dataview_0x02_2 : String
    let dataview_0x02_3 : String
    
    let dataview_0x03_0 : String
    let dataview_0x03_1 : String
    let dataview_0x03_2 : String
    let dataview_0x03_3 : String
    
    let dataview_0x04_0 : String
    let dataview_0x04_1 : String
    let dataview_0x04_2 : String
    let dataview_0x04_3 : String
    
    let dataview_0x05_0 : String
    let dataview_0x05_1 : String
    let dataview_0x05_2 : String
    let dataview_0x05_3 : String
    
    let dataview_0x06_0 : String
    let dataview_0x06_1 : String
    let dataview_0x06_2 : String
    let dataview_0x06_3 : String
    
    let dataview_0x07_0 : String
    let dataview_0x07_1 : String
    let dataview_0x07_2 : String
    let dataview_0x07_3 : String
    
    let dataview_0x08_0 : String
    let dataview_0x08_1 : String
    let dataview_0x08_2 : String
    let dataview_0x08_3 : String
    
    let dataview_0x09_0 : String
    let dataview_0x09_1 : String
    let dataview_0x09_2 : String
    let dataview_0x09_3 : String
    
    let dataview_0x0a_0 : String
    let dataview_0x0a_1 : String
    let dataview_0x0a_2 : String
    let dataview_0x0a_3 : String
    
    let dataview_0x0b_0 : String
    let dataview_0x0b_1 : String
    let dataview_0x0b_2 : String
    let dataview_0x0b_3 : String
    
    
    let dataview_0x0c_0 : String
    let dataview_0x0c_1 : String
    let dataview_0x0c_2 : String
    let dataview_0x0c_3 : String
    
    let dataview_max_use_time: UInt32
    let dataview_set_exp_time : [Int]
    
    
    
    
    

 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                List{
//                    Text("Max Use Time is \(reader.IntValue_0x0b_max_filter_use_time) mins")
//                                .font(.headline)
                    
                    
                    Group{
                    Text("0x00: \(dataview_0x00_0) \(dataview_0x00_1) \(dataview_0x00_2) \(dataview_0x00_3)")
                    Text("0x01: \(dataview_0x01_0) \(dataview_0x01_1) \(dataview_0x01_2) \(dataview_0x01_3)")
                    Text("0x02: \(dataview_0x02_0) \(dataview_0x02_1) \(dataview_0x02_2) \(dataview_0x02_3)")
                    Text("0x03: \(dataview_0x03_0) \(dataview_0x03_1) \(dataview_0x03_2) \(dataview_0x03_3)")
                    Text("0x04: \(dataview_0x04_0) \(dataview_0x04_1) \(dataview_0x04_2) \(dataview_0x04_3)")
                    Text("0x05: \(dataview_0x05_0) \(dataview_0x05_1) \(dataview_0x05_2) \(dataview_0x05_3)")
                    Text("0x06: \(dataview_0x06_0) \(dataview_0x06_1) \(dataview_0x06_2) \(dataview_0x06_3)")
                    }
                    Text("0x07: \(dataview_0x07_0) \(dataview_0x07_1) \(dataview_0x07_2) \(dataview_0x07_3)")
                    Text("0x08: \(dataview_0x08_0) \(dataview_0x08_1) \(dataview_0x08_2) \(dataview_0x08_3)")
                    Text("0x09: \(dataview_0x09_0) \(dataview_0x09_1) \(dataview_0x09_2) \(dataview_0x09_3)")
                    Text("0x0A: \(dataview_0x0a_0) \(dataview_0x0a_1) \(dataview_0x0a_2) \(dataview_0x0a_3)")
                    Text("0x0B: \(dataview_0x0b_0) \(dataview_0x0b_1) \(dataview_0x0b_2) \(dataview_0x0b_3)\nMax use time: \(dataview_max_use_time) Mins")
                    Text("0x0C: \(dataview_0x0c_0) \(dataview_0x0c_1) \(dataview_0x0c_2) \(dataview_0x0c_3)\nSet exp date: \(dataview_set_exp_time[0])/ \(month_number_to_letter( month: dataview_set_exp_time[1])) /\(dataview_set_exp_time[2])")
                    
                    
                }
        
        
                    
        Spacer()
            
        Button("Dismiss") {
                dismiss()
            HapticManager.instance.impact(style: .heavy)
            }
        .padding(20)
        .background(.green)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
//        .overlay(
//            Circle()
//                .stroke(.green)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeInOut(duration: 2)
//                        .repeatForever(autoreverses: false),
//                    value: animationAmount
//                )
//        )
//        .onAppear {
//            animationAmount = 2
//        }
        
        
        }
        .navigationTitle("Filter Data")
        }
    }
    
    func month_number_to_letter (month:Int) -> String
    {
        switch month {
        case 1 :
            return "Jan"
        case 2 :
            return "Feb"
        case 3 :
            return "Mar"
        case 4 :
            return "Apr"
        case 5 :
            return "May"
        case 6 :
            return "June"
        case 7 :
            return "July"
        case 8 :
            return "Aug"
        case 9 :
            return "Sept"
        case 10 :
            return "Oct"
        case 11 :
            return "Nov"
        case 12 :
            return "Dec"
        
        default:
            return ""
        }
        
        
    }
}
