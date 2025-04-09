//
//  AppDelegate.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI
import UserNotifications
import Stripe
import LineSDK
import FirebaseCore
import FirebaseMessaging
import RevenueCat

@main
struct PaintShareApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    //var dialogsDataModel = DialogsDataModel()
       var directionsDataModel = DirectionsDataModel()
       
      // var hamburgerMenuDataModel = HamburgerMenuDataModel()//
       
       var loginDataModel = LoginDataModel()
       
      // var mainViewDataModel = MainViewDataModel()
       
       var groupManagementDataModel = GroupManagementDataModel()
       
       var groupSearchDataModel = GroupSearchDataModel()
       
       var groupDetailInfoDataModel = GroupDetailInfoDataModel()
       
       var rankFormDataModel = RankFormDataModel()
       
       var allRanksDataModel = AllRanksDataModel()
       
       var requestFormDataModel = RequestFormDataModel()
       
       var groupInfoChangeDataModel = GroupInfoChangeDataModel()
       
       //var approvalWaitlistDataModel = ApprovalWaitlistDataModel()
       
       var memberManagementDataModel = MemberManagementDataModel()
       
       var requestDetailInfoDataModel = RequestDetailInfoDataModel()
       
       var accountManagementDataModel = AccountManagementDataModel()

       var registerDataModel = RegisterDataModel()
       
       var inventorySearchDataModel = InventorySearchDataModel()
       
       var colorSelectDataModel = ColorSelectDataModel()
       
       var inventoryDataModel = InventoryDataModel()
       
       var inventoryInquiryDataModel = InventoryInquiryDataModel()
       
       var inventoryEditDataModel = InventoryEditDataModel()
       
       var passwordResetDataModel = PasswordResetDataModel()
       
       var memberDetailInfoDataModel = MemberDetailInfoDataModel()
       
       var storeManager = StoreManager()
       
       var mailHasSendDataModel = MailHasSendDataModel()
       
       var agreementDataModel = AgreementDataModel()
       
       var goodsNameSelectDataModel = GoodsNameSelectDataModel()
       
       var cameraDetectDataModel = CameraDetectDataModel()
       
       var memberCancelDataModel = MemberCancelDataModel()

       var locationDataModel = LocationDataModel()//
       
       var tradingLocationDataModel=TradingLocationDataModel()//
       
       var warehouseInfoChangeDataModel=WarehouseInfoChangeDataModel()
       
       var inquiryFromDataModel=InquiryFromDataModel()
       
       var warehouseDataModel=WarehouseDataModel()
       
       var mapSearchDataModel = MapSearchDataModel()
       
       var inventorySellSetDataModel = InventorySellSetDataModel()
       
       var sellPrecautionsDataModel = SellPrecautionsDataModel()
       
       var inventoryApprovalDataModel = InventoryApprovalDataModel()
       
       var inventoryApprovalChangeDataModel = InventoryApprovalChangeDataModel()
       
       var locationHelper = LocationManager()
       
      // var inquiryListDataModel = InquiryListDataModel()
       
       var chatDataModel = ChatDataModel()
       
       var orderHistoryDataModel = OrderHistoryDataModel()
       
       var orderDetailsDataModel = OrderDetailsDataModel()
       
       var orderRegardDataModel = OrderRegardDataModel()
       
       var orderConfirmDataModel = OrderConfirmDataModel()
    
       var orderWishDataModel = OrderWishDataModel()
    
       var orderListDataModel = OrderListDataModel()
    
       var orderPaymentResultsDataModel = OrderPaymentResultsDataModel()
       
       var photographViewDataModel = PhotographViewDataModel()
       
    //   var inquiryManagementDataModel = InquiryManagementDataModel()
       
      // var inquiryUserDataModel = InquiryUserDataModel()

       var inputCreditCardInformationDataModel = InputCreditCardInformationDataModel()
       
       var creditCardManagementDataModel = CreditCardManagementDataModel()
       
       var chargeDataModel = ChargeDataModel()
       
       var paymentResultsDataModel = PaymentResultsDataModel()
       
       var browsingHistoryDataModel = BrowsingHistoryDataModel()
       
       var favoriteDataModel = FavoriteDataModel()
       
       var chargeCancellationDataModel = ChargeCancellationDataModel()
       
       var privacyPolicyDataModel = PrivacyPolicyDataModel()
    
       var managerViewDataModel = ManagerViewDataModel()

       var doUpdataDataModel = DoUpdataDataModel()
    
       var window: UIWindow?
    

    
//    let approvalWaitlistDataModel = (UIApplication.shared.delegate as! AppDelegate).approvalWaitListDataModel
//
//            let dialogsDataModel = (UIApplication.shared.delegate as! AppDelegate).dialogsDataModel
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.dialogsDataModel)
                                   .environmentObject(directionsDataModel)
                                   .environmentObject(appDelegate.hamburgerMenuDataModel)
                                   .environmentObject(loginDataModel)
                                   .environmentObject(appDelegate.mainViewDataModel)
                                   .environmentObject(groupManagementDataModel)
                                   .environmentObject(groupSearchDataModel)
                                   .environmentObject(groupDetailInfoDataModel)
                                   .environmentObject(rankFormDataModel)
                                   .environmentObject(allRanksDataModel)
                                   .environmentObject(requestFormDataModel)
                                   .environmentObject(groupInfoChangeDataModel)
                                   .environmentObject(appDelegate.approvalWaitListDataModel)
                                   .environmentObject(memberManagementDataModel)
                                   .environmentObject(requestDetailInfoDataModel)
                                   .environmentObject(accountManagementDataModel)
                                   .environmentObject(registerDataModel)
                                   .environmentObject(inventorySearchDataModel)
                                   .environmentObject(colorSelectDataModel)
                                   .environmentObject(inventoryDataModel)
                                   .environmentObject(inventoryInquiryDataModel)
                                   .environmentObject(inventoryEditDataModel)
                                   .environmentObject(passwordResetDataModel)
                                   .environmentObject(memberDetailInfoDataModel)
                                   .environmentObject(storeManager)
                                   .environmentObject(mailHasSendDataModel)
                                   .environmentObject(agreementDataModel)
                                   .environmentObject(goodsNameSelectDataModel)
                                   .environmentObject(cameraDetectDataModel)
                                   .environmentObject(memberCancelDataModel)
                                   .environmentObject(locationDataModel)//
                                   .environmentObject(tradingLocationDataModel)//
                                   .environmentObject(warehouseInfoChangeDataModel)
                                   .environmentObject(warehouseDataModel)
                                   .environmentObject(mapSearchDataModel)
                                   .environmentObject(locationHelper)
                                   .environmentObject(inventorySellSetDataModel)
                                   .environmentObject(sellPrecautionsDataModel)
                                   .environmentObject(inquiryFromDataModel)
                                   .environmentObject(inventoryApprovalDataModel)
                                   .environmentObject(inventoryApprovalChangeDataModel)
                                   .environmentObject(appDelegate.inquiryListDataModel)
                                   .environmentObject(chatDataModel)
                                   .environmentObject(orderHistoryDataModel)
                                   .environmentObject(orderDetailsDataModel)
                                   .environmentObject(orderRegardDataModel)
                                   .environmentObject(orderConfirmDataModel)
                                   .environmentObject(orderWishDataModel)
                                   .environmentObject(orderPaymentResultsDataModel)
                                   .environmentObject(orderListDataModel)
                                   .environmentObject(photographViewDataModel)
                                   .environmentObject(appDelegate.inquiryManagementDataModel)
                                   .environmentObject(appDelegate.inquiryUserDataModel)
                                   .environmentObject(inputCreditCardInformationDataModel)
                                   .environmentObject(creditCardManagementDataModel)
                                   .environmentObject(chargeDataModel)
                                   .environmentObject(paymentResultsDataModel)
                                   .environmentObject(browsingHistoryDataModel)
                                   .environmentObject(favoriteDataModel)
                                   .environmentObject(chargeCancellationDataModel)
                                   .environmentObject(privacyPolicyDataModel)
                                   .environmentObject(managerViewDataModel)
                                   .environmentObject(doUpdataDataModel)
                                   .onOpenURL { url in
                                       let _ = LoginManager.shared.application(.shared, open: url)
                                   }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate  {
    
    var approvalWaitListDataModel = ApprovalWaitlistDataModel()
    
    var inquiryManagementDataModel = InquiryManagementDataModel()
    
    var inquiryListDataModel = InquiryListDataModel()
    
    var hamburgerMenuDataModel = HamburgerMenuDataModel()
    
    var dialogsDataModel = DialogsDataModel()
    
    var mainViewDataModel = MainViewDataModel()
    
    var inquiryUserDataModel = InquiryUserDataModel()
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
         sleep(UInt32(2))
        // Override point for customization after application launch.
        
        //Ryu test apiKey
        
        //StripeAPI.defaultPublishableKey = "pk_test_51LPHeFIUXzCkBLLFUjBUQkdJUjenZcOL95RLd9cqvXHNQEc1rFykmKHOjymYKs2rW3vvmloH9K0pi9z9PwATgLDq00SN5G6Wqb"
//        StripeAPI.defaultPublishableKey = "pk_live_51Lq849F8M8I70qKcpVfEc1e9IaaQU1H8rXPs1cml0lFNfuQJ6F9fgFdAlqI79XABBU4BrU55e82c3bp6qeujj6DO00EhqSLxcG"
        #if DEBUG
                StripeAPI.defaultPublishableKey = "pk_test_51LPHeFIUXzCkBLLFUjBUQkdJUjenZcOL95RLd9cqvXHNQEc1rFykmKHOjymYKs2rW3vvmloH9K0pi9z9PwATgLDq00SN5G6Wqb"
        #elseif RELEASE
                StripeAPI.defaultPublishableKey = "pk_live_51Lq849F8M8I70qKcpVfEc1e9IaaQU1H8rXPs1cml0lFNfuQJ6F9fgFdAlqI79XABBU4BrU55e82c3bp6qeujj6DO00EhqSLxcG"
        #endif

        
        // Modify Config.xcconfig to setup your LINE channel ID 1656155359.
       
        //LoginManager.shared.setup(channelID: "1656155359", universalLinkURL: nil)
        #if DEBUG
                LoginManager.shared.setup(channelID: "1656155359", universalLinkURL: nil)
        #elseif RELEASE
                LoginManager.shared.setup(channelID: "1657468321", universalLinkURL: nil)
        #endif
        
        
        
        //RevenueCat.Purchases.configure(withAPIKey: "appl_vJvwZTKVdemisNHZscqdBgShWjs")
//        RevenueCat.Purchases.configure(withAPIKey: "appl_LhUdJMlnZKHpfcfIknglMniUBFJ")
        #if DEBUG
                RevenueCat.Purchases.configure(withAPIKey: "appl_vJvwZTKVdemisNHZscqdBgShWjs")
        #elseif RELEASE
                RevenueCat.Purchases.configure(withAPIKey: "appl_LhUdJMlnZKHpfcfIknglMniUBFJ")
        #endif
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in})
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
                
      //  application.applicationIconBadgeNumber = 0
        
        return true
    }
    

    
    // MARK: UISceneSession Lifecycle
    
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
    
//    func registerForPushNotifications() {
//        UNUserNotificationCenter.current()
//            .requestAuthorization(
//                options: [.alert, .sound, .badge]) { [weak self] granted, _ in
//                debugPrintLog(message:"Permission granted: \(granted)")
//                guard granted else { return }
//                self?.getNotificationSettings()
//            }
//    }
//
//    func getNotificationSettings() {
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//            debugPrintLog(message:"Notification settings: \(settings)")
//            guard settings.authorizationStatus == .authorized else { return }
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//        }
//    }
//
//    func application(
//        _ application: UIApplication,
//        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    ) {
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//        let token = tokenParts.joined()
//        debugPrintLog(message:"Device Token: \(token)")
//        DeviceTokenUtils.deviceToken = token
//        DeviceTokenUtils.saveDeviceToken()
//    }
//
//    func application(
//        _ application: UIApplication,
//        didFailToRegisterForRemoteNotificationsWithError error: Error
//    ) {
//        debugPrintLog(message:"Failed to register: \(error)")
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageId = userInfo[gcmMessageIDKey] {
            debugPrintLog(message:"Message ID: \(messageId)")
        }
        
        debugPrintLog(message:userInfo)
        
     //   application.applicationIconBadgeNumber = 0
     
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    //line
    func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool
    {
        return LoginManager.shared.application(application, open: url, options: options)
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
        return LoginManager.shared.application(application, open: userActivity.webpageURL)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrintLog(message:"Error registering Remote notification: \(error)")
    }
    
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        debugPrintLog(message:userInfo)
        
        if let messageId = userInfo[gcmMessageIDKey] {
            debugPrintLog(message:"Message ID: \(messageId)")
        }
        
        if userInfo["refreshApproval"] != nil {
            approvalWaitListDataModel.listRequests(dialogsDataModel: dialogsDataModel)
        }
        
        //chatroom message
        if userInfo["refreshUnreadMessage"] != nil {
            debugPrintLog(message:"!!!!!!")
            if (mainViewDataModel.loggedInUserGroup != nil) {
            hamburgerMenuDataModel.getOwnerUnreadMessage(dialogsDataModel: dialogsDataModel)
            inquiryManagementDataModel.getChatroomDistinctList(dialogsDataModel: dialogsDataModel)
            inquiryUserDataModel.getOwnerChatroomList(dialogsDataModel: dialogsDataModel)
            }
            inquiryListDataModel.getLoginUserParticipateChatroomList(dialogsDataModel: dialogsDataModel)
            hamburgerMenuDataModel.getUserUnreadMessage(dialogsDataModel: dialogsDataModel)
            dialogsDataModel.getUnreadMessageCounts()
        }
        
        completionHandler([[.banner, .badge, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let messageId = userInfo[gcmMessageIDKey] {
            debugPrintLog(message:"Message ID from userNotificationCenter didReceive: \(messageId)")
        }
        
        debugPrintLog(message:userInfo)
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        debugPrintLog(message:("Device token: ", deviceToken))
        
        DeviceTokenUtils.deviceToken = fcmToken
        DeviceTokenUtils.saveDeviceToken()
    }
}

extension View {
  func onAppCameToForeground(perform action: @escaping () -> Void) -> some View {
    self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
       action()
    }
  }

  func onAppWentToBackground(perform action: @escaping () -> Void) -> some View {
    self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
      action()
    }
  }}

