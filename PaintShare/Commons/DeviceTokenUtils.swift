//
//  DeviceTokenUtils.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/1/21.
//

import SwiftUI

class DeviceTokenUtils {
    
    static var deviceToken: String? = nil

    static func saveDeviceToken() {
        if UrlUtils.loginToken != nil && deviceToken != nil {
            guard let request = UrlUtils.makePostRequest(url: UrlConstants.DEVICE_TOKEN_SAVE, body: DeviceTokenBody(token: deviceToken!)) else {
                return
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        debugPrintLog(message:"device token saved")
                    }
                }
            }.resume()
        }
    }
    
    static func deleteDeviceToken() {
        if UrlUtils.loginToken != nil && deviceToken != nil {
            guard let request = UrlUtils.makePostRequest(url: UrlConstants.DEVICE_TOKEN_DELETE, body: DeviceTokenBody(token: deviceToken!)) else {
                return
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            debugPrintLog(message:"device token deleted")
                            UIApplication.shared.applicationIconBadgeNumber = 0
                        }
                    }
                }
            }.resume()
        }
    }
}
