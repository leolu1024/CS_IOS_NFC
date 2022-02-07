//
//  Reader.swift
//  NFC reader writer
//
//  Created by XIAOTIAN WU on 29/12/21.
//

import Foundation
import CoreNFC
import CoreText

    

class NFCReader: NSObject, NFCTagReaderSessionDelegate, ObservableObject{
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
    
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        
        // Check the invalidation reason from the returned error.
                if let readerError = error as? NFCReaderError {
                    // Show an alert when the invalidation reason is not because of a
                    // successful read during a single-tag read session, or because the
                    // user canceled a multiple-tag read session from the UI or
                    // programmatically using the invalidate method call.
                    if readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead,
                        readerError.code != .readerSessionInvalidationErrorUserCanceled {
                        DispatchQueue.main.async {
                            
                        }
                    }
                }

                // To read new tags, a new session instance is required.
                //release
                tagSession = nil
    
    }
    
    
    
    
    
    var maxusetime = 0
     var tagSession: NFCTagReaderSession?
    
    @Published var finish_flag = false
    
    //0x00 Tag authentication number
    @Published var byteArray16_0x00_0 = "XX"
    @Published var byteArray16_0x00_1 = "XX"
    @Published var byteArray16_0x00_2 = "XX"
    @Published var byteArray16_0x00_3 = "XX"
    
    //0x01 UID part1
    @Published var byteArray16_0x01_0 = "XX"
    @Published var byteArray16_0x01_1 = "XX"
    @Published var byteArray16_0x01_2 = "XX"
    @Published var byteArray16_0x01_3 = "XX"
    
    //0x02 UID part2
    @Published var byteArray16_0x02_0 = "XX"
    @Published var byteArray16_0x02_1 = "XX"
    @Published var byteArray16_0x02_2 = "XX"
    @Published var byteArray16_0x02_3 = "XX"
    
    //0x03 filter part number part 1
    @Published var byteArray16_0x03_0 = "XX"
    @Published var byteArray16_0x03_1 = "XX"
    @Published var byteArray16_0x03_2 = "XX"
    @Published var byteArray16_0x03_3 = "XX"
    
    //0x04 filter part number part 2
    @Published var byteArray16_0x04_0 = "XX"
    @Published var byteArray16_0x04_1 = "XX"
    @Published var byteArray16_0x04_2 = "XX"
    @Published var byteArray16_0x04_3 = "XX"
    
    //0x05 starting resistance
    @Published var byteArray16_0x05_0 = "XX"
    @Published var byteArray16_0x05_1 = "XX"
    @Published var byteArray16_0x05_2 = "XX"
    @Published var byteArray16_0x05_3 = "XX"
    
    //0x06 clog resistance
    @Published var byteArray16_0x06_0 = "XX"
    @Published var byteArray16_0x06_1 = "XX"
    @Published var byteArray16_0x06_2 = "XX"
    @Published var byteArray16_0x06_3 = "XX"
    
    //0x07 factory set expiry date
    @Published var byteArray16_0x07_0 = "XX"
    @Published var byteArray16_0x07_1 = "XX"
    @Published var byteArray16_0x07_2 = "XX"
    @Published var byteArray16_0x07_3 = "XX"
    
    //0x08 minutue meter
    @Published var byteArray16_0x08_0 = "XX"
    @Published var byteArray16_0x08_1 = "XX"
    @Published var byteArray16_0x08_2 = "XX"
    @Published var byteArray16_0x08_3 = "XX"
    
    //0x09 last time filter used part1
    @Published var byteArray16_0x09_0 = "XX"
    @Published var byteArray16_0x09_1 = "XX"
    @Published var byteArray16_0x09_2 = "XX"
    @Published var byteArray16_0x09_3 = "XX"
    
    //0x0A last time filter used part2
    @Published var byteArray16_0x0a_0 = "XX"
    @Published var byteArray16_0x0a_1 = "XX"
    @Published var byteArray16_0x0a_2 = "XX"
    @Published var byteArray16_0x0a_3 = "XX"
    
    
    //0x0b max filter use time
    @Published var byteArray16_0x0b_0 = "XX"
    @Published var byteArray16_0x0b_1 = "XX"
    @Published var byteArray16_0x0b_2 = "XX"
    @Published var byteArray16_0x0b_3 = "XX"
    
    
    //0x0c user set expiry date
    @Published var byteArray16_0x0c_0 = "XX"
    @Published var byteArray16_0x0c_1 = "XX"
    @Published var byteArray16_0x0c_2 = "XX"
    @Published var byteArray16_0x0c_3 = "XX"
    
    @Published var IntValue_0x0b_max_filter_use_time : UInt32 = 0
    @Published var expiry_date : [Int] = []
    
    
    
    
    
 
    
    
     
 
     
//    func scan ( maxusetime1 : Int){
//        maxusetime = maxusetime1
//        nfcSession = NFCTagReaderSession(pollingOption: .iso15693, delegate: self)
//        nfcSession?.alertMessage = "Hold you iphone near the filter NFC Tag"
//        nfcSession?.begin()
//
//    }
//
//
//    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {}
//    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {}
//    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
//
//        let maxusetime2:Int = maxusetime
//        if tags.count > 1 {
//            let retryInterval = DispatchTimeInterval.microseconds(500)
//            session.alertMessage = " More than one filter Detected, please try again "
//            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {
//                session.restartPolling()
//        })
//        return
//        }
//        let tag = tags.first!
//
//        session.connect(to: tag) {(error: Error?) in
//            if nil != error{
//                session.alertMessage = "Unable to Connect to Filter"
//                session.invalidate()
//                return
//            }
//                print("Connected to tag!")
//
//
//        }
//
//    }
    
    
    func callNFC() {
          // check if can scan nfc
            guard NFCTagReaderSession.readingAvailable else {

                return
            }

        tagSession  = NFCTagReaderSession(pollingOption: NFCTagReaderSession.PollingOption.iso15693,
                                             delegate: self,
                                             queue: nil)
        tagSession?.alertMessage = NSLocalizedString("Please hold your iphone closer to the filter", comment: "")
        tagSession?.begin()
        }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
         //check if there are more than one tag
            if tags.count > 1 {
                let retryInterval = DispatchTimeInterval.milliseconds(500)
                session.invalidate(errorMessage: NSLocalizedString("Too many tags", comment: ""))
                DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                    session.restartPolling()
                }
                return
            }

//         check if iso 15693
//            guard case let NFCTag.iso15693(_) = tags.first! else {
//                return
//            }
        
        let tag = tags.first!
        
                session.connect(to: tag) {
                  (error: Error?) in
                    if nil != error{
                        session.alertMessage = "Unable to Connect to Filter"
                        session.invalidate()
                        return
                    }
//                    session.alertMessage = "Connected to Filter"
//
//                    switch tag {
//                    case .iso15693(let tag):
//                        // Read one block of data
//                        tag.readSingleBlock(requestFlags: .highDataRate, blockNumber: 0, resultHandler: { data in
//                            print(data)
//                        })
//                    default:
//                        session.invalidate(errorMessage: "Unsupported NFC tag.")
//                    }
                    
                    switch tag {
                    case .iso15693(let tag1):
                        // Read one block of data
                        
                        
//                        tag1.readSingleBlock(requestFlags: [.highDataRate, .address],
//                                             blockNumber: 0x0B) { data, error in
//
//                         if error != nil {
//                             session.invalidate(errorMessage:"Fail to Read，please try again")
//                             session.invalidate()
//                             return
//                         }
//
//                            let datatobyte = [UInt8](data)
//
//                          print(datatobyte)
//                            let byteArray  = datatobyte.map{$0}
//
//                            DispatchQueue.global(qos: .userInitiated).async {
//
//                                DispatchQueue.main.async { [weak self] in
//                                    self?.byteArray16_0x0b_0 = String (format:"%02X",byteArray[0])
//                                    self?.byteArray16_0x0b_1 = String (format:"%02X",byteArray[1])
//                                    self?.byteArray16_0x0b_2 = String (format:"%02X",byteArray[2])
//                                    self?.byteArray16_0x0b_3 = String (format:"%02X",byteArray[3])
//
//
//                                    let data = Data( _ : [byteArray[3],byteArray[2],byteArray[1],byteArray[0]])
//
//                                    self?.IntValue_0x0b_max_filter_use_time = UInt32(bigEndian: data.withUnsafeBytes { $0.load(as: UInt32.self) })
//
//                                    session.alertMessage = "Read Success  Hex: \(self!.byteArray16_0x0b_0) \(self!.byteArray16_0x0b_1) \(self!.byteArray16_0x0b_2) \(self!.byteArray16_0x0b_3)   "
//
//                                }
//                            }
//
//
//                         session.invalidate()
//
//
//                     }
                        
                        
                        // read multiple blocks at same time
                        
                        tag1.readMultipleBlocks(requestFlags: .highDataRate, blockRange: NSRange (location: 0, length: 13)) { [self] data, error in

                         if error != nil {
                             session.invalidate(errorMessage:"Fail to Read，please try again")
                             session.invalidate()
                             return
                         }
                            let datatobyte_0x00 = [UInt8](data[0])
                            let datatobyte_0x01 = [UInt8](data[1])
                            let datatobyte_0x02 = [UInt8](data[2])
                            let datatobyte_0x03 = [UInt8](data[3])
                            let datatobyte_0x04 = [UInt8](data[4])
                            let datatobyte_0x05 = [UInt8](data[5])
                            let datatobyte_0x06 = [UInt8](data[6])
                            let datatobyte_0x07 = [UInt8](data[7])
                            let datatobyte_0x08 = [UInt8](data[8])
                            let datatobyte_0x09 = [UInt8](data[9])
                            let datatobyte_0x0a = [UInt8](data[10])
                            let datatobyte_0x0b = [UInt8](data[11])
                            let datatobyte_0x0c = [UInt8](data[12])
                            
                         
                          print(datatobyte_0x0b)
                            let byteArray_0x00  = datatobyte_0x00.map{$0}
                            let byteArray_0x01  = datatobyte_0x01.map{$0}
                            let byteArray_0x02  = datatobyte_0x02.map{$0}
                            let byteArray_0x03  = datatobyte_0x03.map{$0}
                            let byteArray_0x04  = datatobyte_0x04.map{$0}
                            let byteArray_0x05  = datatobyte_0x05.map{$0}
                            let byteArray_0x06  = datatobyte_0x06.map{$0}
                            let byteArray_0x07  = datatobyte_0x07.map{$0}
                            let byteArray_0x08  = datatobyte_0x08.map{$0}
                            let byteArray_0x09  = datatobyte_0x09.map{$0}
                            let byteArray_0x0a  = datatobyte_0x0a.map{$0}
                            let byteArray_0x0b  = datatobyte_0x0b.map{$0}
                            let byteArray_0x0c  = datatobyte_0x0c.map{$0}
                            
                            DispatchQueue.global(qos: .userInitiated).async {
                                
                                DispatchQueue.main.async { [weak self] in
                                    
                                    self?.byteArray16_0x00_0 = String (format:"%02X",byteArray_0x00[0])
                                    self?.byteArray16_0x00_1 = String (format:"%02X",byteArray_0x00[1])
                                    self?.byteArray16_0x00_2 = String (format:"%02X",byteArray_0x00[2])
                                    self?.byteArray16_0x00_3 = String (format:"%02X",byteArray_0x00[3])
                                    
                                    self?.byteArray16_0x01_0 = String (format:"%02X",byteArray_0x01[0])
                                    self?.byteArray16_0x01_1 = String (format:"%02X",byteArray_0x01[1])
                                    self?.byteArray16_0x01_2 = String (format:"%02X",byteArray_0x01[2])
                                    self?.byteArray16_0x01_3 = String (format:"%02X",byteArray_0x01[3])
                                    
                                    self?.byteArray16_0x02_0 = String (format:"%02X",byteArray_0x02[0])
                                    self?.byteArray16_0x02_1 = String (format:"%02X",byteArray_0x02[1])
                                    self?.byteArray16_0x02_2 = String (format:"%02X",byteArray_0x02[2])
                                    self?.byteArray16_0x02_3 = String (format:"%02X",byteArray_0x02[3])
                                    
                                    self?.byteArray16_0x03_0 = String (format:"%02X",byteArray_0x03[0])
                                    self?.byteArray16_0x03_1 = String (format:"%02X",byteArray_0x03[1])
                                    self?.byteArray16_0x03_2 = String (format:"%02X",byteArray_0x03[2])
                                    self?.byteArray16_0x03_3 = String (format:"%02X",byteArray_0x03[3])
                                    
                                    self?.byteArray16_0x04_0 = String (format:"%02X",byteArray_0x04[0])
                                    self?.byteArray16_0x04_1 = String (format:"%02X",byteArray_0x04[1])
                                    self?.byteArray16_0x04_2 = String (format:"%02X",byteArray_0x04[2])
                                    self?.byteArray16_0x04_3 = String (format:"%02X",byteArray_0x04[3])
                                    
                                    self?.byteArray16_0x05_0 = String (format:"%02X",byteArray_0x05[0])
                                    self?.byteArray16_0x05_1 = String (format:"%02X",byteArray_0x05[1])
                                    self?.byteArray16_0x05_2 = String (format:"%02X",byteArray_0x05[2])
                                    self?.byteArray16_0x05_3 = String (format:"%02X",byteArray_0x05[3])
                                    
                                    self?.byteArray16_0x06_0 = String (format:"%02X",byteArray_0x06[0])
                                    self?.byteArray16_0x06_1 = String (format:"%02X",byteArray_0x06[1])
                                    self?.byteArray16_0x06_2 = String (format:"%02X",byteArray_0x06[2])
                                    self?.byteArray16_0x06_3 = String (format:"%02X",byteArray_0x06[3])
                                    
                                    self?.byteArray16_0x07_0 = String (format:"%02X",byteArray_0x07[0])
                                    self?.byteArray16_0x07_1 = String (format:"%02X",byteArray_0x07[1])
                                    self?.byteArray16_0x07_2 = String (format:"%02X",byteArray_0x07[2])
                                    self?.byteArray16_0x07_3 = String (format:"%02X",byteArray_0x07[3])
                                    
                                    self?.byteArray16_0x08_0 = String (format:"%02X",byteArray_0x08[0])
                                    self?.byteArray16_0x08_1 = String (format:"%02X",byteArray_0x08[1])
                                    self?.byteArray16_0x08_2 = String (format:"%02X",byteArray_0x08[2])
                                    self?.byteArray16_0x08_3 = String (format:"%02X",byteArray_0x08[3])
                                    
                                    self?.byteArray16_0x09_0 = String (format:"%02X",byteArray_0x09[0])
                                    self?.byteArray16_0x09_1 = String (format:"%02X",byteArray_0x09[1])
                                    self?.byteArray16_0x09_2 = String (format:"%02X",byteArray_0x09[2])
                                    self?.byteArray16_0x09_3 = String (format:"%02X",byteArray_0x09[3])
                                    
                                    self?.byteArray16_0x0a_0 = String (format:"%02X",byteArray_0x0a[0])
                                    self?.byteArray16_0x0a_1 = String (format:"%02X",byteArray_0x0a[1])
                                    self?.byteArray16_0x0a_2 = String (format:"%02X",byteArray_0x0a[2])
                                    self?.byteArray16_0x0a_3 = String (format:"%02X",byteArray_0x0a[3])
                                    
                                    
                                    // max use time
                                    self?.byteArray16_0x0b_0 = String (format:"%02X",byteArray_0x0b[0])
                                    self?.byteArray16_0x0b_1 = String (format:"%02X",byteArray_0x0b[1])
                                    self?.byteArray16_0x0b_2 = String (format:"%02X",byteArray_0x0b[2])
                                    self?.byteArray16_0x0b_3 = String (format:"%02X",byteArray_0x0b[3])
                                    
                                    let data_0x0b = Data( _ : [byteArray_0x0b[3],byteArray_0x0b[2],byteArray_0x0b[1],byteArray_0x0b[0]])
                                    
                                    self?.IntValue_0x0b_max_filter_use_time = UInt32(bigEndian: data_0x0b.withUnsafeBytes { $0.load(as: UInt32.self) })
                                    
                                    
                                    //expiry date
                                    self?.byteArray16_0x0c_0 = String (format:"%02X",byteArray_0x0c[0])
                                    self?.byteArray16_0x0c_1 = String (format:"%02X",byteArray_0x0c[1])
                                    self?.byteArray16_0x0c_2 = String (format:"%02X",byteArray_0x0c[2])
                                    self?.byteArray16_0x0c_3 = String (format:"%02X",byteArray_0x0c[3])
                                    
                                    self?.expiry_date = [Int(byteArray_0x0c[1]),Int(byteArray_0x0c[2]),Int(byteArray_0x0c[3])]
                                    
                                    
                                    
                                    
                                    self?.finish_flag.toggle()
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                        
                            session.alertMessage = "Read Success !!!"
                           
                            session.invalidate()
                            
                            
                            
                           
                     }
                        
                        
                        
                        
                        
                        
                        
                    case .miFare(let discoveredTag):
                               print("Got a  Unsupported MiFare tag!", discoveredTag.identifier, discoveredTag.mifareFamily)
                           case .feliCa(let discoveredTag):
                               print("Got a  Unsupported FeliCa tag!", discoveredTag.currentSystemCode, discoveredTag.currentIDm)
                           case .iso7816(let discoveredTag):
                               print("Got a  Unsupported ISO 7816 tag!", discoveredTag.initialSelectedAID, discoveredTag.identifier)
                           @unknown default:
                               session.invalidate(errorMessage: "Unsupported tag!")
                           }
                
                    }


    }
  
    
//    private func writeISO5693Data(resultTag: NFCISO15693Tag, session: NFCTagReaderSession) {
//
//         //command：根据业务需要自己拼接的16进制命令数组
//         //blockNumber： 写入地址
//           let writeData = UInt8(0)
//           resultTag.writeSingleBlock(requestFlags: [.highDataRate, .address],
//                                      blockNumber: 0xF8,
//                                      dataBlock: writeData) { error in
//               if error != nil {
//                   DDLogError("error==>\(String(describing: error?.localizedDescription))")
//                   session.invalidate(errorMessage: "写入失败")
//                   session.invalidate()
//                   return
//               }
//         //写入成功
//               // 获取UID
//               self.sendUID(resultTag: resultTag, session: session)
//               session.invalidate()
//           }
//           return
//       }
    

//    func iso15693Tag(s1Tag: NFCISO15693Tag, session: NFCTagReaderSession) {
//
//          //发送读取命令，读取的block 地址为0x00
//            s1Tag.readSingleBlock(requestFlags: [.highDataRate, .address],
//                                    blockNumber: 0x00) { data, error in
//
//                if error != nil {
//                    session.invalidate(errorMessage:"读取错误")
//                    session.invalidate()
//                    return
//                }
//               let outputdata = data
//                print(outputdata)
//
//                session.alertMessage = NSLocalizedString("readSuccess", comment: "")
//                session.invalidate()
//            }
//        }
    
 
}


