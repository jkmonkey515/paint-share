//
//  AppBadgeNumber.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/10/17.
//

import SwiftUI

class AppBadgeNumber{
    public static func getUnreadMessageCounts(){
        if UrlUtils.loginToken != nil {
            guard let request = UrlUtils.makeGetRequest(url: UrlConstants.CHATROOM_MESSAGE_GET_UNREAD_COUNT) else {
                return
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        debugPrintLog(message:"get unread message counts")
                        if let data = data {
                            if let decodedResponse = try? JSONDecoder().decode(MenuNoticeResponse.self, from: data) {
                                DispatchQueue.main.async {
                                    UIApplication.shared.applicationIconBadgeNumber = decodedResponse.unReadCount ?? 0
                                }
                            }
                        }
                        
                    }
                }
            }.resume()
        }
    }
}


