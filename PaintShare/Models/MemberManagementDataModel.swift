//
//  MemberManagementDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/24/21.
//

import SwiftUI

class MemberManagementDataModel: ObservableObject {
    
    var searchInProgress: Bool = false
    
    @Published var showRefreshingIcon: Bool = false
    
    @Published var searchPhrase: String = ""
    
    var groupId: Int = -1
    
    @Published var numberOfJoined: Int = 0
    
    @Published var numberOfShared: Int = 0
    
    @Published var memberListItems: [MemberListItem] = []
    
    @Published var page = 0
    
    @Published var navigationTag: Int? = nil
    
    @Published var showDeleteConfirmDialog: Bool = false
    
    var userIdToDelete: Int?
    
    var totalElements = 0
    
    var totalPages = 0
    
    func reset() {
        searchInProgress = false
        showRefreshingIcon = false
        searchPhrase = ""
        groupId = -1
        numberOfJoined = 0
        numberOfShared = 0
        memberListItems = []
        page = 0
        navigationTag = nil
        showDeleteConfirmDialog = false
        userIdToDelete = nil
        totalPages = 0
        totalElements = 0
    }
    
    func getMembersCount(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.USER_GROUP_RELATION_MEMBERS_COUNT + "?groupId=\(self.groupId)", type: MemberCountDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                memberCountDto in
                if (memberCountDto != nil) {
                    self.numberOfJoined = memberCountDto!.totalJoined
                    self.numberOfShared = memberCountDto!.totalShared
                }
            }
    }
    
    func searchFromZeroPage(dialogsDataModel: DialogsDataModel) {
        self.page = 0
        self.search(dialogsDataModel: dialogsDataModel)
    }
    
    func loadMore( dialogsDataModel: DialogsDataModel) {
        debugPrintLog(message:"loading more appear")
        if page < totalPages - 1 {
            page = page + 1
            search(dialogsDataModel: dialogsDataModel)
        }
    }
    
    func search(dialogsDataModel: DialogsDataModel) {
        if self.searchInProgress {
            if self.page > 0 {
                self.page = self.page - 1
            }
            return
        }
        self.searchInProgress = true
        if (self.page == 0) {
            self.memberListItems = []
            self.totalPages = 0
            self.totalElements = 0
        }
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let percentEncoded = self.searchPhrase.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            UrlUtils.getRequest(url: UrlConstants.USER_GROUP_RELATION_SEARCH_MEMBERS + "?groupId=\(self.groupId)&searchStr=\(percentEncoded ?? "")&page=\(self.page)", type: MemberSearchResponse.self, dialogsDataModel: dialogsDataModel)
                .then {
                    memberSearchResponse in
                    if (memberSearchResponse != nil) {
                        if (memberSearchResponse!.content.count == 0) {
                            if self.page > 0 {
                                self.page = self.page - 1
                            }
                        }
                        self.totalElements = memberSearchResponse!.totalElements
                        self.totalPages = memberSearchResponse!.totalPages
                        memberSearchResponse!.content.forEach {
                            memberSearchDto in
                            let memberListItem = MemberListItem(id: memberSearchDto.id, userDto: memberSearchDto.userDto, statusInGroup: memberSearchDto.statusInGroup, statusInGroupDisplayName: memberSearchDto.statusInGroup == 1 ? "メンバー" : "フレンド")
                            self.memberListItems.append(memberListItem)
                        }
                    } else {
                        if self.page > 0 {
                            self.page = self.page - 1
                        }
                    }
                    self.getMembersCount(dialogsDataModel: dialogsDataModel)
                }
                .always {
                    self.searchInProgress = false
                    self.showRefreshingIcon = false
                }
        }
    }
    
    func delete(dialogsDataModel: DialogsDataModel) {
        if (self.userIdToDelete == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_DELETE_USER + "/\(self.userIdToDelete!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.search(dialogsDataModel: dialogsDataModel)
            }
            .always {
                self.userIdToDelete = nil
            }
    }
    
}
