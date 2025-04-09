//
//  GoodsNameSelectDataModel.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/07/06.
//

import SwiftUI

class GoodsNameSelectDataModel: ObservableObject {
    
    @Published var searchPhrase: String = ""
    
    @Published var goodsNameMaster: [GoodsNameDto] = []
    
    @Published var selGoodsNameList: [GoodsNameDto] = []
    
    func reset() {
        searchPhrase = ""
        selGoodsNameList = []
    }
    
    func initData(dialogsDataModel: DialogsDataModel, makerId: Int) {
        var url: String = UrlConstants.MST_GOODS_NAME
        // 商品名マスタ 取得
        if makerId != -1{
            url = "\(UrlConstants.MST)/\(makerId)\(UrlConstants.MST_MAKER_GOODS_NAME)"
        }
        UrlUtils.getRequest(url: url, type: [GoodsNameDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                goodsNameMaster in
                self.goodsNameMaster = goodsNameMaster!
                self.selGoodsNameList = goodsNameMaster!
                self.resetList(searchPhrase: self.searchPhrase)
            }
    }
    
    func resetList(searchPhrase: String){
        selGoodsNameList = []
        for result in goodsNameMaster{
            if (isSearch(regStr: searchPhrase, goodsName: result.name)){
                selGoodsNameList.append(result)
            }
        }
    }
    
    func isSearch(regStr: String, goodsName: String)->Bool{
        if regStr.count == 0 {
            return true
        }
        let pattern = regStr;
        let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
        let results = regex?.matches(in: goodsName, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: goodsName.count))
        return results!.count > 0
    }
}

