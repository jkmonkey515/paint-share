//
//  UrlUtils.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/27/21.
//

import SwiftUI
import Promises
import RevenueCat

import SystemConfiguration

class UrlUtils {
    
    
    static var loginToken: String? = nil
        
    static func logout() {
        DeviceTokenUtils.deleteDeviceToken()
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.LOGGIN_TOKEN_KEY)
        loginToken = nil
    }
    
    static func getData(urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func makePostRequest<T:Encodable> (url: String, body: T) -> URLRequest? {
        debugPrintLog(message:"request sent: \(url)")
        guard let url = URL(string: url) else {
            debugPrintLog(message:"Invalid URL")
            return nil
        }
        guard let encoded = try? JSONEncoder().encode(body) else {
            debugPrintLog(message:"Failed to encode order")
            return nil
        }
        var request = URLRequest(url: url)
        if loginToken != nil {
            request.addValue(loginToken!, forHTTPHeaderField: "JWT-AUTH")
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        return request
    }
    
    static func makeGetRequest(url: String) -> URLRequest? {
        debugPrintLog(message:"request sent: \(url)")
        guard let url = URL(string: url) else {
            debugPrintLog(message:"Invalid URL")
            return nil
        }
        var request = URLRequest(url: url)
        if loginToken != nil {
            request.addValue(loginToken!, forHTTPHeaderField: "JWT-AUTH")
        }
        debugPrintLog(message:"------------------------------------------ " )
        debugPrintLog(message: loginToken)
        return request
    }
    
    static func postRequest<T:Encodable, Y:Decodable> (url: String, body: T, type: Y.Type, dialogsDataModel: DialogsDataModel) -> Promise<Y?> {
        let promise = Promise<Y?> {
            fullfill, reject in
            if !isNetworkReachable() {
                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK
                dialogsDataModel.showErrorDialog = true
                reject(CustomError(description: "poor network", code: -2))
                return
            }
            
            if UrlConstants.isLoginNeeded(url: url) && loginToken == nil {
                dialogsDataModel.loginNavigationTag = nil
                reject(CustomError(description: "not logged in", code: 401))
                return
            }
            guard let request = UrlUtils.makePostRequest(
                url: url,
                body: body) else {
                    reject(CustomError(description: "invalid url", code: -1))
                    return
                }
            
            dialogsDataModel.showLoading = true
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    dialogsDataModel.showLoading = false
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let decodedResponse = try? JSONDecoder().decode(type, from: data!) {
                            fullfill(decodedResponse)
                            return
                        } else {
                            debugPrintLog(message:"type not matched or nil")
                            fullfill(nil)
                            return
                        }
                    } else if httpResponse.statusCode == 400 {
                        if let decoded = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: String] {
                            let validationError = ValidationError(errors: decoded)
                            DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.INPUT_ERROR_ALERT_MESSAGE
                            dialogsDataModel.showErrorDialog = true
                            }
                            reject(validationError)
                            return
                        }
                    } else if httpResponse.statusCode == 403 {
                        DispatchQueue.main.async {
                            dialogsDataModel.showPaymentDialog = true
                        }
                        reject(CustomError(description: "Free Ended", code: 403))
                        return
                    } else if httpResponse.statusCode == 404 {
                        debugPrintLog(message:"request not allowed, role check failed")
                        reject(CustomError(description: "Free Ended", code: 404))
                        return
                    } else if httpResponse.statusCode == 401 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "invalid login", code: 401))
                        return
                    } else if httpResponse.statusCode == 500 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_500
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: "internal", code: 500))
                        return
                    } else if httpResponse.statusCode == 597 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_597
                            dialogsDataModel.showErrorDialog = true
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "disabled user", code: 597))
                        return
                    } else if httpResponse.statusCode == 596 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = String(data: data!, encoding: .utf8)!
                            dialogsDataModel.showErrorDialog = true
                            return
                        }
                        reject(CustomError(description: String(data: data!, encoding: .utf8)!, code: 596))
                        return
                    } else if httpResponse.statusCode == 595 {
                        DispatchQueue.main.async {
                            dialogsDataModel.showChargeView = true
                            return
                        }
                        reject(CustomError(description: "Free Ended", code: 595))
                        return
                    }
                    if let decodedMsg = try? JSONDecoder().decode(ErrorMsg.self, from: data!) {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = decodedMsg.message
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: decodedMsg.message, code: httpResponse.statusCode))
                        return
                    }
                }
                if (error != nil) {
                    DispatchQueue.main.async {
                        dialogsDataModel.errorMsg = error!.localizedDescription
                        if let error = error as NSError? {
                            if error.code == NSURLErrorTimedOut {
                                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK_TIMEOUT
                            }
                        }
                        dialogsDataModel.showErrorDialog = true
                    }
                    reject(error!)
                } else {
                    debugPrintLog(message:"Unexpected")
                    reject(CustomError(description: "Unexpected", code: -1))
                }
            }.resume()
        }
        return promise
    }
    
    static func postRequest<T:Encodable> (url: String, body: T, dialogsDataModel: DialogsDataModel) -> Promise<Void> {
        let promise = Promise<Void> {
            fullfill, reject in
            if !isNetworkReachable() {
                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK
                dialogsDataModel.showErrorDialog = true
                reject(CustomError(description: "poor network", code: -2))
                return
            }
            if UrlConstants.isLoginNeeded(url: url) && loginToken == nil {
                dialogsDataModel.loginNavigationTag = nil
                reject(CustomError(description: "not logged in", code: 401))
                return
            }
            guard let request = UrlUtils.makePostRequest(
                url: url,
                body: body) else {
                    reject(CustomError(description: "invalid url", code: -1))
                    return
                }
            dialogsDataModel.showLoading = true
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    dialogsDataModel.showLoading = false
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        fullfill(())
                        return
                    } else if httpResponse.statusCode == 400 {
                        if let decoded = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: String] {
                            let validationError = ValidationError(errors: decoded)
                            DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.INPUT_ERROR_ALERT_MESSAGE
                            dialogsDataModel.showErrorDialog = true
                            }
                            reject(validationError)
                            return
                        }
                    } else if httpResponse.statusCode == 403 {
                        DispatchQueue.main.async {
                            dialogsDataModel.showPaymentDialog = true
                        }
                        reject(CustomError(description: "Free Ended", code: 403))
                        return
                    } else if httpResponse.statusCode == 404 {
                        debugPrintLog(message:"request not allowed, role check failed")
                        reject(CustomError(description: "Free Ended", code: 404))
                        return
                    } else if httpResponse.statusCode == 401 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "invalid login", code: 401))
                        return
                    } else if httpResponse.statusCode == 500 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_500
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: "internal", code: 500))
                        return
                    } else if httpResponse.statusCode == 597 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_597
                            dialogsDataModel.showErrorDialog = true
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "disabled user", code: 597))
                        return
                    } else if httpResponse.statusCode == 596 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = String(data: data!, encoding: .utf8)!
                            dialogsDataModel.showErrorDialog = true
                            return
                        }
                        reject(CustomError(description: String(data: data!, encoding: .utf8)!, code: 596))
                        return
                    } else if httpResponse.statusCode == 595 {
                        DispatchQueue.main.async {
                            dialogsDataModel.showChargeView = true
                            return
                        }
                        reject(CustomError(description: "Free Ended", code: 595))
                        return
                    }
                    if let decodedMsg = try? JSONDecoder().decode(ErrorMsg.self, from: data!) {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = decodedMsg.message
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: decodedMsg.message, code: httpResponse.statusCode))
                    }
                }
                if (error != nil) {
                    DispatchQueue.main.async {
                        dialogsDataModel.errorMsg = error!.localizedDescription
                        if let error = error as NSError? {
                            if error.code == NSURLErrorTimedOut {
                                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK_TIMEOUT
                            }
                        }
                        dialogsDataModel.showErrorDialog = true
                    }
                    reject(error!)
                } else {
                    debugPrintLog(message:"Unexpected")
                    reject(CustomError(description: "Unexpected", code: -1))
                }
            }.resume()
        }
        return promise
    }
    
    static func getRequest<Y:Decodable> (url: String, type: Y.Type, dialogsDataModel: DialogsDataModel) -> Promise<Y?> {
        let promise = Promise<Y?> {
            fullfill, reject in
            if !isNetworkReachable() {
                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK
                dialogsDataModel.showErrorDialog = true
                reject(CustomError(description: "poor network", code: -2))
                return
            }
            if UrlConstants.isLoginNeeded(url: url) && loginToken == nil {
                dialogsDataModel.loginNavigationTag = nil
                debugPrintLog(message:"not logged in")
                reject(CustomError(description: "not logged in", code: 401))
                return
            }
            guard let request = UrlUtils.makeGetRequest(
                url: url) else {
                    reject(CustomError(description: "invalid url", code: -1))
                    return
                }
            dialogsDataModel.showLoading = true
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    dialogsDataModel.showLoading = false
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let decodedResponse = try? JSONDecoder().decode(type, from: data!) {
                            fullfill(decodedResponse)
                            return
                        } else {
                            debugPrintLog(message:"type not matched or nil")
                            fullfill(nil)
                            return
                        }
                    } else if httpResponse.statusCode == 403 {
                        DispatchQueue.main.async {
                            dialogsDataModel.showPaymentDialog = true
                        }
                        reject(CustomError(description: "Free Ended", code: 403))
                        return
                    } else if httpResponse.statusCode == 404 {
                        debugPrintLog(message:"request not allowed, role check failed")
                        reject(CustomError(description: "Free Ended", code: 404))
                        return
                    } else if httpResponse.statusCode == 401 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "invalid login", code: 401))
                        return
                    } else if httpResponse.statusCode == 500 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_500
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: "internal", code: 500))
                        return
                    } else if httpResponse.statusCode == 597 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_597
                            dialogsDataModel.showErrorDialog = true
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "disabled user", code: 597))
                        return
                    } else if httpResponse.statusCode == 596 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = String(data: data!, encoding: .utf8)!
                            dialogsDataModel.showErrorDialog = true
                            return
                        }
                        reject(CustomError(description: String(data: data!, encoding: .utf8)!, code: 596))
                        return
                    } else if httpResponse.statusCode == 595 {
                        DispatchQueue.main.async {
                            dialogsDataModel.showChargeView = true
                            return
                        }
                        reject(CustomError(description: "Free Ended", code: 595))
                        return
                    }
                    if let decodedMsg = try? JSONDecoder().decode(ErrorMsg.self, from: data!) {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = decodedMsg.message
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: decodedMsg.message, code: httpResponse.statusCode))
                    }
                }
                if (error != nil) {
                    DispatchQueue.main.async {
                        dialogsDataModel.errorMsg = error!.localizedDescription
                        if let error = error as NSError? {
                            if error.code == NSURLErrorTimedOut {
                                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK_TIMEOUT
                            }
                        }
                        dialogsDataModel.showErrorDialog = true
                    }
                    reject(error!)
                } else {
                    debugPrintLog(message:"Unexpected")
                    reject(CustomError(description: "Unexpected", code: -1))
                }
            }.resume()
        }
        return promise
    }
    
    static func imgUploadRequest(request: MultipartFormDataRequest, dialogsDataModel: DialogsDataModel) -> Promise<String> {
        let promise = Promise<String> {
            fullfill, reject in
            if !isNetworkReachable() {
                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK
                dialogsDataModel.showErrorDialog = true
                reject(CustomError(description: "poor network", code: -2))
                return
            }
            
            dialogsDataModel.showLoading = true
            URLSession.shared.dataTask(with: request.asURLRequest()) { data, response, error in
                DispatchQueue.main.async {
                    dialogsDataModel.showLoading = false
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let dataString = String(data:data!,encoding:.utf8)!
                        fullfill(dataString)
                    } else if httpResponse.statusCode == 400 {
                        if let decoded = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: String] {
                            let validationError = ValidationError(errors: decoded)
                            DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.INPUT_ERROR_ALERT_MESSAGE
                            dialogsDataModel.showErrorDialog = true
                            }
                            reject(validationError)
                            return
                        }
                    } else if httpResponse.statusCode == 401 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "invalid login", code: 401))
                        return
                    } else if httpResponse.statusCode == 500 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_500
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: "internal", code: 500))
                        return
                    } else if httpResponse.statusCode == 597 {
                        UrlUtils.logout()
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = Constants.ERR_MSG_597
                            dialogsDataModel.showErrorDialog = true
                            dialogsDataModel.loginNavigationTag = nil
                        }
                        reject(CustomError(description: "disabled user", code: 597))
                        return
                    } else if httpResponse.statusCode == 596 {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = String(data: data!, encoding: .utf8)!
                            dialogsDataModel.showErrorDialog = true
                            return
                        }
                        reject(CustomError(description: String(data: data!, encoding: .utf8)!, code: 596))
                        return
                    } else if httpResponse.statusCode == 595 {
                        DispatchQueue.main.async {
                            dialogsDataModel.showChargeView = true
                            return
                        }
                        reject(CustomError(description: "Free Ended", code: 595))
                        return
                    }
                    if let decodedMsg = try? JSONDecoder().decode(ErrorMsg.self, from: data!) {
                        DispatchQueue.main.async {
                            dialogsDataModel.errorMsg = decodedMsg.message
                            dialogsDataModel.showErrorDialog = true
                        }
                        reject(CustomError(description: decodedMsg.message, code: httpResponse.statusCode))
                        return
                    }
                }
                if (error != nil) {
                    DispatchQueue.main.async {
                        dialogsDataModel.errorMsg = error!.localizedDescription
                        if let error = error as NSError? {
                            if error.code == NSURLErrorTimedOut {
                                dialogsDataModel.errorMsg = Constants.ERR_MSG_NETWORK_TIMEOUT
                            }
                        }
                        dialogsDataModel.showErrorDialog = true
                    }
                    reject(error!)
                } else {
                    debugPrintLog(message:"Unexpected")
                    reject(CustomError(description: "Unexpected", code: -1))
                }
            }.resume()
        }
        return promise
    }
    
    static func isNetworkReachable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection
    }
}
