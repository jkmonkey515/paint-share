//
//  WarehouseDataMode.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/08.
//

import SwiftUI

class WarehouseDataModel:ObservableObject{
    
    @Published var count :Int=0
    
    @Published var selectedWarehouseMenuTab: Int = 0
    
    //1
    @Published var navigationTag: Int? = nil
    
    @Published var warehouseListItem:[WarehouseListItem]=[]
    
    @Published var showDeleteWarehouse: Bool = false
    
    @Published var showCantDeleteNoti: Bool = false
    
    var groupId: Int = -1
    
    var warehouseDeleteId: Int = -1
    
    @Published var page = 0
    
    var totalPages = 0
    
    var searchInProgress: Bool = false

    
    func reset() {
        selectedWarehouseMenuTab = 0//
        warehouseListItem=[]
        page = 0
        count = 0
        totalPages = 0
        searchInProgress = false
        showDeleteWarehouse = false
    }
    
    func loadMore( dialogsDataModel: DialogsDataModel) {
        debugPrintLog(message:"loading more appear")
        if page < totalPages - 1 {
            page = page + 1
            getWarehouseList(dialogsDataModel: dialogsDataModel)
        }
    }
    
    func searchFromZeroPage(dialogsDataModel: DialogsDataModel) {
        self.page = 0
        self.getWarehouseList(dialogsDataModel: dialogsDataModel)
    }
    
    func getWarehouseList(dialogsDataModel: DialogsDataModel){
       if self.searchInProgress{
            if self.page > 0{
                self.page = self.page - 1
            }
           return
        }
        self.searchInProgress = true
        if(self.page == 0){
            self.warehouseListItem = []
            self.count = 0
            self.totalPages = 0
        }
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        UrlUtils.getRequest(url: UrlConstants.WAREHOUSE_SEARCH+"?groupId=\(self.groupId)&page=\(self.page)", type: WarehouseSearchResponse.self, dialogsDataModel: dialogsDataModel)
            .then{
                warehouseSearchResponse in
                if warehouseSearchResponse != nil{
                    if (warehouseSearchResponse?.content.count == 0) {
                        if self.page > 0 {
                            self.page = self.page - 1
                        }
                    }
                    self.warehouseListItem.append(contentsOf: warehouseSearchResponse?.content ?? []) //*
                self.count = warehouseSearchResponse?.totalElements ?? 0
                self.totalPages = warehouseSearchResponse?.totalPages ?? 0
                }else{
                    if self.page > 0{
                        self .page = self.page - 1
                    }
                }
            
            }
            .always {
                self.searchInProgress=false
                
            }
        }
    }
    
    func deleteWarehouse(dialogsDataModel: DialogsDataModel){
        UrlUtils.postRequest(url: UrlConstants.WAREHOUSE_DELETE+"/\(self.warehouseDeleteId)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then{
                self.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
            }
    }
    
}
