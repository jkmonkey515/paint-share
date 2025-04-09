//
//  LocationDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/27/22.
//

import SwiftUI

class LocationDataModel: ObservableObject {
    
    @Published var areaCategory: [AreaCategory] = []
    
    // [type(1: AreaCategory, 2: Prefecture, 3: Machi) : [code : name]]
    @Published var codeNameMap: [Int: [Int: String]] = [:]
    
    // [prefecture.code : expanded]
    @Published var codeExpandMap: [Int : Bool] = [:]
    
    // [type(1: AreaCategory, 2: Prefecture, 3: Machi) : [code : checkBoxValue]]
    @Published var checkBoxMap: [Int: [Int: Bool]] = [:]
    
    @Published var checkString: String = ""
        
    @Published var checkCodeArray: [String] = []
    
    func initData(dialogsDataModel: DialogsDataModel) {
        
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_LOCATION_DATA, type: [AreaCategory].self, dialogsDataModel: dialogsDataModel)
            .then {
                areaCategoryResult in
                DispatchQueue.main.async {
                    self.areaCategory = areaCategoryResult ?? []
                    self.checkBoxMap[1] = [:]
                    self.checkBoxMap[2] = [:]
                    self.checkBoxMap[3] = [:]
                    self.codeNameMap[1] = [:]
                    self.codeNameMap[2] = [:]
                    self.codeNameMap[3] = [:]
                    for area in self.areaCategory {
                        self.checkBoxMap[1]![area.code] = false
                        self.codeNameMap[1]![area.code] = area.name
                        for pref in area.prefectures {
                            self.checkBoxMap[2]![pref.code] = false
                            self.codeNameMap[2]![pref.code] = pref.name
                            self.codeExpandMap[pref.code] = false
                            for machi in pref.cities {
                                self.checkBoxMap[3]![machi.code] = false
                                self.codeNameMap[3]![machi.code] = machi.name
                            }
                        }
                    }
                    
                }
            }
//        areaCategory.append(AreaCategory(code: 1, name: "北海道", prefectures: [
//            Prefecture(code: 1, name: "北海道", cities: [Machi(code: 5, name: "青森"), Machi(code: 6, name: "札幌")])
//        ]))
//        areaCategory.append(AreaCategory(code: 2, name: "関東", prefectures: [
//            Prefecture(code: 2, name: "東京都", cities: [Machi(code: 1, name: "渋谷区"), Machi(code: 2, name: "中央区")]),
//            Prefecture(code: 3, name: "千葉県", cities: [Machi(code: 3, name: "千葉市"), Machi(code: 4, name: "習志野市")])
//        ]))
        //
    }
    
    func setChecked() -> String{
        checkString = ""
        for (key,value) in checkBoxMap {
            for (key2,value2) in value {
                if self.checkCodeArray.contains("\(key2)"){
                    checkBoxMap[key]![key2]=true
                    if checkString == "" {
                        checkString.append(codeNameMap[key]![key2]!)
                    }else{
                        checkString.append("、"+codeNameMap[key]![key2]!)
                    }
                }
            }
        }
        return checkString
    }
    
    func printCheck() {
        checkString = ""
        checkCodeArray = []
        for (key,value) in checkBoxMap {
            for (key2,value2) in value {
                if (checkBoxMap[key]![key2]!) {
                    if checkString == "" {
                        checkString.append(codeNameMap[key]![key2]!)
                        checkCodeArray.append("\(key2)")
                    }else{
                        checkString.append("、"+codeNameMap[key]![key2]!)
                        checkCodeArray.append("\(key2)")
                    }
                    debugPrintLog(message:codeNameMap[key]![key2]!)
                }
            }
        }
    }
    
    func clearCheck() {
        for (key,value) in checkBoxMap {
            for (key2,value2) in value {
           checkBoxMap[key]![key2]=false
            }
        }
    }
}
