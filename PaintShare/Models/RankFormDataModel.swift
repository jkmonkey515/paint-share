//
//  RankFormDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import SwiftUI

class RankFormDataModel: ObservableObject {
    
    @Published var groupId: Int = -1
    
    @Published var groupName: String = ""
    
    @Published var comment: String = ""
    
    @Published var selectedRank: Int? = nil
    
    @Published var showSaveReviewDialog: Bool = false
    // validation messages
    
    @Published var commentMessage: String = ""
    
    @Published var selectedRankMessage: String = ""
    
    @Published var selectWeightNumber: Int? = -1
    
    @Published var selectDateNumber: Int? = -1
    
    func reset() {
        groupId = -1
        groupName = ""
        comment = ""
        selectedRank = nil
        commentMessage = ""
        selectedRankMessage = ""
        selectWeightNumber = -1
        selectDateNumber = -1
    }
    
    func saveReview(dialogsDataModel: DialogsDataModel, groupDetailInfoDataModel: GroupDetailInfoDataModel,chatDataModel:ChatDataModel) {
        let body = ReviewBody(groupId: self.groupId, score: self.selectedRank, content: comment, questionOne: self.selectWeightNumber, questionTwo: self.selectDateNumber)
        
        UrlUtils.postRequest(url: UrlConstants.REVIEW_SAVE, body: body, dialogsDataModel: dialogsDataModel)
            .then {
                self.showSaveReviewDialog = true
//                groupDetailInfoDataModel.navigationTag = nil
//                chatDataModel.navigationTag = nil
                
            }
            .catch {
                error in
                if let validationError = error as? ValidationError {
                    if let contentError = validationError.errors["content"] {
                        self.commentMessage = contentError
                    }
                    if let scoreError = validationError.errors["score"] {
                        self.selectedRankMessage = scoreError
                    }
                }
            }
    }
}
