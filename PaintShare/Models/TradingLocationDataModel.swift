//
//  TradingLocationDataModel.swift
//  PaintShare
//
//  Created by  Kaetsu Jo on 2022/06/01.
//

import SwiftUI

class TradingLocationDataModel:ObservableObject{
    
    @Published var prefectures: [Prefecture] = []
    
    // 0:取引場所 1:都道府県 2:市区郡・町村
    @Published var selectedMenuTab: Int = 0
    
    @Published var selectionPrefecture: Prefecture?
    
    @Published var selectionCitiesName: String = ""
    
    @Published var show: Bool = false
    
    
    func initLocationData(dialogsDataModel:DialogsDataModel){
        
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_LOCATION_DATA, type: [AreaCategory].self, dialogsDataModel: dialogsDataModel)
            .then{
                areaCategoryResult in
                DispatchQueue.main.async {
                    self.prefectures = []
                    for area in areaCategoryResult ?? []{
                        self.prefectures.append(contentsOf: area.prefectures)
                    }
                }
            }
    }

    
//    init(){
//        prefectures.append(Prefecture(code: 1, name: "北海道", cities: [Machi(code: 5, name: "青森"), Machi(code: 6, name: "札幌")]))
//        prefectures.append(Prefecture(code: 2, name: "東京都", cities: [Machi(code: 1, name: "渋谷区"), Machi(code: 2, name: "中央区")]))
//        prefectures.append( Prefecture(code: 3, name: "千葉県", cities: [Machi(code: 3, name: "千葉市"), Machi(code: 4, name: "習志野市")]))
//    }
//
    func reset() {
        selectedMenuTab = 0
    }
}
