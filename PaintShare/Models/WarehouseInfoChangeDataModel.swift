//
//  WarehouseInfoChangeDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/03.
//

import SwiftUI

class WarehouseInfoChangeDataModel:ObservableObject{
    
    @Published var navigationTag: Int? = nil
    
    var id: Int? = nil
    
    @Published var warehouseName: String = ""{
        didSet {
            warehouseNameMessage = ""
        }
    }
    
    @Published var warehouseNameMessage: String = ""
    
    @Published var zipcode: String = ""{
        didSet {
            zipcodeMessage = ""
        }
    }
    
    @Published var zipcodeMessage: String = ""
    
    @Published var municipalitieName: String = ""{
        didSet {
            municipalitieNameMessage = ""
        }
    }
    
    @Published var municipalitieNameMessage: String = ""
    
    @Published var addressName: String = ""{
        didSet {
            addressNameMessage = ""
        }
    }
    
    @Published var addressNameMessage: String = ""
    
    //picker 都道府県
    @Published var prefs: [PickItem] = []
    
    @Published var showPrefPick: Bool = false
    
    @Published var addBottom: Bool = false
    
    @Published var prefKey = -1
    
    @Published var prefValue: String = ""
    
    //0:倉庫登録 1:倉庫編集
    @Published var mode:Int=0
    
    //    init(){
    //        prefs.append(PickItem(key: 0, value: "北海道"))
    //        prefs.append(PickItem(key: 1, value: "東京都"))
    //        prefs.append(PickItem(key: 2, value: "千葉県"))
    //        }
    
    func setPrefValue(){
        let pref=prefs.first(where: {$0.key == prefKey})
        prefValue=pref?.value ?? ""
    }
    
    func reset() {
        //  selectedWarehouseMenuTab = 0//
        id = nil
        warehouseName=""
        warehouseNameMessage=""
        zipcode=""
        zipcodeMessage=""
        municipalitieName=""
        municipalitieNameMessage = ""
        addressName=""
        addressNameMessage = ""
        prefKey = -1
        prefValue = ""
        mode = 0
    }
    
    
    func initData(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_LOCATION_DATA, type: [AreaCategory].self, dialogsDataModel: dialogsDataModel)
            .then{
                areaCategoryResult in
                DispatchQueue.main.async {
                    self.prefs=[]
                    self.prefs.append(PickItem(key: -1, value: ""))
                    for area in areaCategoryResult ?? []{
                        for pref in area.prefectures ?? []{
                            self.prefs.append(PickItem(key: pref.code, value:pref.name))
                        }
                        
                    }
                }
            }
    }
    
    
    func saveWarehouse( dialogsDataModel: DialogsDataModel, warehouseDataModel: WarehouseDataModel){
        
        let body=WarehouseBody(id: id, name: warehouseName, zipcode: zipcode, prefecture: prefValue, city: municipalitieName, address: addressName)
        UrlUtils.postRequest(url: UrlConstants.WAREHOUSE_SAVE, body: body, dialogsDataModel: dialogsDataModel)
            .then{
                dialogsDataModel.showSavedDialog = true
                warehouseDataModel.navigationTag = nil
            }.catch{
                error in
                if let validationError = error as? ValidationError{
                    if let warehouseNameError = validationError.errors["name"] {
                        self.warehouseNameMessage = warehouseNameError
                    }
                    if let zipcodeError = validationError.errors["zipcode"]{
                        self.zipcodeMessage = zipcodeError
                    }
                    //municipalitieNameMessage
                    if let cityError = validationError.errors["city"]{
                        self.municipalitieNameMessage = cityError
                    }
                    //addressNameMessage
                    if let addressError = validationError.errors["address"]{
                        self.addressNameMessage = addressError
                    }
                }
            }
    }
    
    
    func setWarehouseInfo(id:Int,dialogsDataModel: DialogsDataModel){
        mode=1
        self.id=id
        UrlUtils.getRequest(url: UrlConstants.WAREHOUSE+"/\(id)", type: WarehouseDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                warehouseDto in
                DispatchQueue.main.async {
                    self.id = warehouseDto!.id
                    self.warehouseName = warehouseDto!.name
                    self.zipcode = warehouseDto!.zipcode
                    self.prefValue = warehouseDto!.prefecture
                    self.municipalitieName = warehouseDto!.city
                    self.addressName = warehouseDto!.address
                }
            }
    }
    
    func getAddressByCoordinate(lat: Double, lng: Double, dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_ADDRESS_BY_COORDINATE+"?lat=\(lat)&lng=\(lng)", type: GeocodingAddressDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                response in
                DispatchQueue.main.async {
                    self.zipcode = response?.zipcode ?? ""
                    self.prefValue = response?.prefecture ?? ""
                    self.municipalitieName = response?.city ?? ""
                    self.addressName = response?.address ?? ""
                }
            }
    }
}
