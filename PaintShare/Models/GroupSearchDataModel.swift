//
//  GroupSearchDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/9/21.
//

import SwiftUI

class GroupSearchDataModel: ObservableObject {
    
    var isRelatedSearch: Bool = false
    
    var searchInProgress: Bool = false

    @Published var showRefreshingIcon: Bool = false
    
    @Published var searchPhrase: String = ""
    
    @Published var resultCount: Int = 0
    
    @Published var groupSearchItems: [GroupSearchItem] = []
    
    @Published var groupSearchAssociationItems: [GroupSearchItem] = []
    
    @Published var navigationTag: Int? = nil
    
    @Published var page = 0
    
    @Published var showIntroduction: Bool = true
    
    var totalPages = 0
    
    @Published var showExitConfirmDialog: Bool = false
    
    var groupIdToExit: Int? = nil
    
    var groupExitConfirmMessage: String = ""
   
    var searchInProgressAssociation: Bool = false
    
    @Published var searchPhraseAssociation: String = ""

    @Published var showRefreshingIconAssociation: Bool = false
    
    @Published var pageAssociation = 0
    
    var totalPagesAssociation = 0
    
    @Published var resultCountAssociation: Int = 0
    
    func reset() {
        isRelatedSearch = false
        searchInProgress = false
        showRefreshingIcon = false
        searchPhrase = ""
        resultCount = 0
        groupSearchItems = []
        groupSearchAssociationItems = []
        navigationTag = nil
        page = 0
        totalPages = 0
        showExitConfirmDialog = false
        groupIdToExit = nil
        groupExitConfirmMessage = ""
        resultCountAssociation = 0
        totalPagesAssociation = 0
        searchPhraseAssociation = ""
        showRefreshingIconAssociation = false
        pageAssociation = 0
        totalPagesAssociation = 0
    }
    
    func loadMoreNotRelated( mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel) {
        debugPrintLog(message:"loading more appear")
        if page < totalPages - 1 {
            page = page + 1
            searchNotRelated( mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
        }
    }
    
    func loadMoreRelated(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel) {
        debugPrintLog(message:"loading more appear")
        if pageAssociation < totalPagesAssociation - 1 {
            pageAssociation = pageAssociation + 1
            searchRelated( mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
        }
    }
    
    func searchFromZeroPageNotRelated(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel) {
        self.page = 0
        self.searchNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
    }
    
    func searchFromZeroPageRelated(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel) {
        self.pageAssociation = 0
        self.searchRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
    }
    
    func searchNotRelated(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel) {
        if self.searchInProgress {
            if self.page > 0 {
                self.page = self.page - 1
            }
            return
        }
        self.searchInProgress = true
        if (self.page == 0) {
            self.groupSearchItems = []
            self.resultCount = 0
            self.totalPages = 0
        }
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let percentEncoded = self.searchPhrase.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            UrlUtils.getRequest(url: UrlConstants.GROUP_SEARCH + "?isRelatedSearch=\(false)&searchStr=\(percentEncoded ?? "")&page=\(self.page)", type: GroupSearchResponse.self, dialogsDataModel: dialogsDataModel)
                .then {
                    groupSearchResponse in
                    if groupSearchResponse != nil {
                        if (groupSearchResponse!.content.count == 0) {
                            if self.page > 0 {
                                self.page = self.page - 1
                            }
                        }
                        
                            self.resultCount = groupSearchResponse!.totalElements
                            self.totalPages = groupSearchResponse!.totalPages
                        groupSearchResponse!.content.forEach {
                            groupSearchDto in
                            let groupSearchItem = GroupSearchItem(id: groupSearchDto.id, groupDto: groupSearchDto.groupDto, rank0Count: groupSearchDto.rank0Count, rank1Count: groupSearchDto.rank1Count, rank2Count: groupSearchDto.rank2Count, statusInGroup: groupSearchDto.statusInGroup, statusInGroupDisplayName: Constants.getStatusInGroupDisplayName(status: groupSearchDto.statusInGroup), ownedByLoggedinUser: mainViewDataModel.loggedInUserId == groupSearchDto.groupDto.groupOwner.id)
                                self.groupSearchItems.append(groupSearchItem)
                        }
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
    
    func searchRelated(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel) {
        if self.searchInProgressAssociation {
            if self.pageAssociation > 0 {
                self.pageAssociation = self.pageAssociation - 1
            }
            return
        }
        self.searchInProgressAssociation = true
        if (self.pageAssociation == 0) {
            self.groupSearchAssociationItems = []
            self.resultCountAssociation = 0
            self.totalPagesAssociation = 0
        }
        // swiftui list reload bug のため
        let delay: Double = self.pageAssociation == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let percentEncoded = self.searchPhraseAssociation.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            UrlUtils.getRequest(url: UrlConstants.GROUP_SEARCH + "?isRelatedSearch=\(true)&searchStr=\(percentEncoded ?? "")&page=\(self.pageAssociation)", type: GroupSearchResponse.self, dialogsDataModel: dialogsDataModel)
                .then {
                    groupSearchResponse in
                    if groupSearchResponse != nil {
                        if (groupSearchResponse!.content.count == 0) {
                            if self.pageAssociation > 0 {
                                self.pageAssociation = self.pageAssociation - 1
                            }
                        }
        
                            self.resultCountAssociation = groupSearchResponse!.totalElements
                            self.totalPagesAssociation = groupSearchResponse!.totalPages
                        
                        if self.resultCountAssociation == 0 && self.showIntroduction == true && mainViewDataModel.loggedInUserGroup == nil{
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.showIntroduction = false
                                dialogsDataModel.mainViewNavigationTag = 1
                            })
                        }
                        
                        groupSearchResponse!.content.forEach {
                            groupSearchDto in
                            let groupSearchItem = GroupSearchItem(id: groupSearchDto.id, groupDto: groupSearchDto.groupDto, rank0Count: groupSearchDto.rank0Count, rank1Count: groupSearchDto.rank1Count, rank2Count: groupSearchDto.rank2Count, statusInGroup: groupSearchDto.statusInGroup, statusInGroupDisplayName: Constants.getStatusInGroupDisplayName(status: groupSearchDto.statusInGroup), ownedByLoggedinUser: mainViewDataModel.loggedInUserId == groupSearchDto.groupDto.groupOwner.id)
                                self.groupSearchAssociationItems.append(groupSearchItem)
                            
                        }
                    } else {
                        if self.pageAssociation > 0 {
                            self.pageAssociation = self.pageAssociation - 1
                        }
                    }
                }
                .always {
                    self.searchInProgressAssociation = false
                    self.showRefreshingIconAssociation = false //
                }
        }
    }
    
    // 取下げ、脱退
    func quitGroup(dialogsDataModel: DialogsDataModel, mainViewDataModel: MainViewDataModel) {
        if (self.groupIdToExit == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_QUIT + "/\(self.groupIdToExit!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                if self.isRelatedSearch{
                    self.searchFromZeroPageRelated( mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                }
                else{
                    self.searchFromZeroPageNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                }
            }
            .always {
                self.groupIdToExit = nil
            }
    }
}
