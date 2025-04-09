//
//  Bodies.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/27/21.
//

import SwiftUI

struct EmptyBody: Encodable {
}

struct RegisterBody: Encodable {
    
    var email: String
    
    var password: String
    
    var passwordConfirm: String
    
    var checked: Bool
    
    var deviceToken: String?
}

struct PasswordResetBody: Encodable {
    
    var email: String
    
    var deviceToken: String?
}

struct LoginBody: Encodable {
    
    var email: String
    
    var password: String
}

struct UserUpdateBody: Encodable {
    
    var lastName: String
    
    var firstName: String
    
    var phone: String
    
    var email: String
    
    var password: String
    
    var profile: String
    
    var profileImgKey: String?
}

struct GroupBody: Encodable {
    
    var id: Int?
    
    var groupName: String
    
    var phone: String
    
    var description: String
    
    var groupImgKey: String?
    
    var groupPublic: Int
    
    var goodsPublic: Int
    
    var zipcode: String
    
    var prefecture: String
      
    var city: String
      
    var address: String
    
    var lat: Double
      
    var lng: Double
}

struct GroupRequestBody: Encodable {
    
    var isJoin: Bool
    
    var groupId: Int
    
    var message: String
}

struct ReviewBody: Encodable {
    
    var groupId: Int
    
    var score: Int?
    
    var content: String
    
    var questionOne: Int?
    
    var questionTwo: Int?
}

struct InventoryBody: Encodable {
    
    var id: Int?
    
    var ownedById: Int?
    
    var makerId: Int?
    
    var useCategoryId: Int?
    
    var goodsNameId: Int?
    
    var standardId: Int
    
    var colorNumberId: Int
    
    var otherColorName: String
    
    var isColor: Bool?
    
    var materialImgKey: String?
    
    var amount: Double?
    
    var expireDate: String
    
    var lotNumber: String
    
    var goodsPublic: Int
    
    var goodsNameName: String
    
    var price: String
    
    var weight: String
    
    var specification: String
    
    var goodsPlace: String?
    
    var goodsPlaceCodes: [String]?
    
    var approveStatus: String
    
    var saleFlag: Int
    
    var warehouseId: Int?
}

struct InventoryChangeAnountBody: Encodable {
    
    var id: Int?
    
    var amount: Double
}

struct DeviceTokenBody: Encodable {
    
    var token: String
}

struct WarehouseBody:Encodable{
    
    var id: Int?
    
    var name: String
    
    var zipcode: String
    
    var prefecture: String
    
    var city: String
    
    var address: String
    
}

struct SendMessageEmailBody:Encodable{
    
    var content:  String
    
    var reportId: String?
    
    var title: String
    
}

struct OrderWeightBody:Encodable{
    
    var orderId: Int
    
    var weight: String

}

struct OrderRegardBody:Encodable{
    
    var id:  Int
    
    var deliveryStatus: String?
    
    var orderStatus: String?
    
    var arrivalDate: String?
}

struct OrderConfirmBody:Encodable{
    
    var number: String
    
    var paintId: Int
    
}

struct OrderPaymentBody:Encodable{
    
    var orderId: Int
    
    var totalAmount: Int
    
}

struct ChatroomBody:Encodable{
    
    var paintId: Int
    
}

struct SendMessageBody:Encodable{
    
    var chatroomId: Int
    
    var readStatus: Int
    
    var text: String
    
    var type: Int
    
}

struct AppleLoginBody:Encodable{
    
    var appleUserId: String
    
    var firstName: String
    
    var lastName: String
    
    var email: String
}

struct CreateCardBody:Encodable{
    
    var token: String

}

struct CreateSubscriptionBody:Encodable{
    
    var stripePriceId: String

}

struct SubscriptionPriceBody:Encodable{
    
    var stripePriceId: String

}

struct imageParseUpload:Encodable{
    
    var txtString: String
    
}

//振込先口座情報
struct TransferAccountBody:Encodable{
   // var id: Int
    var bankName: String
    var bankCode: String
    var branchName: String
    var branchCode: String
    var depositTypeCode: String
    var accountNo: String
    var accountName: String
}

struct SubscriptionStatusBody:Encodable{
    var status: String
}
