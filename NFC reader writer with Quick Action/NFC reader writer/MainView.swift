//
//  ContentView.swift
//  NFC reader writer
//
//  Created by XIAOTIAN WU on 27/12/21.
//

import SwiftUI
import CoreNFC





struct MainView: View {
    @State private var MaxUseTime : UInt32 = 0
    @FocusState private var amountIsFocused: Bool
    @StateObject  private var reader = NFCReader()
    @State private var writer = NFCWriter()
    
    @State private var byte = []
    @State private var animationAmount = 1.0
    @State private var showingSheet = false
    @EnvironmentObject var quickActions: QuickActionService
    var maxusetimetitle = "Please Enter Filter MaxUseTime(mins)"
    
    
    func readbutton ()-> Void {
        
        reader.callNFC()
        
        showingSheet.toggle()
        
    }

    
    
    var body: some View {

        NavigationView{
           
           
                
            
            VStack(spacing: 10){
                
           
           Text(maxusetimetitle)
                    .font(.headline)
                    .foregroundColor(.yellow.opacity(1))
//                    .onDrag {NSItemProvider(object: maxusetimetitle as NSString)}
                
                TextField("Filter MaxUseTime", value: $MaxUseTime,format:.number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .focused($amountIsFocused)
//                    .foregroundColor(.black)
                    .font(.headline)
                    //.background(.gray)
                
                VStack(spacing:20){
             
               
                Button("Write") {
                    writer.callNFC(maxusetimeinCallNFCfunction: MaxUseTime)
//                    withAnimation (.interpolatingSpring(stiffness: 5, damping: 1)){
//                        animationAmount += 360
//}
                    HapticManager.instance.impact(style: .heavy)
                    
                }
                
                .font(.headline)
                .padding(40)
                .background(.yellow)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.yellow)
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
            
                    
               
        
        Button("Read") {
            reader.callNFC()
            
            showingSheet.toggle()
            
            HapticManager.instance.impact(style: .heavy)
            
            
        
        }
        .onChange(of: quickActions.action?.rawValue, perform: { value in readbutton()})
        .font(.headline)
        .padding(40)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
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
        .sheet(isPresented: $showingSheet) {
            DataView(int_value: reader.IntValue)
                }
                    
      
                    
                
            VStack( spacing: 20){
            
            Text("Hexadecimal Data is \(reader.byteArray16_0) \(reader.byteArray16_1) \(reader.byteArray16_2) \(reader.byteArray16_3)")
                    .font(.headline)
                    .foregroundColor(.red.opacity(1))
            Text("Decimal Data is \(reader.IntValue)")
                    .font(.headline)
                    .foregroundColor(.red.opacity(1))
                
                
                NavigationLink{
                    Text("Please read carefully about how to use this App ")
                        
                }
            label:{
                Text("How to use this App?")
                   .frame(minWidth: 0, maxHeight: 100, alignment: .bottomLeading)
            }
                
                
                Link("Visit Our Website", destination: URL(string: "https://cleanspacetechnology.com")!)
                    
             
            }
    }
           
            
                
        

}
          
           
        
       
        .preferredColorScheme(.light)
        .navigationTitle("Filter Reader/Writer")
        .navigationBarHidden(amountIsFocused)
        
        
        
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                   
                   
                }
            }
        }
        
    }
        
  }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



