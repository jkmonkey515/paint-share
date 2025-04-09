//
//  FavoriteDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/12.
//

import SwiftUI

class FavoriteDataModel: ObservableObject{
    @Published var navigationTag: Int? = nil
    
    //0: not selected. 1: like
    @Published  var isFavorite: Bool = false
    
    @Published var favoriteListItems:[FavoriteListItem]=[]
    
    @Published var paintId: Int = -1
    
    @Published var paintLikeDto:PaintLikeDto?
    
    @Published var count :Int = 0
    
    @Published var page = 0
    
    var totalPages = 0
    
    var searchInProgress: Bool = false
    
    func reset(){
        isFavorite = false
        paintId = -1
        paintLikeDto = nil
        favoriteListItems = []
        count = 0
        page = 0
        totalPages = 0
        searchInProgress = false
    }
    
    //post like
    func savePaintLike(dialogsDataModel: DialogsDataModel){
        UrlUtils.postRequest(url: UrlConstants.PAINT_LIKE_PAINT+"/\(paintId)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then{
                //getlist
                self.getLikePaint(paintId: self.paintId, dialogsDataModel: dialogsDataModel)
            }
            .always {
                
            }
    }
    
    func getLikePaint(paintId:Int,dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.PAINT_GET_LIKE_PAINT+"/\(paintId)", type: PaintLikeDto.self, dialogsDataModel: dialogsDataModel)
            .then{
            likeState in
                self.isFavorite = likeState?.deleted == 0 ? false : true
        }
    }
    
    //page
    func loadMore( dialogsDataModel: DialogsDataModel) {
        debugPrintLog(message:"loading more appear")
        if page < totalPages - 1 {
            page = page + 1
            getLikePaintList(dialogsDataModel: dialogsDataModel)
        }
    }
    
    func searchFromZeroPage(dialogsDataModel: DialogsDataModel) {
        self.page = 0
        self.getLikePaintList(dialogsDataModel: dialogsDataModel)
    }
    
    //getlist
    func getLikePaintList(dialogsDataModel: DialogsDataModel){
        if self.searchInProgress{
            if self.page > 0{
                self.page = self.page - 1
            }
            return
        }
        self.searchInProgress = true
        if(self.page == 0){
            self.favoriteListItems = []
            self.count = 0
            self.totalPages = 0
        }
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UrlUtils.getRequest(url: UrlConstants.PAINT_GET_LIKE_PAINT_LIST+"?page=\(self.page)", type: FavoriteSearchResponse.self,dialogsDataModel: dialogsDataModel)
                .then{
                    favoriteSearchResponse in
                    if (favoriteSearchResponse != nil){
                        if (favoriteSearchResponse!.content.count == 0) {
                            if self.page > 0 {
                                self.page = self.page - 1
                            }
                        }

                        self.count=favoriteSearchResponse?.totalElements ?? 0
                        self.totalPages = favoriteSearchResponse?.totalPages ?? 0
                        favoriteSearchResponse!.content.forEach{
                            likePaint in
                            let favoriteListItem = FavoriteListItem(id: likePaint.id, paintLikeDto: likePaint)
                            self.favoriteListItems.append(favoriteListItem)
                            
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
