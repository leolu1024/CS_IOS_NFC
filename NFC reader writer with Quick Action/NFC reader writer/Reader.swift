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
    @Published var byteArray16_0 = "XX"
    @Published var byteArray16_1 = "XX"
    @Published var byteArray16_2 = "XX"
    @Published var byteArray16_3 = "XX"
    
    @Published var IntValue : UInt32 = 0
    
    
    
 
    
    
     
 
     
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
                                             delegate: self, // 实现NFCTagReaderSessionDelegate
                                             queue: nil)
        tagSession?.alertMessage = NSLocalizedString("Please hold your iphone closer to the filter", comment: "")
        tagSession?.begin()
        }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
         //check if there are more than one tag
            if tags.count > 1 {
                let retryInterval = DispatchTimeInterval.milliseconds(500)
                session.invalidate(errorMessage: NSLocalizedString("manyTagTip", comment: ""))
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
        
                session.connect(to: tag) {(error: Error?) in
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
                        tag1.readSingleBlock(requestFlags: [.highDataRate, .address],
                                             blockNumber: 0x0B) { data, error in

                         if error != nil {
                             session.invalidate(errorMessage:"Wrong")
                             session.invalidate()
                             return
                         }
                            
                            let datatobyte = [UInt8](data)
                         
                          print(datatobyte)
                            let byteArray  = datatobyte.map{$0}
                            
                            DispatchQueue.global(qos: .userInitiated).async {
                                
                                DispatchQueue.main.async { [weak self] in
                                    self?.byteArray16_0 = String (format:"%02X",byteArray[0])
                                    self?.byteArray16_1 = String (format:"%02X",byteArray[1])
                                    self?.byteArray16_2 = String (format:"%02X",byteArray[2])
                                    self?.byteArray16_3 = String (format:"%02X",byteArray[3])
                                    
                                    
                                    let data = Data( _ : [byteArray[3],byteArray[2],byteArray[1],byteArray[0]])
                                    
                                    self?.IntValue = UInt32(bigEndian: data.withUnsafeBytes { $0.load(as: UInt32.self) })
                                    
                                    session.alertMessage = "ReadSuccess  Hex: \(self!.byteArray16_0) \(self!.byteArray16_1) \(self!.byteArray16_2) \(self!.byteArray16_3)   "
                                   
                                }
                            }
                            
                            
                            
                            
                           
                            
                            
                           
                         session.invalidate()
                            
                           
                     }
                    case .miFare(let discoveredTag):
                               print("Got a MiFare tag!", discoveredTag.identifier, discoveredTag.mifareFamily)
                           case .feliCa(let discoveredTag):
                               print("Got a FeliCa tag!", discoveredTag.currentSystemCode, discoveredTag.currentIDm)
                           case .iso7816(let discoveredTag):
                               print("Got a ISO 7816 tag!", discoveredTag.initialSelectedAID, discoveredTag.identifier)
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


