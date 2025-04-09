//
//  BrowsingHistoryDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/12.
//

import SwiftUI

class BrowsingHistoryDataModel:ObservableObject {
    @Published var navigationTag: Int? = nil
    
    @Published var browsingHistoryListItems:[BrowsingHistoryListItem]=[]
    
    @Published var paintId: Int = -1
    
    @Published var paintViewDto:PaintViewDto?
    
    @Published var count :Int = 0
    
    @Published var page = 0
    
    var totalPages = 0
    
    var searchInProgress: Bool = false
        
    func reset(){
        paintId = -1
        paintViewDto = nil
        browsingHistoryListItems = []
        count = 0
        page = 0
        totalPages = 0
        searchInProgress = false
    }
    
    func savePaintBrowsingHistory(dialogsDataModel: DialogsDataModel){
        UrlUtils.postRequest(url: UrlConstants.PAINT_VIEW_PAINT+"/\(paintId)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then{
                
            }
            .always {
                
            }
    }
    
    //Page
    func loadMore( dialogsDataModel: DialogsDataModel) {
        debugPrintLog(message:"loading more appear")
        if page < totalPages - 1 {
            page = page + 1
            getBrowsingHistoryList(dialogsDataModel: dialogsDataModel)
        }
    }
    
    func searchFromZeroPage(dialogsDataModel: DialogsDataModel) {
        self.page = 0
        self.getBrowsingHistoryList(dialogsDataModel: dialogsDataModel)
    }
    
    //getlist
    func getBrowsingHistoryList(dialogsDataModel: DialogsDataModel){
        if self.searchInProgress{
            if self.page > 0{
                self.page = self.page - 1
            }
            return
        }
        self.searchInProgress = true
        if(self.page == 0){
            self.browsingHistoryListItems = []
            self.count = 0
            self.totalPages = 0
        }
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UrlUtils.getRequest(url: UrlConstants.PAINT_GET_VIEW_PAINT_LIST+"?page=\(self.page)", type: BrowsingHistorySearchResponse.self,dialogsDataModel: dialogsDataModel)
                .then{
                    browsingHistorySearchResponse in
                    if (browsingHistorySearchResponse != nil){
                        if (browsingHistorySearchResponse!.content.count == 0) {
                            if self.page > 0 {
                                self.page = self.page - 1
                            }
                        }

                        self.count=browsingHistorySearchResponse?.totalElements ?? 0
                        self.totalPages = browsingHistorySearchResponse?.totalPages ?? 0
                        browsingHistorySearchResponse!.content.forEach{
                            browsingHistory in
                            let browsingHistoryListItem = BrowsingHistoryListItem(id:  browsingHistory.id, paintViewDto: browsingHistory)
                            self.browsingHistoryListItems.append(browsingHistoryListItem)
                            
                        }
                    }else{
                        if self.page > 0 {
                            self.page = self.page - 1
                        }
                    }
                }
                .always {
                    self.searchInProgress = false
                }
        }
    }
}
