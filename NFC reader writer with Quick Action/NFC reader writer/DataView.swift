//
//  secondview.swift
//  NFC reader writer
//
//  Created by XIAOTIAN WU on 4/1/22.
//

import SwiftUI

struct DataView: View {
    @Environment(\.dismiss) var dismiss
    @State private var animationAmount = 1.0
    let int_value : UInt32
    
    var body: some View {
        NavigationView{
            VStack(spacing:200){
        
        Text("Max Use Time is \(int_value) mins")
                    .font(.headline)
                    
                
            
        Button("Dismiss") {
                dismiss()
            HapticManager.instance.impact(style: .heavy)
            }
        .padding(50)
        .background(.green)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.green)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 2)
                        .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
        
        
        }
        .navigationTitle("Filter Data")
        }
    }
}
