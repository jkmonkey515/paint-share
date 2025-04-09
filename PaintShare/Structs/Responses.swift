//
//  Responses.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/27/21.
//

import SwiftUI

struct ErrorMsg: Decodable {
    var message: String
}

struct LoginResponse: Decodable {
    var token: String
}

struct UpdateResponse: Decodable {
    var update: Bool
    var updateText: String
}

struct GroupSearchResponse: Decodable {
    var content: [GroupSearchDto]
    var totalElements: Int
    var totalPages: Int
}

struct PhotographResponse: Decodable {
    var totalUseCount: Int
    var remainUseCount: Int
    var group: GroupDto
    var groupImageUseDtoList: [GroupImageUseDtoListItem]
    var overUsedPrice: Int
    var prevMonthImgPrice: Int?
}

struct PictureResponse: Decodable {
    var makers: [CameraMakersDto]
    var useCategories: [CameraUseCategoriesDto]
    var colors: [CameraColorsDto]
    var goodsNames: [CameraGoodsNamesDto]
}

struct ReviewSearchResponse: Decodable {
    var content: [ReviewDto]
    var totalElements: Int
    var totalPages: Int
}

struct LoginStatusDto: Decodable {
    var userId: Int
    var status: Int
}

struct WarehouseSearchResponse: Decodable {
    var content: [WarehouseListItem]
    var totalElements: Int
    var totalPages: Int
}

struct GeocodingAddressDto: Decodable {
    var address: String
    var city: String
    var prefecture: String
    var zipcode: String
}

struct FavoriteSearchResponse: Decodable {
    var content: [PaintLikeDto]
    var totalElements: Int
    var totalPages: Int
}

struct BrowsingHistorySearchResponse: Decodable {
    var content: [PaintViewDto]
    var totalElements: Int
    var totalPages: Int
}

struct CardResponse: Decodable {
    var brand: String
    var last4: String
    var name: String?
}

struct SubscriptionResponse:Decodable{
    var status :String
}

//未読メッセージ数
struct MenuNoticeResponse:Decodable{
    var chatroomStatus:Int?
    var unReadCount: Int?
}

struct MemberSearchResponse: Decodable {
    var content: [MemberSearchDto]
    var totalElements: Int
    var totalPages: Int
}

struct CardCheckStatusResponse: Decodable {
    var status: Bool
}

