//
//  CompositeStructs.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/14/21.
//

import SwiftUI

// グループ検索画面リストアイテム
struct GroupSearchItem: Identifiable {
    var id: Int
    var groupDto: GroupDto
    var rank0Count: Int
    var rank1Count: Int
    var rank2Count: Int
    var statusInGroup: Int?
    var statusInGroupDisplayName: String?
    // logo画像
    // var logo: UIImage
    var ownedByLoggedinUser: Bool
}

// 承認待ちリストアイテム
struct WaitListItem: Identifiable {
    var id: Int
    var userDto: UserDto
    var requestMessage: String
    var statusInGroup: Int
    var statusInGroupDisplayName: String
    // logo画像
    // var logo: UIImage
}

// メンバーリスト
struct MemberListItem: Identifiable {
    var id: Int
    var userDto: UserDto
    var statusInGroup: Int
    var statusInGroupDisplayName: String
    // logo画像
    // var logo: UIImage
}

// 在庫承認リスト
struct ApprovalListItem: Identifiable,Decodable {
    var id: Int
    var groupName: String
    var goodsNameName: String
    var price: Int
    var materialImgKey: String?
    var updatedAt: UInt64
}

//注文情報
struct OrderListItem:Decodable,Identifiable{
    var id: Int
    var order: OrderDetailDto
    var orderNo: String
    var orderStatus: Int
    var paymentStatus: Int
    var deliveryStatus: Int
    var user: UserDto
    var number: Double
    var paintId: Int
    var arrivalDate: String
    var thirdPartyPaymentId: String?
}

//画面利用个人情報
struct GroupImageUseDtoListItem:Decodable{
    var imageUser: UserDto
    var useCount: Int
}

// 相机检索
struct CameraListItem: Identifiable,Decodable {
    var id: Int
    var groupName: String
    var goodsNameName: String
    var color: String
}

// 評価画面用リストアイテム
struct CommentListItem: Identifiable {
    var id: Int
    var rank: Int
    var comment: String
    var commentUserDto: UserDto
    var updatedAt: UInt64
    // logo画像
    // var logo: UIImage
    var displayGroupName: String
}

// 在庫一覧検索画面 Group, Maker Label
struct InventorySearchLabel: Decodable {
    var id: Int
    var name: String
    var amount: Int
}

// 在庫一覧検索画面 Page Object
struct InventorySearchPage: Decodable {
    var content: [InventorySearchItem]
    var hasNext: Bool
}

// 在庫一覧検索画面リストアイテム
struct InventorySearchItem: Decodable {
    var id: Int
    var ownedBy: GroupDto
    var maker: MakerDto
    var goodsNameName: String
    var useCategory: UseCategoryDto?
    var expireDate: String
    var standard: MakerDto
    var colorNumber: ColorNumberDto?
    var otherColorName: String?
    var amount: Double
    var materialImgKey: String?
    var updatedAt: UInt64
    var saleFlag: Int
    var price: Int?
    var groupSearchLabel: InventorySearchLabel?
    var makerSearchLabel: InventorySearchLabel?
}

struct GroupSearchRelationItemDto: Decodable {
    var ownedGroupList: [GroupDto]
    var joinGroupList: [GroupDto]
    var sharingGroupList: [GroupDto]
}

//倉庫一覧画面リストアイテム
struct WarehouseListItem:Identifiable,Decodable,Hashable{
    var id:Int
    var warehouseDto:WarehouseDto
}

//問い合わせ一覧画面リストアイテム
struct ChatroomListItem:Identifiable,Hashable{
    var id:Int
    // var logo: UIImage
    var chatroomDto: ChatroomDto
}

//問い合わせ管理一覧画面リストアイテム
struct ChatroomDistinctListItem:Identifiable,Hashable{
    var id:Int
    // var logo: UIImage
    var chatroomDistinctDto: ChatroomDistinctDto
}
//問い合わせユーザー画面リストアイテム
struct ChatroomUsersListItem:Identifiable,Hashable{
    var id:Int
    // var logo: UIImage
    var chatroomDto: ChatroomDto
}

struct ChatMessageListItem:Decodable{
    var id:Int
    var messageDto:MessageDto
}

//お気に入り画面リストアイテム
struct FavoriteListItem:Identifiable,Hashable{
    var id:Int
    // var logo: UIImage
    var paintLikeDto: PaintLikeDto
}

//履歴画面リストアイテム
struct BrowsingHistoryListItem:Identifiable,Hashable{
    var id:Int
    // var logo: UIImage
    var paintViewDto: PaintViewDto
}
