//
//  Login.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI
import LineSDK
import StripeUICore
import AuthenticationServices

struct Login: View {
    
    @EnvironmentObject var loginDataModel: LoginDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var approvalWaitListDataModel: ApprovalWaitlistDataModel
    
    @EnvironmentObject var authorizationStore: AuthorizationStore
    
    @EnvironmentObject var hamburgerMenuDataModel:HamburgerMenuDataModel
    
    @EnvironmentObject var accountManagementDataModel: AccountManagementDataModel
    
    @EnvironmentObject var groupManagementDataModel: GroupManagementDataModel
    
    @EnvironmentObject var groupSearchDataModel: GroupSearchDataModel
    
    @EnvironmentObject var groupInfoChangeDataModel: GroupInfoChangeDataModel
    
    @EnvironmentObject var memberManagementDataModel: MemberManagementDataModel
    
    @EnvironmentObject var memberDetailInfoDataModel: MemberDetailInfoDataModel
    
    @EnvironmentObject var approvalWaitlistDataModel: ApprovalWaitlistDataModel
    
    @EnvironmentObject var groupDetailInfoDataModel: GroupDetailInfoDataModel
    
    @EnvironmentObject var rankFormDataModel: RankFormDataModel
    
    @EnvironmentObject var allRanksDataModel: AllRanksDataModel
    
    @EnvironmentObject var requestFormDataModel: RequestFormDataModel
    
    @EnvironmentObject var requestDetailInfoDataModel: RequestDetailInfoDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var chargeCancellationDataModel:ChargeCancellationDataModel
    
    @EnvironmentObject var colorSelectDataModel: ColorSelectDataModel
    
    @EnvironmentObject var goodsNameSelectDataModel: GoodsNameSelectDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel: InputCreditCardInformationDataModel
    
    @EnvironmentObject var cameraDetectDataModel: CameraDetectDataModel
    
  //  @State private var done: Bool=false
    
    var body: some View {
      
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        Spacer(minLength: 0)
                        
                        //---------Logo------------
                        VStack{
                            Image("app-icon")
                                .resizable()
                                .frame(width: 88.17, height: 70.82)
                                .padding(.top, 36)
                            Image("main_title_Image")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 216, height: 62)
                                .padding(.top, 5)
                        }
                        .padding(.top,36)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }
                        
                        //---------Line Login------------
                        LineLoginButton()
                            .onLoginSuccess { result in
                                debugPrintLog(message: result.accessToken.value)
                                loginDataModel.lineLogin(accesstoken: result.accessToken.value, mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, approvalWaitlistDataModel: approvalWaitListDataModel,hamburgerMenuDataModel: hamburgerMenuDataModel)
                            }
                            .onLoginFail { error in
                                debugPrintLog(message: error)
                                loginDataModel.showLineLoginFailed = true
                            }
                            .padding(.top,42)
                        
                        //---------Apple Login------------
                        SignInWithAppleButton(.signIn) { request in
                            request.requestedScopes = [.fullName, .email]
                        } onCompletion: { authResults in
                            switch authResults {
                            case .success(let authorization):
                                print("Apple Signed in")
                                guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                                    return
                                }
                                
                                let userId = credential.user
                                let firstName = credential.fullName?.givenName
                                let lastName = credential.fullName?.familyName

                                let email = credential.email
                                
                                debugPrintLog(message: "---------------------------");
                                debugPrintLog(message: email);
                                debugPrintLog(message: "---------------------------");
                                
                                loginDataModel.appleLogin(appleUserId: userId, firstName: firstName ?? "", lastName: lastName ?? "", email: email ?? "", mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, approvalWaitlistDataModel: approvalWaitListDataModel,hamburgerMenuDataModel: hamburgerMenuDataModel)
                                
                                
                                break
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        .signInWithAppleButtonStyle(.whiteOutline)
                        .frame(width: 200, height: 40)
                        .padding(.top, 16)
                        
                        //---------Or------------
                        VStack(spacing: 0){
                            ZStack{
                                Rectangle()
                                    .fill(Color(hex: "#E0E0E0"))
                                    .frame(width:323 ,height: 2)
                                
                                Rectangle()
                                    .fill(Color(hex: "ffffff"))
                                    .frame(width:78 ,height: 29)
                                
                                Text("または")
                                    .font(.bold20)
                                    .foregroundColor(Color(hex: "#46747E"))
                            }
                           // .frame(width: 60)
                            .padding(.top,39)
                            
                            //---------Login------------
                            CommonTextField(label: "ログインID", placeholder: "", font: .medium20, color: .black, value: $loginDataModel.loginId, validationMessage: loginDataModel.loginIdMessage)
                                .padding(.top, 28)
                                .padding(.horizontal, 55)
                            CommonSecureField(label: "パスワード", placeholder: "", font: .medium20, color: .black, value: $loginDataModel.password, validationMessage: loginDataModel.passwordMessage)
                                .padding(.top, 25.5)
                                .padding(.horizontal, 55)
                            HStack(spacing: 0.0) {
                                Spacer()
                                Text("パスワードをお忘れの方は")
                                    .font(.regular14)
                                    .foregroundColor(.mainText)
                                GeneralButton(onClick: {
                                    dialogsDataModel.loginNavigationTag = 3
                                }, label: {
                                    Text("こちら")
                                        .font(.regular14)
                                        .foregroundColor(.primary)
                                })
                            }
                            .padding(.horizontal, 55)
                            .padding(.top, 20.4)
                            Group{
                                NavigationLink(
                                    destination: MainView(), tag: 1, selection: $dialogsDataModel.loginNavigationTag) {
                                        EmptyView()
                                    }.isDetailLink(false)
                                NavigationLink(
                                    destination: Register(), tag: 2, selection: $dialogsDataModel.loginNavigationTag) {
                                        EmptyView()
                                    }.isDetailLink(false)
                                NavigationLink(
                                    destination: PasswordReset(), tag: 3, selection: $dialogsDataModel.loginNavigationTag) {
                                        EmptyView()
                                    }.isDetailLink(false)
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                            }
                            
                            //---------Mail Login------------
                                MailLoginButton(text: "メールアドレスでログイン", onClick:
                                                    {
                                    loginDataModel.login(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, approvalWaitlistDataModel: approvalWaitListDataModel,hamburgerMenuDataModel:hamburgerMenuDataModel)
                                    })
                                    .padding(.top, 38)
                            
                            //---------Sign up------------
                            HStack(spacing: 0.0) {
                                Text("メールで新規アカウント登録する場合は")
                                    .font(.regular14)
                                    .foregroundColor(.mainText)
                                GeneralButton(onClick: {
                                    dialogsDataModel.loginNavigationTag = 2
                                }, label: {
                                    Text("こちら")
                                        .font(.regular14)
                                        .foregroundColor(.primary)
                                })
                            }
                            .padding(.top, 52)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                        }
                    }
                    .padding(.bottom,83)
                    .opacity(loginDataModel.splashOpacity == 0.0 ? 1.0 : 0.0)
                    .frame(minHeight: UIScreen.main.bounds.height)
                    
                    Spacer(minLength: 100)
                }
//                VStack(spacing: 8) {
//                    Image("app-icon")
//                    Image("main_title_Image")
//                }
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .opacity( done ? 0:loginDataModel.splashOpacity)
                
            }
            .edgesIgnoringSafeArea(.all)
            .transition(.opacity)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .modal(isPresented: $dialogsDataModel.showErrorDialog) {
                ErrorModal(showModal: $dialogsDataModel.showErrorDialog, text: dialogsDataModel.errorMsg, onConfirm: {})
            }
            .modal(isPresented: $loginDataModel.showLoginStatusModal) {
                StatusModal(showModal: $loginDataModel.showLoginStatusModal, text: "ログイン中")
            }
            .modal(isPresented: $loginDataModel.showLineLoginFailed){
                ErrorModal(showModal: $loginDataModel.showLineLoginFailed, text: "Lineログイン中断", onConfirm: {})
            }
            .onAppear(perform: {
                // reset
                dialogsDataModel.freeUseUntil = 1
                dialogsDataModel.subscriptionDto = nil
                dialogsDataModel.mainViewNavigationTag = nil
                dialogsDataModel.showPaymentDialog = false
                mainViewDataModel.reset()
                groupManagementDataModel.reset()
                groupSearchDataModel.reset()
                groupInfoChangeDataModel.reset()
                memberManagementDataModel.reset()
                memberDetailInfoDataModel.reset()
                approvalWaitlistDataModel.reset()
                groupDetailInfoDataModel.reset()
                rankFormDataModel.reset()
                allRanksDataModel.reset()
                requestFormDataModel.reset()
                requestDetailInfoDataModel.reset()
                accountManagementDataModel.reset()
                inventorySearchDataModel.reset()
                inventoryDataModel.reset()
                inventoryInquiryDataModel.reset()
                inventoryEditDataModel.reset()
                colorSelectDataModel.reset()
                goodsNameSelectDataModel.reset()
                inputCreditCardInformationDataModel.isBindCustomer = false
                dialogsDataModel.UnreadMessage = 0
                cameraDetectDataModel.changeQueue = 0
                cameraDetectDataModel.reset()
              //  DispatchQueue.main.asyncAfter(deadline:.now()+2){
                loginDataModel.loginId = ""
                loginDataModel.password = ""
                loginDataModel.loadLoggedInToken(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, approvalWaitlistDataModel: approvalWaitListDataModel,hamburgerMenuDataModel: hamburgerMenuDataModel)
                mainViewDataModel.dialogsDataModel = dialogsDataModel
                 //   done = true
                //}
            })
        
    }
}
