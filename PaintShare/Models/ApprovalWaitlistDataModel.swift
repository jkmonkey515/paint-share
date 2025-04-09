//
//  ApprovalWaitlist.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/15/21.
//

import SwiftUI

class ApprovalWaitlistDataModel: ObservableObject {
    
    @Published var showRefreshingIcon: Bool = false
    
    @Published var resultCount: Int = 0
    
    @Published var waitList: [WaitListItem] = []
    
    @Published var navigationTag: Int? = nil
    
    @Published var showDeleteConfirmDialog: Bool = false
    
    var relationIdToDelete: Int? = nil
    
    func reset() {
        showRefreshingIcon = false
        resultCount = 0
        waitList = []
        navigationTag = nil
        showDeleteConfirmDialog = false
        relationIdToDelete = nil
    }
    
    func listRequests(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.USER_GROUP_RELATION_REQUESTS, type: [UserGroupRelationDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                userGroupRelations in
                self.waitList = []
                self.resultCount = 0
                if userGroupRelations != nil {
                    self.resultCount = userGroupRelations!.count
                    userGroupRelations!.forEach {
                        relation in
                        let waitListItem = WaitListItem(id: relation.id, userDto: relation.userDto, requestMessage: relation.requestMessage, statusInGroup: relation.status, statusInGroupDisplayName: Constants.waitListStatusInGroupDisplayNameMap[relation.status] ?? "")
                        self.waitList.append(waitListItem)
                    }
                }
            }
            .always {
                self.showRefreshingIcon = false
            }
    }
    
    func approve(dialogsDataModel: DialogsDataModel, id: Int) {
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_CONFIRM_REQUEST + "/\(id)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.listRequests(dialogsDataModel: dialogsDataModel)
            }
    }
    
    func delete(dialogsDataModel: DialogsDataModel) {
        if (self.relationIdToDelete == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_CANCEL_REQUEST_OR_REJECT + "/\(self.relationIdToDelete!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.listRequests(dialogsDataModel: dialogsDataModel)
            }
            .always {
                self.relationIdToDelete = nil
            }
    }
}
