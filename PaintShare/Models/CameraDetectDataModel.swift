//
//  CameraDetectDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/5/25.
//

import SwiftUI

class CameraDetectDataModel: ObservableObject {
    
    @Published var showCameraNoti: Bool = false
    
    @Published var navigationTag: Int? = nil
    
    @Published var changeQueue: Int = 0 
    
    @Published var profilePicture: UIImage? = Constants.imageHolderUIImage!
    
    @Published var shouldPresentActionScheet = false
    
    @Published var makerDtos = []
    
    @Published var nameDtos = []
    
    @Published var useDtos = []
    
    @Published var colorDtos = []
    
    @Published var makerListItems = []
    
    @Published var nameListItems = []
    
    @Published var useListItems = []
    
    @Published var colorListItems = []
    
    @Published var useCategories = []

    @Published var cameraListItems: [CameraListItem] = []
    
    @Published var checked: Bool = false
    
    @Published var shut: Bool = false
    
    func reset(){
        profilePicture = Constants.imageHolderUIImage!
        
        self.makerListItems.removeAll()
        self.useListItems.removeAll()
        self.colorListItems.removeAll()
        self.nameListItems.removeAll()
        self.makerDtos.removeAll()
        self.useDtos.removeAll()
        self.colorDtos.removeAll()
        self.nameDtos.removeAll()
        
        self.cameraListItems.removeAll()
    }
    
    func getListData(id: Int, type: Int, dialogsDataModel: DialogsDataModel){
        let imgData = self.profilePicture!.jpegData(compressionQuality: 0.6)!
        if type == 1{
            self.uploadImageToCreate(id: id, imageData: imgData, dialogsDataModel: dialogsDataModel)
        }else{
            self.uploadImageToSearch(id: id, imageData: imgData, dialogsDataModel: dialogsDataModel)
        }
    }
    
    func uploadImageToCreate(id: Int, imageData: Data, dialogsDataModel: DialogsDataModel) {
        self.shut = true
        var request = MultipartFormDataRequest(url: URL(string: UrlConstants.IMAGE_NEW_IMAGEUPLOAD)!)
        request.addDataFieldAndGroupId(named: "file", data: imageData, mimeType: "image/jpeg", id: id)
        
        dialogsDataModel.showLoading = true
        URLSession.shared.dataTask(with: request.asURLRequest()) { data, response, error in
            debugPrintLog(message:UrlConstants.IMAGE_NEW_IMAGEUPLOAD)
            DispatchQueue.main.async {
                dialogsDataModel.showLoading = false
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(PictureResponse.self, from: data) {
                            DispatchQueue.main.async {
                                debugPrintLog(message:"uploadImageToCreate")
                                self.makerListItems.removeAll()
                                self.useListItems.removeAll()
                                self.colorListItems.removeAll()
                                self.nameListItems.removeAll()
                                self.makerDtos.removeAll()
                                self.useDtos.removeAll()
                                self.colorDtos.removeAll()
                                self.nameDtos.removeAll()
                                decodedResponse.makers.forEach { cameraMakersDto in
                                    self.makerListItems.append(cameraMakersDto.name)
                                    self.makerDtos.append(cameraMakersDto)
                                }
                                decodedResponse.useCategories.forEach { cameraUseCategoriesDto in
                                    self.useListItems.append(cameraUseCategoriesDto.name)
                                    self.useDtos.append(cameraUseCategoriesDto)
                                }
                                decodedResponse.colors.forEach { cameraColorsDto in
                                    self.colorListItems.append(cameraColorsDto.colorNumber + "(\(cameraColorsDto.maker.name))")
                                    self.colorDtos.append(cameraColorsDto)
                                }
                                decodedResponse.goodsNames.forEach { cameraGoodsNamesDto in
                                    self.nameListItems.append(cameraGoodsNamesDto.goodsName.name + "(\(cameraGoodsNamesDto.goodsName.maker.name))")
                                    self.nameDtos.append(cameraGoodsNamesDto)
                                }
                                self.changeQueue = 3
                                self.shut = false
                                if self.makerListItems.count == 0 && self.useListItems.count == 0 && self.colorListItems.count == 0 && self.nameListItems.count == 0 {
                                    self.changeQueue = 5
                                    dialogsDataModel.errorMsg = Constants.ERR_MSG_NONE
                                    dialogsDataModel.showErrorDialog = true
                                }
                            }
                            return
                        }else{
                            DispatchQueue.main.async {
                                self.shut = false
                                self.changeQueue = 5
                                dialogsDataModel.errorMsg = data.isEmpty ? Constants.ERR_MSG_EMPTY : Constants.ERR_MSG_NONE
                                dialogsDataModel.showErrorDialog = true
                            }
                        }
                    }
                }else if (httpResponse.statusCode == 598){
                    DispatchQueue.main.async {
                        self.shut = false
                        self.changeQueue = 5
                        dialogsDataModel.errorMsg = Constants.ERR_MSG_CLOSE
                        dialogsDataModel.showErrorDialog = true
                    }
                }else{
                    DispatchQueue.main.async {
                        self.shut = false
                        self.changeQueue = 5
                        dialogsDataModel.errorMsg = Constants.ERR_MSG_500
                        dialogsDataModel.showErrorDialog = true
                    }
                    return
                }
            }
            if (error != nil) {
                DispatchQueue.main.async {
                    self.shut = false
                    self.changeQueue = 5
                    dialogsDataModel.errorMsg = error!.localizedDescription
                    dialogsDataModel.showErrorDialog = true
                }
            } else {
                debugPrintLog(message:"Unexpected")
            }
        }.resume()
    }
    func uploadImageToSearch(id: Int, imageData: Data, dialogsDataModel: DialogsDataModel) {
        self.shut = true
        var request = MultipartFormDataRequest(url: URL(string: UrlConstants.IMAGE_SEARCH_IMAGEUPLOAD)!)
        request.addDataFieldAndGroupId(named: "file", data: imageData, mimeType: "image/jpeg", id: id)
        
        dialogsDataModel.showLoading = true
        URLSession.shared.dataTask(with: request.asURLRequest()) { data, response, error in
            debugPrintLog(message:UrlConstants.IMAGE_NEW_IMAGEUPLOAD)
            DispatchQueue.main.async {
                dialogsDataModel.showLoading = false
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(InventorySearchPage.self, from: data) {
                            DispatchQueue.main.async {
                                debugPrintLog(message:"searchImageToCreate")
                                self.cameraListItems.removeAll()
                                decodedResponse.content.forEach {
                                    inventorySearchItem in
                                    self.cameraListItems.append(CameraListItem(id:inventorySearchItem.id, groupName: inventorySearchItem.ownedBy.groupName, goodsNameName: inventorySearchItem.goodsNameName, color: inventorySearchItem.colorNumber?.colorCode ?? "000000"))
                                }
                                self.changeQueue = 4
                                self.shut = false
                                if self.cameraListItems.count == 0 {
                                    self.changeQueue = 5
                                    dialogsDataModel.errorMsg = Constants.ERR_MSG_NONE
                                    dialogsDataModel.showErrorDialog = true
                                }
                            }
                            return
                        }else{
                            self.shut = false
                            self.changeQueue = 5
                            dialogsDataModel.errorMsg = data.isEmpty ? Constants.ERR_MSG_EMPTY : Constants.ERR_MSG_NONE
                            dialogsDataModel.showErrorDialog = true
                        }
                    }
                }else if (httpResponse.statusCode == 598){
                    DispatchQueue.main.async {
                        self.shut = false
                        self.changeQueue = 5
                        dialogsDataModel.errorMsg = Constants.ERR_MSG_CLOSE
                        dialogsDataModel.showErrorDialog = true
                    }
                }else{
                    DispatchQueue.main.async {
                        self.shut = false
                        self.changeQueue = 5
                        dialogsDataModel.errorMsg = Constants.ERR_MSG_500
                        dialogsDataModel.showErrorDialog = true
                    }
                    return
                }
            }
            if (error != nil) {
                DispatchQueue.main.async {
                    self.shut = false
                    self.changeQueue = 5
                    dialogsDataModel.errorMsg = error!.localizedDescription
                    dialogsDataModel.showErrorDialog = true
                }
            } else {
                debugPrintLog(message:"Unexpected")
            }
        }.resume()
    }
}

struct MultipartFormDataRequest {
    private let uniqueId = UUID().uuidString
    private let boundary: String = UUID().uuidString
    private var cameraGroupId: Int = 0
    private var httpBody = NSMutableData()
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }
    
    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    mutating func addDataFieldAndGroupId(named name: String, data: Data, mimeType: String, id: Int) {
        self.cameraGroupId = id
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }
    
    func addDataField(named name: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }
    
    private func dataFormField(named name: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()
        
        //let imgBase64 = data.base64EncodedString(options: .lineLength64Characters)
        
        fieldData.append("--\(boundary)\r\n".data(using: .utf8)!)
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(uniqueId).jpg\"\r\n".data(using: .utf8)!)
        fieldData.append("Content-Type: \(mimeType)\r\n".data(using: .utf8)!)
        fieldData.append("\r\n".data(using: .utf8)!)
        fieldData.append(data)
        fieldData.append("\r\n".data(using: .utf8)!)
        
        let nameString = "jsonBody"
        let groupDic : [String: Any] = ["groupId":"\(self.cameraGroupId)"]
        if let jsonData = try? JSONSerialization.data(withJSONObject: groupDic, options: .prettyPrinted) {
            if let jsonString = String(data: jsonData, encoding: .ascii) {
                fieldData.append("--\(boundary)\r\n".data(using: .utf8)!)
                fieldData.append("Content-Disposition: form-data; name=\"\(nameString)\";\r\n\r\n".data(using: .utf8)!)
                fieldData.append(jsonString.data(using: .utf8)!)
                fieldData.append("\r\n".data(using: .utf8)!)
            }
        }
        
        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: Constants.LOGGIN_TOKEN_KEY)
        request.setValue(token!, forHTTPHeaderField: "JWT-AUTH")
        
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
}


extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

extension URLSession {
    func dataTask(with request: MultipartFormDataRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}
