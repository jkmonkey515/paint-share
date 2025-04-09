//
//  ColorSelectDataModel.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/28.
//

import SwiftUI

class ColorSelectDataModel: ObservableObject {
    
    @Published var selection: Int = 0
    
    @Published var makerPickList: [PickItem] = []
    
    @Published var makerDtoMaster: [MakerDto] = []
    
    @Published var makerKey: Int = 0
    
    @Published var makerValue: String = "日塗工"
    
    @Published var colorNumberList: [ColorNumberDto] = []
    
    @Published var selColorNumberList: [ColorNumberDto] = []
    
    // search
    @Published var searchPhrase: String = ""
    
    var selectMakerKey: Int = -1
    
    func reset(){
        makerKey = 0
        makerValue = "日塗工"
        searchPhrase = ""
        selColorNumberList = []
    }
    
    func initData(dialogsDataModel: DialogsDataModel,isSearch: Bool) {
        reset()
        // メーカーマスタ 取得
        UrlUtils.getRequest(url: UrlConstants.MST_MAKERS_WIDTH_JPMA, type: [MakerDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                makerDtoMaster in
                self.makerPickList = []
                for makerItem in makerDtoMaster! {
                    let pick = PickItem(key: makerItem.id,value: makerItem.name)
                    self.makerPickList.append(pick)
                }
            }

        if isSearch {
            // 参照出来る色番号 取得
            UrlUtils.getRequest(url: UrlConstants.PAINT_GET_COLOR_LIST, type: [ColorNumberDto].self, dialogsDataModel: dialogsDataModel)
                .then {
                    searchAbleColors in
                    // 色番号マスタ 取得
                    UrlUtils.getRequest(url: UrlConstants.MST_COLOR_NUMBER, type: [ColorNumberDto].self, dialogsDataModel: dialogsDataModel)
                        .then {
                            colorNumberMaster in
                            self.colorNumberList = []
                            for colorNumberItem in colorNumberMaster! {
                                let results = searchAbleColors?.filter{ el in el.id == colorNumberItem.id }
                                if results!.count > 0 {
                                    self.colorNumberList.append(colorNumberItem)
                                }
                            }
                            self.setList(makerId: self.makerKey)
                        }
                }
        } else {
            // 色番号マスタ 取得
            UrlUtils.getRequest(url: UrlConstants.MST_COLOR_NUMBER, type: [ColorNumberDto].self, dialogsDataModel: dialogsDataModel)
                .then {
                    colorNumberMaster in
                    self.colorNumberList = []
                    for colorNumberItem in colorNumberMaster! {
                        self.colorNumberList.append(colorNumberItem)
                    }
                    self.setList(makerId: self.makerKey)
                }
        }

    }
    
    func getValueById(pickId: Int, list:[PickItem]) -> String{
        for item in list {
            if item.key == pickId{
                return item.value
            }
        }
        return ""
    }
    
    func setValue(pickId: Int){
        makerValue = getValueById(pickId: pickId, list: makerPickList)
    }
    
    func setList(makerId: Int){
        selectMakerKey = makerId
        selColorNumberList.removeAll()
        for result in colorNumberList{
            if result.maker.id == makerId{
                selColorNumberList.append(result)
            }
        }
    }
    
    func resetList(searchPhrase: String){
        var searchColorNumberList: [ColorNumberDto] = []
        for result in colorNumberList{
            if (result.maker.id == selectMakerKey && isSearch(regStr: searchPhrase, colorNumber: result.colorNumber)){
                searchColorNumberList.append(result)
            }
        }
        selColorNumberList.removeAll();
        selColorNumberList = searchColorNumberList
    }
    
    func isSearch(regStr: String, colorNumber: String)->Bool{
        if regStr.count == 0 {
            return true
        }
        let pattern = regStr;
        let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
        let results = regex?.matches(in: colorNumber, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: colorNumber.count))
        return results!.count > 0
    }
    
}
