//
//  AllRanksDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import SwiftUI

class AllRanksDataModel: ObservableObject {
    
    var searchInProgress: Bool = false
    
    @Published var showRefreshingIcon: Bool = false
    
    var groupId = -1;
    
    @Published var selectedRankType: Int = -1 {
        didSet {
            if (oldValue != selectedRankType) {
                self.page = 0
                self.loadReviews(dialogsDataModel: self.dialogsDataModel!)
            }
        }
    }
    
    @Published var rank0Count: Int = 0
    
    @Published var rank1Count: Int = 0
    
    @Published var rank2Count: Int = 0
    
    @Published var totalCount: Int = 0
    
    @Published var commentListItems: [CommentListItem] = []
    
    var page = 0
    
    var totalPages = 0
    
    var dialogsDataModel: DialogsDataModel?
    
    func reset() {
        searchInProgress = false
        showRefreshingIcon = false
        groupId = -1
        selectedRankType = -1
        rank0Count = 0
        rank1Count = 0
        rank2Count = 0
        totalCount = 0
        commentListItems = []
        page = 0
        totalPages = 0
    }
    
    func initData(dialogsDataModel: DialogsDataModel) {
        self.dialogsDataModel = dialogsDataModel
        UrlUtils.getRequest(url: UrlConstants.GROUP_SEARCH_DTO + "/\(groupId)", type: GroupSearchDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                groupSearchDto in
                self.rank0Count = groupSearchDto!.rank0Count
                self.rank1Count = groupSearchDto!.rank1Count
                self.rank2Count = groupSearchDto!.rank2Count
                self.totalCount = self.rank0Count + self.rank1Count + self.rank2Count
            }
    }
    
    func loadMoreIfNeeded(currentItem item: CommentListItem, dialogsDataModel: DialogsDataModel) {
        let thresholdIndex = commentListItems.index(commentListItems.endIndex, offsetBy: -1)
        if commentListItems.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            if page < totalPages - 1 {
                page = page + 1
                loadReviews(dialogsDataModel: dialogsDataModel)
            }
        }
    }
    
    func loadReviews(dialogsDataModel: DialogsDataModel) {
        if self.searchInProgress {
            if self.page > 0 {
                self.page = self.page - 1
            }
            return
        }
        self.searchInProgress = true
        if (self.page == 0) {
            self.commentListItems = []
            self.totalPages = 0
        }
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UrlUtils.getRequest(url: UrlConstants.REVIEW_SEARCH + "?groupId=\(self.groupId)" + (self.selectedRankType != -1 ? "&&score=\(self.selectedRankType)" : "") + "&&page=\(self.page)", type: ReviewSearchResponse.self, dialogsDataModel: dialogsDataModel)
                .then {
                    reviewSearchResponse in
                    if (reviewSearchResponse != nil) {
                        if (reviewSearchResponse!.content.count == 0) {
                            if self.page > 0 {
                                self.page = self.page - 1
                            }
                        }
                        self.totalPages = reviewSearchResponse!.totalPages
                        reviewSearchResponse!.content.forEach {
                            review in
                            let commentListItem = CommentListItem(id: review.id, rank: review.score, comment: review.content, commentUserDto: review.reviewUserDto, updatedAt: review.updatedAt, displayGroupName: review.displayGroupName ?? "")
                            self.commentListItems.append(commentListItem)
                        }
                        // count refresh
                        self.initData(dialogsDataModel: dialogsDataModel)
                    } else {
                        if self.page > 0 {
                            self.page = self.page - 1
                        }
                    }
                }
                .always {
                    self.searchInProgress = false
                    self.showRefreshingIcon = false
                }
        }
    }
}
