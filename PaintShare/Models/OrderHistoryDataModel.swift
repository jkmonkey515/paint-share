//
//  OrderHistoryDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

class OrderHistoryDataModel: ObservableObject {

    @Published var navigationTag: Int? = nil
    
    @Published var orderList: [OrderListItem] = []
    
    func getListData(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.ORDER_GET_USER_ORDERS + "?paymentStatus=1", type: [OrderListItem].self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.orderList = []
                if (result != nil){
                    for Item in result! {
                        self.orderList.append(Item)
                    }
                }
                
            }
    }
}

