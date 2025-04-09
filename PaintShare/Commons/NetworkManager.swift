//
//  NetworkManager.swift
//  PaintShare
//
//  Created by Lee on 2022/7/22.
//

import SwiftUI

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    private override init() {}
    
    @available(iOS 15.0, *)
    
    func uploadpictureFile (
        
        pictureFileURL: URL) async throws -> (Data, URLResponse) {
            
            let name:     String = pictureFileURL.deletingPathExtension().lastPathComponent
            
            let fileName: String = pictureFileURL.lastPathComponent
            
            let pictureFileData: Data?
            
            do {
                pictureFileData = try Data(contentsOf: pictureFileURL)
            } catch {
                throw error
            }
            
            let uploadApiUrl: URL? = URL(string: "https://someapi.com/upload")
            
            let uniqueBoundary = UUID().uuidString
            
            var bodyData = Data()
            
            bodyData.append("\r\n--\(uniqueBoundary)\r\n".data(using: .utf8)!)
            
            bodyData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            
            bodyData.append("Content-Type: application/picture\r\n\r\n".data(using: .utf8)!)
            
            bodyData.append(pictureFileData!)
            
            bodyData.append("\r\n--\(uniqueBoundary)--\r\n".data(using: .utf8)!)
            
            let urlSessionConfiguration = URLSessionConfiguration.default
            
            let urlSession = URLSession(
                configuration: urlSessionConfiguration,
                delegate: self,
                delegateQueue: nil)
            
            var urlRequest = URLRequest(url: uploadApiUrl!)
            
            urlRequest.setValue("multipart/form-data; boundary=\(uniqueBoundary)", forHTTPHeaderField: "Content-Type")
            
            urlRequest.httpMethod = "POST"
            
            let (data, urlResponse) = try await urlSession.upload(
                for: urlRequest,
                from: bodyData,
                delegate: nil
            )
            
            return (data, urlResponse)
        }
}

extension NetworkManager: URLSessionTaskDelegate {
    
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64) {
            debugPrintLog(message:"fractionCompleted  : \(Int(Float(totalBytesSent) / Float(totalBytesExpectedToSend) * 100))")
        }
}
