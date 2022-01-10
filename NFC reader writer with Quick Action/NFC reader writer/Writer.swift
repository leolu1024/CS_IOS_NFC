//
//  Writer.swift
//  NFC reader writer
//
//  Created by XIAOTIAN WU on 29/12/21.
//

import Foundation
import CoreNFC

class NFCWriter: NSObject, NFCTagReaderSessionDelegate {
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
               
                tagSession = nil
    
    }
    
    
    
    
    
//    var maxusetime = 0
     var tagSession: NFCTagReaderSession?
    
     var maxusetimeinwriteclass : UInt32  = 0
     
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
    
    
    func callNFC( maxusetimeinCallNFCfunction:UInt32 ) {
        
        maxusetimeinwriteclass = maxusetimeinCallNFCfunction
        
        
          // check is this phone can read NFC
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
         //判断标签个数是否为多个
            if tags.count > 1 {
                let retryInterval = DispatchTimeInterval.milliseconds(500)
                session.invalidate(errorMessage: NSLocalizedString("Too many tags", comment: ""))
                DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                    session.restartPolling()
                }
                return
            }

//         //check if it is ISO 15693
//            guard case let NFCTag.iso15693(_) = tags.first! else {
//                return
//            }
        
        let tag = tags.first!
        
        session.connect(to: tag) { [self](error: Error?) in
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
                        print(self.maxusetimeinwriteclass)
                        
                      
                        let writedata = withUnsafeBytes(of: self.maxusetimeinwriteclass){Data ($0)}
                        
                        
                        // let writeData = command.map { UInt8($0) }
                             tag1.writeSingleBlock(requestFlags: [.highDataRate, .address],
                                                        blockNumber: 0x0B,
                                                   dataBlock: Data(writedata)) { error in
                                 if error != nil {
                                     
                                     session.invalidate(errorMessage: "Fail to Write")
                                     session.invalidate()
                                     return
                                 }
                                 
                                 print("good")
                                 session.alertMessage = "Data write to filter successful!!!"
                                 
                                 session.invalidate()
                                 return
                                 
                           
                                 
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
//         //command
//         //blockNumber： address
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

