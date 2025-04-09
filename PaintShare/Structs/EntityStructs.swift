//
//  StructsForView.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/14/21.
//

import SwiftUI

struct ImageDto: Decodable {
    var id: Int
    var imageData: String
}

// ユーザー情報
struct UserDto: Decodable,Hashable {
    var id: Int
    var generatedUserId: String
    var email: String
    var lastName: String
    var firstName: String
    var phone: String
    var profile: String?
    var profileImgKey: String?
    var updatedAt: UInt64
    var freeUseUntil: UInt64
    var confirmToken: String?
}

// グループ情報
struct GroupDto: Decodable,Hashable {
    var id: Int
    var generatedGroupId: String
    var groupName: String
    var groupOwner: UserDto
    var phone: String
    var description: String
    var groupImgKey: String?
    var groupPublic: Int
    var goodsPublic: Int
    var updatedAt: UInt64
    var zipcode: String?
    var prefecture: String?
    var city: String?
    var address: String?
    var groupApproveStatus: Int
    var imageUseStatus: Int
}

struct GroupSearchDto: Decodable {
    var id: Int
    var groupDto: GroupDto
    var rank0Count: Int
    var rank1Count: Int
    var rank2Count: Int
    var statusInGroup: Int?
}

struct MemberSearchDto: Decodable {
    var id: Int
    var userDto: UserDto
    var statusInGroup: Int
}

struct MemberDeleteDto: Decodable {
    var id: Int
    var userDto: UserDto
    var status: Int
}

struct MemberCountDto: Decodable {
    var totalJoined: Int
    var totalShared: Int
}

// ユーザーグループ関係
struct UserGroupRelationDto: Decodable {
    var id: Int
    var userDto: UserDto
    var groupDto: GroupDto
    // 0:参加申請/メンバー申請、1:参加中/メンバー、2:共有申請/フレンド申請、3:共有中/フレンド、4:共有中参加申請/フレンドのメンバー申請
    var status: Int
    var requestMessage: String
}

struct ReviewDto: Decodable {
    var id: Int
    //var groupDto: GroupDto
    var score: Int
    var content: String
    var reviewUserDto: UserDto
    var updatedAt: UInt64
    var displayGroupName: String?
    var questionOne: Int?
    var questionTwo: Int?
}

// メーカーマスタ
struct MakerDto: Decodable,Hashable {
    var id: Int
    var name: String
    var jpma: Int
}

// 用途区分マスタ
struct UseCategoryDto: Decodable,Hashable {
    var id: Int
    var name: String
}

// 商品名マスタ
struct GoodsNameDto: Decodable,Hashable {
    var id: Int
    var maker: MakerDto
    var name: String
    var commonName: String?
}

// 色番号マスタ

struct ColorNumberDto: Decodable,Hashable {
    var id: Int
    var maker: MakerDto
    var colorNumber: String
    var colorCode: String
}

// 共通Pickerのデータ
struct PickItem:Hashable {
    var key: Int
    var value: String
    var valueName: String?
    var determine: Int?
}
// 图片登录情报
struct CameraMakersDto: Decodable,Hashable,Identifiable {
    var id: Int
    var name: String
}
struct CameraUseCategoriesDto: Decodable,Hashable {
    var id: Int
    var name: String
}
struct CameraColorsDto: Decodable,Hashable {
    var id: Int
    var maker: MakerDto
    var colorNumber: String
    var colorCode: String
}
struct CameraGoodsNamesDto: Decodable,Hashable {
    var goodsName: PictureNameDto
    var phrase: String
}
// 图片名字情报
struct PictureNameDto: Decodable,Hashable {
    var id: Int
    var maker: MakerDto
    var name: String
    var commonName: String
}
// 塗料情報
struct InventoryDto: Decodable,Hashable {
    var id: Int
    var ownedBy: GroupDto
    var maker: MakerDto
    var goodsName: GoodsNameDto?
    var goodsNameName: String
    var useCategory: UseCategoryDto?
    var expireDate: String
    var standard: MakerDto
    var colorNumber: ColorNumberDto?
    var otherColorName: String?
    var amount: Double
    var materialImgKey: String?
    var lotNumber: String
    var inventoryNumber: String
    var goodsPublic: Int
    var updatedAt: UInt64
    var weight: Double?
    var specification: String?
    var saleFlag: Int
    var goodsPlace: String?
    var goodsPlaceCodes: [String]?
    var price: Int?
    var likeCount: Int
    var warehouse: WarehouseDto
    var deletedFromSearch:Int?
}

// 塗料修正権限情報
struct InventoryEditPromiseDto: Decodable {
    var id: Int
    var promise: Bool? = false
}

// 塗料是否關聯
struct InventoryIsRelatedDto: Decodable {
    var related: Bool
    var groupDto: GroupDto?
}

//倉庫情報
struct WarehouseDto:Decodable,Hashable{
    var id: Int
    var name:String
  //  var warehouseOwner: GroupDto
    var zipcode:String
    var prefecture:String
    var city:String
    var address:String
    var paintsCount:Int?
    var updatedAt: UInt64
}

//注文详细情報
struct OrderDetailDto:Decodable,Hashable{
    var colorCode: String?
    var colorName: String?
    var expirationDate: String?
    var groupName: String
    var lotNumber: String
    var makerName: String
    var paintName: String
    var price: Int?
    var specification: String?
    var useCategoryName: String?
    var warehouseName: String
    var weight: Double?
    var materialImgKey: String?
}

//注文情報
struct OrderDto:Decodable,Hashable{
    var id: Int
}

//支付情報
struct OrderPaymentDto:Decodable,Hashable{
    var status: String
}

//时间情報
struct TimeDto:Decodable,Hashable{
    var date: Int
    var day: Int
    var hours: Int
    var minutes: Int
    var month: Int
    var nanos: Int
    var seconds: Int
    var time: Int
    var timezoneOffset: Int
    var year: Int
}

//Chatroom
struct ChatroomDto:Decodable,Hashable{
    var id: Int
    var lastMessageAt: UInt64
    var owner: UserDto
    var paint: InventoryDto
    var participant: UserDto
    var displayGroupName:String
    var lastMessage: ListMessage?
    var unreadMessageCount: Int?
}


//メッセージ
struct MessageDto:Decodable,Hashable{
    var createdAt: UInt64
    var id: Int
    var messageSender: UserDto
    var readStatus: Int
    var text: String
    var type: Int
}

//owner
struct ChatroomDistinctDto:Decodable,Hashable{
    var groupByChatroomCount: Int
    var ownerId:Int
    var paint:InventoryDto
    //0：既読  1：未読
    var readStatus:Int?
}


//お気に入り
struct PaintLikeDto:Decodable,Hashable{
    var createdAt: UInt64
    var id: Int
    var paintDto: InventoryDto
    var updatedAt: UInt64
    var userDto: UserDto
    var deleted: Int
}

//履歴
struct PaintViewDto:Decodable,Hashable{
  //  var createdAt: UInt64
    var id: Int
    var paintDto: InventoryDto
  //  var updatedAt: UInt64
    var userDto: UserDto
}

//subscription
struct SubscriptionDto:Decodable,Hashable{
    var status: String
    var user: UserDto
    var stripeSubscriptionId: String
    var startAt: UInt64
    var endAt: UInt64
}

//user type
struct UserTypeDto:Decodable,Hashable{
    var userBind:[UserBindDto]
}

struct UserBindDto:Decodable,Hashable{
    var id: Int
    var type: Int
}

//chatroom orders
struct ChatroomOrdersDto:Decodable,Hashable{
    var id: Int
    var oderNo: String?
   // var orderStatus: String?
    var deliveryStatus: Int?
  //  var paymentStatus: String?
}

//リスト　メッセージ
struct ListMessage:Decodable,Hashable{
   // var createdAt: UInt64?
    var id: Int?
   // var messageSender: UserDto
    var readStatus: Int?
    var text: String?
    var type: Int?
}

//未読メッセージ数
struct MenuNoticeDto:Decodable,Hashable{
    var chatroomStatus:Int?
    var unReadCount: Int?
}

//振込先口座情報
struct TransferAccountDto:Decodable,Hashable{
    //var id: Int
    var bankName: String?
    var bankCode: String?
    var branchName: String?
    var branchCode: String?
    var depositTypeCode: String?
    var accountNo: String?
    var accountName: String?
}

//預金種目
struct MstDepositType:Decodable,Hashable{
    var id: Int
    var code: String
    var name: String
}
