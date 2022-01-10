//
//  SwiftUIView.swift
//  NFC reader writer
//
//  Created by XIAOTIAN WU on 4/1/22.
//

import SwiftUI


class HapticManager{
    
    static let instance = HapticManager()
    
    func notification (type: UINotificationFeedbackGenerator.FeedbackType){
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
        
    func impact (style: UIImpactFeedbackGenerator.FeedbackStyle){
            
        let generator = UIImpactFeedbackGenerator(style:style)
        generator.impactOccurred()
    }
        
}

