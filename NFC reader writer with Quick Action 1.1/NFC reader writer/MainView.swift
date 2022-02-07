//
//  ContentView.swift
//  NFC reader writer
//
//  Created by XIAOTIAN WU on 27/12/21.
//

import SwiftUI
import CoreNFC





struct MainView: View {
    
    @State private var showingAlert = false
    
    
    @State private var MaxUseTime : UInt32 = 0
    @State private var expdate = Date.now
    
    
    @FocusState private var amountIsFocused: Bool
    @StateObject  private var reader = NFCReader()
    @State private var max_use_time_writer = NFCWriter()
    
    @State private var exp_date_writer = NFCWriter_exp_date()
    
    @State private var byte = []
    @State private var animationAmount = 1.0
    @State private var showingSheet = false
    @EnvironmentObject var quickActions: QuickActionService
    let maxusetimetitle = "Please Enter Filter MaxUseTime(mins)"
    let expdatetitle = "Please Enter Filter expiry date"
    
    
    
    func readbutton ()-> Void {
        
        reader.callNFC()
        
        //showingSheet.toggle()
        
    }

    
    
    var body: some View {

        NavigationView{
           
           
                
            
            VStack(spacing: 5){
                
                
                       
           
           Text(maxusetimetitle)
                    
                    .font(.headline)
                    .foregroundColor(.yellow.opacity(1))
//                    .onDrag {NSItemProvider(object: maxusetimetitle as NSString)}
                
                HStack{
                    TextField("Filter MaxUseTime", value: $MaxUseTime,format:.number)
                        .foregroundColor((MaxUseTime <= 100000) ? Color.black : Color.red)
                        .padding()
                        //.padding(.leading)
                    
//                        .overlay(
//                            Image(systemName: "xmark.circle.fill")
//                                .padding()
//                                .offset(x: 20)
//                                
//                                .foregroundColor(Color.red)
//                                .opacity(MaxUseTime != 0 ? 1.0 : 0.0)
//                                .onTapGesture {
//                                    MaxUseTime = 0
//                                }
//
//                            ,alignment: .trailing
//                        )
                    
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
    //                    .foregroundColor(.black)
                        .font(.headline)
                       // .padding()
                        //.background(.gray)
                    
                    Button("Write") {
                        
                        if MaxUseTime >= 100000
                        {
                            showingAlert = true
                        }
                        else{
                        
                        max_use_time_writer.callNFC(maxusetimeinCallNFCfunction: MaxUseTime)
    //                    withAnimation (.interpolatingSpring(stiffness: 5, damping: 1)){
    //                        animationAmount += 360
    //}
                        HapticManager.instance.impact(style: .heavy)
                        }
                        
                    }
                    
                    .alert("Please enter value less than 100,000!", isPresented: $showingAlert) {
                                    //Button("OK", role: .cancel) { }
                    }
                    
                    .font(.headline)
                    .padding(15)
                    .background((MaxUseTime <= 100000) ? Color.yellow : Color.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    
                }
                .padding()
                
                Text("Please enter value less than 100,000!")
                    .foregroundColor(Color.red)
                    .opacity((MaxUseTime <= 100000) ? 0.0 : 1.0)
               
                Text(expdatetitle)
                         .font(.headline)
                         .foregroundColor(.yellow.opacity(1))
                
                HStack{
                    DatePicker("Please enter a time", selection: $expdate, in: Date.now... , displayedComponents: .date)
                      
                        .labelsHidden()
                        .padding()
                    
                    Spacer()
                    
                    Button("Write") {
                        exp_date_writer.callNFC(expdateinCallNFCfunction: expdate)
    //                    withAnimation (.interpolatingSpring(stiffness: 5, damping: 1)){
    //                        animationAmount += 360
    //}
                        HapticManager.instance.impact(style: .heavy)
                        
                    }
                    
                    .font(.headline)
                    .padding(15)
                    .background(.yellow)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                    
                }
                .padding()
                
             
                
                VStack(spacing:10){
             
               
//                Button("Write") {
//                    max_use_time_writer.callNFC(maxusetimeinCallNFCfunction: MaxUseTime)
////                    withAnimation (.interpolatingSpring(stiffness: 5, damping: 1)){
////                        animationAmount += 360
////}
//                    HapticManager.instance.impact(style: .heavy)
//
//                }
//
//                .font(.headline)
//                .padding(40)
//                .background(.yellow)
//                .foregroundColor(.white)
//                .clipShape(Circle())
//                .overlay(
//                    Circle()
//                        .stroke(.yellow)
//                        .scaleEffect(animationAmount)
//                        .opacity(2 - animationAmount)
//                        .animation(
//                            .easeInOut(duration: 2)
//                                .repeatForever(autoreverses: false),
//                            value: animationAmount
//                        )
//                )
//                .onAppear {
//                    animationAmount = 2
//                }
            
                    
               
        
        Button("Read") {
            reader.callNFC()
            
            //showingSheet.toggle()
            
            HapticManager.instance.impact(style: .heavy)
            
            
        
        }
        .onChange(of: quickActions.action?.rawValue, perform: {value in readbutton()})
                    
        .onChange(of: reader.finish_flag, perform: {value in showingSheet.toggle()})
        .font(.headline)
        .padding(40)
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
        .sheet(isPresented: $showingSheet) {
            DataView( dataview_0x00_0: reader.byteArray16_0x00_0,
                      dataview_0x00_1: reader.byteArray16_0x00_1,
                      dataview_0x00_2: reader.byteArray16_0x00_2,
                      dataview_0x00_3: reader.byteArray16_0x00_3,
                      dataview_0x01_0: reader.byteArray16_0x01_0,
                      dataview_0x01_1: reader.byteArray16_0x01_1,
                      dataview_0x01_2: reader.byteArray16_0x01_2,
                      dataview_0x01_3: reader.byteArray16_0x01_3,
                      dataview_0x02_0: reader.byteArray16_0x02_0,
                      dataview_0x02_1: reader.byteArray16_0x02_1,
                      dataview_0x02_2: reader.byteArray16_0x02_2,
                      dataview_0x02_3: reader.byteArray16_0x02_3,
                      dataview_0x03_0: reader.byteArray16_0x03_0,
                      dataview_0x03_1: reader.byteArray16_0x03_1,
                      dataview_0x03_2: reader.byteArray16_0x03_2,
                      dataview_0x03_3: reader.byteArray16_0x03_3,
                      dataview_0x04_0: reader.byteArray16_0x04_0,
                      dataview_0x04_1: reader.byteArray16_0x04_1,
                      dataview_0x04_2: reader.byteArray16_0x04_2,
                      dataview_0x04_3: reader.byteArray16_0x04_3,
                      dataview_0x05_0: reader.byteArray16_0x05_0,
                      dataview_0x05_1: reader.byteArray16_0x05_1,
                      dataview_0x05_2: reader.byteArray16_0x05_2,
                      dataview_0x05_3: reader.byteArray16_0x05_3,
                      dataview_0x06_0: reader.byteArray16_0x06_0,
                      dataview_0x06_1: reader.byteArray16_0x06_1,
                      dataview_0x06_2: reader.byteArray16_0x06_2,
                      dataview_0x06_3: reader.byteArray16_0x06_3,
                      dataview_0x07_0: reader.byteArray16_0x07_0,
                      dataview_0x07_1: reader.byteArray16_0x07_1,
                      dataview_0x07_2: reader.byteArray16_0x07_2,
                      dataview_0x07_3: reader.byteArray16_0x07_3,
                      dataview_0x08_0: reader.byteArray16_0x08_0,
                      dataview_0x08_1: reader.byteArray16_0x08_1,
                      dataview_0x08_2: reader.byteArray16_0x08_2,
                      dataview_0x08_3: reader.byteArray16_0x08_3,
                      dataview_0x09_0: reader.byteArray16_0x09_0,
                      dataview_0x09_1: reader.byteArray16_0x09_1,
                      dataview_0x09_2: reader.byteArray16_0x09_2,
                      dataview_0x09_3: reader.byteArray16_0x09_3,
                      dataview_0x0a_0: reader.byteArray16_0x0a_0,
                      dataview_0x0a_1: reader.byteArray16_0x0a_1,
                      dataview_0x0a_2: reader.byteArray16_0x0a_2,
                      dataview_0x0a_3: reader.byteArray16_0x0a_3,
                      dataview_0x0b_0: reader.byteArray16_0x0b_0,
                      dataview_0x0b_1: reader.byteArray16_0x0b_1,
                      dataview_0x0b_2: reader.byteArray16_0x0b_2,
                      dataview_0x0b_3: reader.byteArray16_0x0b_3,
                      dataview_0x0c_0: reader.byteArray16_0x0c_0,
                      dataview_0x0c_1: reader.byteArray16_0x0c_1,
                      dataview_0x0c_2: reader.byteArray16_0x0c_2,
                      dataview_0x0c_3: reader.byteArray16_0x0c_3,
                      dataview_max_use_time: reader.IntValue_0x0b_max_filter_use_time,
                      dataview_set_exp_time: reader.expiry_date
                    //  dataview_set_exp_time: reader.expiry_date
                      
                      
                     )
                }
                    
      
                    
                
  
            
//            Text("Hexadecimal Data is \(reader.byteArray16_0x0b_0) \(reader.byteArray16_0x0b_1) \(reader.byteArray16_0x0b_2) \(reader.byteArray16_0x0b_3)")
//                    .font(.headline)
//                    .foregroundColor(.red.opacity(1))
//            Text("Decimal Data is \(reader.IntValue_0x0b_max_filter_use_time)")
//                    .font(.headline)
//                    .foregroundColor(.red.opacity(1))
                
                
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




