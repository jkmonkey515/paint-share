//
//  UrlConstants.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/27/21.
//

import Foundation
import AuthenticationServices

class UrlConstants {
    
    public static func isLoginNeeded(url: String) -> Bool {
        if url.starts(with: LOGIN) || url.starts(with: USER_NEW) || url.starts(with: USER_SEND_PASSWORD_RESET_EMAIL ) || url.starts(with: LINE_LOGIN) || url.starts(with: APPLE_LOGIN) || url.starts(with: APP_VERSION_NEEDS_UPDATE){
            return false
        } else {
            return true
        }
    }
    

//    public static let API_BASE_URL: String = "http://66.94.112.121:8080"
    //public static let API_BASE_URL: String = "http://192.168.0.124:8080"
    //public static let API_BASE_URL: String = "http://35.75.25.5"
    
    //public static let API_BASE_URL: String = "https://paint.lrdev03.click"
    
//    public static let API_BASE_URL: String = "https://paint-links.net"
    
#if DEBUG
    public static let API_BASE_URL: String = "https://paint.lrdev03.click"
#elseif RELEASE
    public static let API_BASE_URL: String = "https://paint-links.net"
#endif
    
    
    public static let LOGIN: String = API_BASE_URL + "/login"
    
    public static let LINE_LOGIN:String = API_BASE_URL + "/user/verify-line-login"
    
    public static let APPLE_LOGIN:String = API_BASE_URL + "/user/login-with-apple"
    
    public static let PAYMENT:String = API_BASE_URL+"/payment"
    
    public static let USER:String = API_BASE_URL+"/user"
    // 画像
    
    public static let IMAGE_NEW_IMAGEUPLOAD: String = API_BASE_URL + "/image/new-imageUpload"
    
    public static let IMAGE_SEARCH_IMAGEUPLOAD: String = API_BASE_URL + "/image/search-imageUpload-new"
    
    public static let IMAGE_GET_GROUPIMAGEUSESEARCHDTO: String = API_BASE_URL + "/image/get-groupImageUseSearchDto"
    
    public static let IMAGE_GET_GROUPIMAGESEARCHREMAININGCOUNT: String = API_BASE_URL + "/image/get-image-search-remaining-count"
    
//    public static let IMAGE_S3_ROOT:String = "https://paintshare-dev-s3.s3.ap-northeast-1.amazonaws.com/"
    
//    public static let IMAGE_S3_ROOT:String = "https://paint-prod-s3.s3.ap-northeast-1.amazonaws.com/"
    
#if DEBUG
    public static let IMAGE_S3_ROOT:String = "https://paintshare-dev-s3.s3.ap-northeast-1.amazonaws.com/"
#elseif RELEASE
    public static let IMAGE_S3_ROOT:String = "https://paint-prod-s3.s3.ap-northeast-1.amazonaws.com/"
#endif
    
    // ユーザー
    
    public static let USER_NEW: String = API_BASE_URL + "/user/new"
    
    public static let USER_GET_LOGGED_IN_USER: String = API_BASE_URL + "/user/get-logged-in-user"
    
    public static let USER_CHANGE_INFO: String = API_BASE_URL + "/user/change-info"
    
    public static let USER_SEND_PASSWORD_RESET_EMAIL = API_BASE_URL + "/user/send-password-reset-email"
    
    public static let USER_UPGRADE = API_BASE_URL + "/user/upgrade"
    
    public static let USER_GET_LOGGED_IN_USER_INFO_STATUS: String = API_BASE_URL + "/user/get-logged-in-user-info-status"
    
    public static let USER_SEND_REPORT_MESSAGE_MAIL:String = API_BASE_URL + "/user/send-report-message-mail"
    
    public static let USER_GET_LOGGED_IN_USER_SUBSCRIPTION:String = API_BASE_URL + "/user/get-logged-in-user-subscription"
    
    public static let USER_IS_DELETABLE:String = API_BASE_URL + "/user/is-deletable"
    
    public static let USER_DELETE_ACCOUNT:String = API_BASE_URL + "/user/delete-account"
    // グループ
    
    public static let GROUP: String = API_BASE_URL + "/group"
    
    public static let GROUP_GET_LOGGED_IN_USER_GROUP = API_BASE_URL + "/group/get-logged-in-user-group"
    
    public static let GROUP_SAVE: String = API_BASE_URL + "/group/save"
    
    public static let GROUP_DELETE: String = API_BASE_URL + "/group/delete-group"
    
    public static let GROUP_SEARCH: String = API_BASE_URL + "/group/search"
    
    public static let GROUP_SEARCH_DTO: String = API_BASE_URL + "/group/search-dto"
    
    public static let GROUP_ALL_DELETED_MEMBERS: String = API_BASE_URL + "/group/all-deleted-members"
    
    public static let GROUP_CHANGE_GROUP_APPROVE_STATUS: String = API_BASE_URL + "/group/change-group-approve-status"
    
    public static let GROUP_TOGGLE_GROUP_IMAGE_USE_STATUS: String = API_BASE_URL + "/group/toggle-group-image-use-status"
    
    // グループ関係
    
    public static let USER_GROUP_RELATION_NEW_REQUEST: String = API_BASE_URL + "/user-group-relation/new-request"
    
    public static let USER_GROUP_RELATION_REQUESTS: String = API_BASE_URL + "/user-group-relation/requests"
    
    public static let USER_GROUP_RELATION_CONFIRM_REQUEST: String = API_BASE_URL + "/user-group-relation/confirm-request"
    
    public static let USER_GROUP_RELATION_CANCEL_REQUEST_OR_REJECT = API_BASE_URL + "/user-group-relation/cancel-request-or-reject"
    
    public static let USER_GROUP_RELATION_QUIT = API_BASE_URL + "/user-group-relation/quit"
    
    public static let USER_GROUP_RELATION_DELETE_USER = API_BASE_URL + "/user-group-relation/delete-user"
    
    public static let USER_GROUP_RELATION_SEARCH_MEMBERS = API_BASE_URL + "/user-group-relation/search-members"
    
    public static let USER_GROUP_RELATION_MEMBERS_COUNT = API_BASE_URL + "/user-group-relation/members-count"
    
    public static let USER_GROUP_RELATION_BLOCK_USER = API_BASE_URL + "/user-group-relation/block-user"
    
    public static let USER_GROUP_RELATION_UNBLOCK_USER = API_BASE_URL + "/user-group-relation/unblock-user"
    
    public static let USER_GROUP_RELATION_DELETE_USER_SECONDTIME = API_BASE_URL + "/user-group-relation/delete-user-secondtime"
    
    public static let USER_GROUP_RELATION_ISRELATED = API_BASE_URL + "/user-group-relation/isRelated"
    
    // 評価
    
    public static let REVIEW_GET_FOR_LOGGED_IN: String = API_BASE_URL + "/review/get-for-logged-in"
    
    public static let REVIEW_SAVE: String = API_BASE_URL + "/review/save"
    
    public static let REVIEW_SEARCH: String = API_BASE_URL + "/review/search"
    
    // 在庫
    public static let PAINT: String = API_BASE_URL + "/paint"
    
    public static let PAINT_NEW: String = API_BASE_URL + "/paint/new"
    
    public static let PAINT_SEARCH_WITH_PAGING: String = API_BASE_URL + "/paint/search-with-paging-new"
    
    public static let PAINT_CHANGE_AMOUNT: String = API_BASE_URL + "/paint/change-amount"
    
    public static let PAINT_SAVE_CHANGE: String = API_BASE_URL + "/paint/save-change"
    
    public static let PAINT_GET_GROUP_LIST: String = API_BASE_URL + "/paint/get-group-list"
    
    public static let PAINT_GET_RELATION_GROUP_LIST: String = API_BASE_URL + "/paint/get-relation-group-list"
    
    public static let PAINT_GET_SEARCH_RELATION_GROUP_LIST: String = API_BASE_URL + "/paint/get-search-relation-group-list"
    
    public static let PAINT_EDIT_PROMISE: String = API_BASE_URL + "/paint/promise"
    
    public static let PAINT_APPROVE: String = API_BASE_URL + "/paint/approve"
    
    public static let PAINT_DELETE: String = API_BASE_URL + "/paint/delete"
    
    public static let PAINT_GET_COLOR_LIST: String = API_BASE_URL + "/paint/get-color-list"
    
    public static let PAINT_GET_OWNER_NOT_APPROVE_PAINT_LIST: String = API_BASE_URL + "/paint/get-owner-not-approve-paint-list"
    
    public static let PAINT_REMOVE_PAINT_FROM_SEATCH: String = API_BASE_URL + "/paint/remove-paint-from-search"//"/{paintId}"
    
    // マスター
    
    public static let MST: String = API_BASE_URL + "/mst"
    
    public static let MST_MAKERS: String = API_BASE_URL + "/mst/makers"
    
    public static let MST_MAKERS_WIDTH_JPMA: String = API_BASE_URL + "/mst/makers-with-jpma"
    
    public static let MST_USE_CATEGORIES: String = API_BASE_URL + "/mst/use-categories"
    
    public static let MST_GOODS_NAME: String = API_BASE_URL + "/mst/goods-names"
    
    public static let MST_MAKER_GOODS_NAME: String = "/goods-names"

    public static let MST_COLOR_NUMBER: String = API_BASE_URL + "/mst/color-numbers"
    
    // device token
    public static let DEVICE_TOKEN_SAVE: String = API_BASE_URL + "/device-token/save"
    
    public static let DEVICE_TOKEN_DELETE: String = API_BASE_URL + "/device-token/delete"
    
    // location
    public static let THIRD_PARTY_GET_LOCATION_DATA: String = API_BASE_URL + "/thirdparty/get-location-data"
    
    public static let THIRD_PARTY_GET_ADDRESS_BY_COORDINATE : String = API_BASE_URL + "/thirdparty/get-address-by-coordinate"
    
    //warehouse
    public static let WAREHOUSE:String = API_BASE_URL + "/warehouse"
    
    public static let WAREHOUSE_SAVE: String = API_BASE_URL + "/warehouse/save"
    
    public static let WAREHOUSE_SEARCH: String = API_BASE_URL + "/warehouse/search"
    
    public static let WAREHOUSE_DELETE: String = API_BASE_URL + "/warehouse/delete-warehouse"
    
    public static let WAREHOUSE_SEARCH_WAREHOUSEDTO: String = API_BASE_URL + "/warehouse/search-warehouseDto"
    
    //order
    public static let ORDER:String = API_BASE_URL + "/order"
    
    public static let ORDER_CHANGE_ORDER_STATUS: String = API_BASE_URL + "/order/change-order-status"
    
    public static let ORDER_CHANGE_DELIVERY_STATUS: String = API_BASE_URL + "/order/change-delivery-status"
    
    public static let ORDER_CHANGE_ORDER_WEIGHT: String = API_BASE_URL + "/order/change-order-weight"
    
    public static let ORDER_GET_GROUP_OWNER_ORDERS: String = API_BASE_URL + "/order/get-group-owner-orders"
    
    public static let ORDER_GET_USER_ORDERS: String = API_BASE_URL + "/order/get-user-orders"
    
    public static let ORDER_SAVE_ORDER: String = API_BASE_URL + "/order/save-order"
    
    public static let ORDER_GET_CHATROOM_ORDERS: String = API_BASE_URL + "/order/get-chatroom-orders"

    //chat
    public static let CHATROOM_SAVE: String = API_BASE_URL + "/chatroom/save"
    
    public static let CHATROOM_MESSAGE_SEND: String = API_BASE_URL + "/chatroom/message/send"
    
    public static let CHAATROOM_MESSAGE_GETLIST: String = API_BASE_URL + "/chatroom/message/getList"
    
    public static let CHATROOM_GET_PAINT_CHATROOM_LIST: String = API_BASE_URL + "/chatroom/get-paint-chatroom-list"
 
    public static let CHATROOM_CHECK_EXIST: String = API_BASE_URL + "/chatroom/check-exist"
    
    public static let CHATROOM_GET_PARTICIPANT_CHATROOM_LIST: String = API_BASE_URL + "/chatroom/get-participant-chatroom-list/"
    
    public static let CHATROOM_GET_DISTINCTCHATROOM_GROUPBY_CHATROOMLIST: String = API_BASE_URL + "/chatroom/get-distinctChatroom-groupBy-chatroomList"
    
    public static let CHATROOM_GET_DISTINCTCHATROOMLIST_BY_OWNER: String = API_BASE_URL + "/chatroom/get-distinctChatroomList-by-owner"
    
    public static let CHATROOM_MESSAGE_GET_UNREAD_COUNT: String = API_BASE_URL + "/chatroom/message/get-unread-count"
    
    public static let FILE_UPLOAD_IMAGE: String = API_BASE_URL + "/file-upload/upload"
    
    //お気に入り
    public static let PAINT_LIKE_PAINT:String = API_BASE_URL + "/paint/like-paint"
    
    public static let PAINT_VIEW_PAINT:String = API_BASE_URL + "/paint/view-paint"
    
    public static let PAINT_GET_LIKE_PAINT_LIST:String = API_BASE_URL + "/paint/get-likePaintList"
    
    public static let PAINT_GET_VIEW_PAINT_LIST:String = API_BASE_URL + "/paint/get-viewPaintList"
    
    public static let PAINT_GET_LIKE_PAINT:String = API_BASE_URL + "/paint/get-likePaintDto"
    
    //payment
    public static let PAYMENT_SAVE_CARD: String = API_BASE_URL + "/payment/save-card"
    
    public static let PAYMENT_SAVE_CARD_NEW: String = API_BASE_URL + "/payment/save-card-new"
    
   // public static let PAYMENT_DELETE_CARD: String = API_BASE_URL + "/payment/delete-card"
    
    public static let PAYMENT_CREAT_SUBSCRIPTION: String = API_BASE_URL + "/payment/create-subscription"
    
    public static let PAYMENT_CANCLE_SUBSCRIPTION: String = API_BASE_URL + "/payment/cancle-subscription"
    
    public static let PAYMENT_BIND_CUSTOMER: String = API_BASE_URL + "/payment/bind-customer"
    
    public static let PAYMENT_GET_CARD_LIST: String = API_BASE_URL + "/payment/get-card-list/"
    
    public static let PAYMENT_CREATE_ORDER_PAYMENT: String = API_BASE_URL + "/payment/create-order-payment"
    
    public static let PAYMENT_TOGGLE_SUBSCRIPTION: String = API_BASE_URL + "/payment/toggle-subscription"
    
    //振込先口座情報
    public static let TRANSFER_ACCOUNT: String = API_BASE_URL + "/transfer-account"
    
    public static let TRANSFER_ACCOUNT_IS_VALID: String = API_BASE_URL + "/transfer-account/is-valid"
    
    public static let MST_DEPOSIT_TYPES: String = API_BASE_URL + "/mst/deposit-types"
    
    public static let APP_VERSION_NEEDS_UPDATE: String = API_BASE_URL + "/app-version/needs-update"
}
