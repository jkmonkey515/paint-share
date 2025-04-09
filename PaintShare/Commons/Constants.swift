//
//  Constants.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/9/21.
//

import SwiftUI

class Constants {
    
    public static let ERR_MSG_NET = "インターネット環境をご確認の上再度お試しください"
    
    public static let ERR_MSG_500 = "システムエラーが発生しました。お時間をおいて再度お試しください"
    
    public static let ERR_MSG_597 = "アカウント停止中のためログインできません。"
    
    public static let ERR_MSG_CLOSE = "オーナーがこの機能をオフにしました。"
    
    public static let ERR_MSG_EMPTY = "インターフェースのデータが空で返されました。"
    
    public static let ERR_MSG_NONE = "お探ししましたが 該当する塗料が見つかりませんでした"
    
    public static let ERR_MSG_NETWORK = "ネットワーク環境を確認し再度お試しください"
    
    public static let ERR_MSG_NETWORK_TIMEOUT = "タイムアウトしました。ネットワーク環境を確認し再度お試しください"
    
    public static let REQUIRED_MESSAGE = "必須入力項目です"
    
    public static let WRONG_LOGIN_MESSAGE = "ログインIDまたはパスワードの入力が誤っています"
    
    public static let WRONG_LINE_LOGIN_MESSAGE = "Lineログインできません"
    
    public static let WRONG_APPLE_LOGIN_MESSAGE = "Appleログインできません"
    
    public static let INPUT_ERROR_ALERT_MESSAGE = "入力内容に不備があります\n確認の上、再入力をお願いします"
    
    public static let IS_NOT_FIRST_TIME_KEY = "firstTimeKey"
    
    public static let IS_NOT_SKIP_PRECAUTIONS = "skipPrecautions"
    
    public static let LOGGIN_TOKEN_KEY = "logginToken"
    
    public static let CENTER_LAT = "CenterLat"
    
    public static let CENTER_LNG = "CenterLng"
    
    public static let imageHolderUIImage = UIImage(named: "no_image_holder")
    
    public static let profileHolderUIImage = UIImage(named: "thumbnail_profile")
    
    public static let tab1Image = UIImage(named: "people")!.resize(height: 25)
    
    public static let tab2Image = UIImage(named: "magnifiying-glass")!.resize(height: 25)
    
    public static let tab3Image = UIImage(named: "paint-bucket")!.resize(height: 25)
    
    public static let tab4Image = UIImage(named: "account")!.resize(height: 25)
    
    public static let tab5Image = UIImage(named: "tabbar-camera-1")!.resize(height: 60)
    
    public static let tab6Image = UIImage(named: "tabbar-camera-2")!.resize(height: 60)
    
    public static let IMG_DEL_SUBJECT_ACC = "ACCOUNT"
    
    public static let IMG_DEL_SUBJECT_GRP = "GROUP"
    
    public static let IMG_DEL_SUBJECT_PAINT_NEW = "PAINT_NEW"
    
    public static let IMG_DEL_SUBJECT_PAINT_EDIT = "PAINT_EDIT"
    
    
    public static let statusInGroupDisplayNameMap: [Int:String] = [
        0 : "メンバー申請中",
        1 : "メンバー",
        2 : "フレンド申請中",
        3 : "フレンド",
        4 : "メンバー申請中"
    ]
    
    public static func getStatusInGroupDisplayName(status: Int?) -> String? {
        if status == nil {
            return nil
        } else {
            return statusInGroupDisplayNameMap[status!]
        }
    }
    
    public static let waitListStatusInGroupDisplayNameMap: [Int:String] = [
        0 : "メンバー申請",
        2 : "フレンド申請",
        4 : "メンバー申請"
    ]
    
    public static func showTheComma(source: String, gap: Int=3, seperator: Character=",") -> String {
        let result = source.filter{$0 != ","}
        if result.isInt{
            let number = Int(result) ?? 0
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let numberText = numberFormatter.string(from: NSNumber(value: number))
            let numberStr = String(numberText!)
            return numberStr
        }else{
            return source
        }
    }
    
    public static func inputTwoCount(source: String, seperator: Character=",") -> String {
        if source.count <= 2{
            return source
        }else{
            return String(source[source.startIndex..<source.index(source.startIndex,offsetBy: 2)])
        }
    }
    
    
    public static func showTheSpace(source: String, gap: Int=4, seperator: Character=" ") -> String {
        if source.count<20{
            var result = source.filter{$0 != " "}
            let count = result.count
            let sepNum = count / gap > 3 ? 3:count/gap
            guard sepNum >= 1 else {
                return result
            }
            for i in 1...sepNum {
                var index = gap * i
                if i != 1{
                    index = index + i - 1
                }
                guard index != 0 else {
                    break
                }
                result.insert(seperator, at: result.index(result.startIndex, offsetBy: index))
            }
            if result.last == " " {
                result = String(result.dropLast())
            }
            return result
        }else{
            return String(source[source.startIndex..<source.index(source.startIndex,offsetBy: 19)])
        }
    }
}
