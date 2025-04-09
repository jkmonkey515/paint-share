//
//  PhotographViewDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/7/5.
//

import SwiftUI

class PhotographViewDataModel: ObservableObject {

    @Published var navigationTag: Int? = nil
    
    @Published var overPirce: String = "￥0"
    
    @Published var prevMonthImgPrice: Int = 0
    
    @Published var permit: Bool = false
    
    @Published var totalUseCount: Int = 0
    
    @Published var remainUseCount: Int = 0
    
    @Published var groupImageUseDtoList: [GroupImageUseDtoListItem] = []
    
    @Published var permitStatus: Bool = false
        
    func getListData(id: Int, dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.IMAGE_GET_GROUPIMAGEUSESEARCHDTO + "/\(id)", type: PhotographResponse.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                if result != nil {
                    self.totalUseCount = result?.totalUseCount ?? 0
                    self.remainUseCount = result?.remainUseCount ?? 0
                    self.groupImageUseDtoList = result?.groupImageUseDtoList ?? []
                    self.permit = result?.group.imageUseStatus == 0 ? false : true
                    self.permitStatus = result?.group.imageUseStatus == 0 ? false : true
                    self.overPirce = "￥" + String(result?.overUsedPrice ?? 0)
                    self.prevMonthImgPrice = result?.prevMonthImgPrice ?? 0
                }
            }
    }
    
    func getCount(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.IMAGE_GET_GROUPIMAGESEARCHREMAININGCOUNT, type: Int.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                if Int(result ?? 0) < 0 {
                    dialogsDataModel.showOverPriceBtn = true
                }else{
                    dialogsDataModel.showOverPriceBtn = false
                }
            }
    }
    
    func changeImageStatus(id: Int, dialogsDataModel: DialogsDataModel) {
        if self.permit != self.permitStatus {
            UrlUtils.postRequest(url: UrlConstants.GROUP_TOGGLE_GROUP_IMAGE_USE_STATUS + "/\(id)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
                .then {
                    
                }
                .always {
                    
                }
        }
    }
}
