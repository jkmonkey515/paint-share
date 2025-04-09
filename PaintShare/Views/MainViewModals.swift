//
//  MainViewModals.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/21/21.
//

import SwiftUI

struct MainViewModals: View {
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupManagementDataModel: GroupManagementDataModel
    
    @EnvironmentObject var memberDetailInfoDataModel: MemberDetailInfoDataModel
    
    @EnvironmentObject var approvalWaitlistDataModel: ApprovalWaitlistDataModel
    
    @EnvironmentObject var groupDetailInfoDataModel: GroupDetailInfoDataModel
    
    @EnvironmentObject var requestFormDataModel: RequestFormDataModel
    
    @EnvironmentObject var groupSearchDataModel: GroupSearchDataModel
    
    @EnvironmentObject var rankFormDataModel: RankFormDataModel
    
    @EnvironmentObject var requestDetailInfoDataModel: RequestDetailInfoDataModel
    
    @EnvironmentObject var allRanksDataModel: AllRanksDataModel
    
    @EnvironmentObject var accountManagementDataModel: AccountManagementDataModel
    
    @EnvironmentObject var groupInfoChangeDataModel: GroupInfoChangeDataModel
    
    @EnvironmentObject var memberManagementDataModel: MemberManagementDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var colorSelectDataModel: ColorSelectDataModel
    
    @EnvironmentObject var goodsNameSelectDataModel: GoodsNameSelectDataModel
    
    @EnvironmentObject var memberCancelDataModel: MemberCancelDataModel
    
    @EnvironmentObject var cameraDetectDataModel: CameraDetectDataModel
    
    @EnvironmentObject var warehouseDataModel:WarehouseDataModel
    
    @EnvironmentObject var inquiryFromDataModel:InquiryFromDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var orderConfirmDataModel:OrderConfirmDataModel
    
    @EnvironmentObject var chargeCancellationDataModel:ChargeCancellationDataModel
    
    @EnvironmentObject var managerViewDataModel:ManagerViewDataModel
    
    @EnvironmentObject var orderListDataModel:OrderListDataModel
    
    @EnvironmentObject var favoriteDataModel:FavoriteDataModel
    
    @EnvironmentObject var doUpdataDataModel:DoUpdataDataModel
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        EmptyView()
            .modal(isPresented: $dialogsDataModel.showChargeView, disableDismiss: true) {
                ChargeView(showModal: $dialogsDataModel.showChargeView)
            }
            .modal(isPresented: $dialogsDataModel.showChargeCancellationView, disableDismiss: true) {
                ChargeCancellationView(showModal: $dialogsDataModel.showChargeCancellationView)
            }
            .modal(isPresented: $dialogsDataModel.showErrorDialog) {
                ErrorModal(showModal: $dialogsDataModel.showErrorDialog, text: dialogsDataModel.errorMsg, onConfirm: {})
            }
            .modal(isPresented: $inputCreditCardInformationDataModel.showErrorDialog) {
                ErrorModal(showModal: $inputCreditCardInformationDataModel.showErrorDialog, text:inputCreditCardInformationDataModel.stripeErrorMessage, onConfirm: {})
            }
            .modal(isPresented: $inputCreditCardInformationDataModel.showCardRegisterError) {
                ErrorModal(showModal: $inputCreditCardInformationDataModel.showCardRegisterError, text: "登録に失敗しました。ご入力のカード情報をご確認ください。", onConfirm: {})
            }
            .modal(isPresented: $mainViewDataModel.showAccountNotFinishedDialog) {
                ErrorModal(showModal: $mainViewDataModel.showAccountNotFinishedDialog, text: "本アプリのご利用のため、アカウント情報をご記入ください", onConfirm: {})
            }
            .modal(isPresented: $mainViewDataModel.showNoGroupDialog) {
                ErrorModal(showModal: $mainViewDataModel.showNoGroupDialog, text: mainViewDataModel.showNoGroupDialogMessage, onConfirm: {})
            }
            .modal(isPresented: $requestFormDataModel.showConfirmDialog) {
                ConfirmModal(showModal: $requestFormDataModel.showConfirmDialog, text: requestFormDataModel.confirmDialogMessage, onConfirm: {
                    requestFormDataModel.sendRequest(dialogsDataModel: dialogsDataModel, groupSearchDataModel: groupSearchDataModel)
                })
            }
            .modal(isPresented: $requestFormDataModel.showRequestSuccessDialog) {
                NotifyModal(showModal: $requestFormDataModel.showRequestSuccessDialog, text: "申請をしました\n承認されるまでお待ちください", onConfirm: {})
            }
            .modal(isPresented: $dialogsDataModel.showSavedDialog) {
                NotifyModal(showModal: $dialogsDataModel.showSavedDialog, text: "保存しました", onConfirm: {})
            }
            .modal(isPresented: $dialogsDataModel.showFirstTimeSavedDialog, disableDismiss: true) {
                NotifyModal(showModal: $dialogsDataModel.showFirstTimeSavedDialog, text: "ご登録ありがとうございます\n導入のご案内ページへ遷移します", onConfirm: {
                    dialogsDataModel.mainViewNavigationTag = 1
                })
            }
            .modal(isPresented: $dialogsDataModel.showEditDialog) {
                NotifyModal(showModal: $dialogsDataModel.showEditDialog, text: dialogsDataModel.editDialogText, onConfirm: {})
            }
            .modal(isPresented: $inquiryFromDataModel.showSendedDialog) {
                NotifyModal(showModal: $inquiryFromDataModel.showSendedDialog, text: "お問い合わせ内容を送信しました", onConfirm: { })
            }
            .modal(isPresented: $inputCreditCardInformationDataModel.showCreateCardDialog) {
                NotifyModal(showModal: $inputCreditCardInformationDataModel.showCreateCardDialog, text: "カードを登録しました", onConfirm: { })
            }
            .modal(isPresented: $inventoryDataModel.showRegisteredDialog) {
                NotifyModal(showModal: $inventoryDataModel.showRegisteredDialog, text: "登録しました。", onConfirm: {
                    inventoryDataModel.reset()
                })
            }
            .modal(isPresented: $rankFormDataModel.showSaveReviewDialog) {
                NotifyModal(showModal: $rankFormDataModel.showSaveReviewDialog, text: "評価を更新しました", onConfirm: {
                    groupDetailInfoDataModel.navigationTag = nil
                    chatDataModel.navigationTag = nil
                })
            }
            .modal(isPresented: $managerViewDataModel.showSavedDialog) {
                NotifyModal(showModal: $managerViewDataModel.showSavedDialog, text: "登録しました。", onConfirm: {
                   // dialogsDataModel.mainViewNavigationTag = nil
                })
            }
            .modal(isPresented: $inventoryInquiryDataModel.showPaintDeletedDialog) {
                NotifyModal(showModal: $inventoryInquiryDataModel.showPaintDeletedDialog, text: "こちらの在庫は\n見つかりませんでした。", onConfirm: {
                })
            }
            .modal(isPresented: $inventoryInquiryDataModel.showPaintFavoriteDeletedDialog) {
                ConfirmModal(showModal: $inventoryInquiryDataModel.showPaintFavoriteDeletedDialog, text: "こちらの在庫は\n見つかりませんでした。\nお気に入りから削除しますか？", onConfirm: {
                    favoriteDataModel.savePaintLike(dialogsDataModel: dialogsDataModel)
                    favoriteDataModel.searchFromZeroPage( dialogsDataModel: dialogsDataModel)
                },confirmText: "はい", cancelText: "いいえ")
            }
            .modal(isPresented: $groupSearchDataModel.showExitConfirmDialog) {
                ConfirmModal(showModal: $groupSearchDataModel.showExitConfirmDialog, text: groupSearchDataModel.groupExitConfirmMessage, onConfirm: {
                    groupSearchDataModel.quitGroup(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                })
            }
            .modal(isPresented: $approvalWaitlistDataModel.showDeleteConfirmDialog) {
                ConfirmModal(showModal: $approvalWaitlistDataModel.showDeleteConfirmDialog, text: "削除してよろしいですか？", onConfirm: {
                    approvalWaitlistDataModel.delete(dialogsDataModel: dialogsDataModel)
                })
            }
            .modal(isPresented: $memberManagementDataModel.showDeleteConfirmDialog) {
                ConfirmModal(showModal: $memberManagementDataModel.showDeleteConfirmDialog, text: "削除してよろしいですか？", onConfirm: {
                    memberManagementDataModel.delete(dialogsDataModel: dialogsDataModel)
                })
            }
            .modal(isPresented: $dialogsDataModel.imageDeleteDialog) {
                ConfirmModal(showModal: $dialogsDataModel.imageDeleteDialog, text: "削除してよろしいですか？", onConfirm: {
                    dialogsDataModel.resetImage(accountManagementDataModel: accountManagementDataModel, groupInfoChangeDataModel: groupInfoChangeDataModel, inventoryDataModel: inventoryDataModel, inventoryEditDataModel: inventoryEditDataModel)
                })
            }
            .modal(isPresented: $warehouseDataModel.showCantDeleteNoti) {
                NotifyModal(showModal: $warehouseDataModel.showCantDeleteNoti, text: "在庫登録がある倉庫は\n削除できません。", onConfirm: { })
            }
            .modal(isPresented: $warehouseDataModel.showDeleteWarehouse) {
                ConfirmModal(showModal: $warehouseDataModel.showDeleteWarehouse, text: "削除してよろしいですか？", onConfirm: {
                    warehouseDataModel.deleteWarehouse(dialogsDataModel: dialogsDataModel)
                })
            }
//            .modal(isPresented: $inputCreditCardInformationDataModel.showDeleteCardDialog) {
//                ConfirmModal(showModal: $inputCreditCardInformationDataModel.showDeleteCardDialog, text: "削除してよろしいですか？", onConfirm: {
//                    inputCreditCardInformationDataModel.deleteCard(dialogsDataModel: dialogsDataModel)
//                    dialogsDataModel.mainViewNavigationTag = nil
//                })
//            }
            .modal(isPresented: $inventoryInquiryDataModel.showDeletePaintDialog) {
                ConfirmModal(showModal: $inventoryInquiryDataModel.showDeletePaintDialog, text: "こちらの在庫を削除しますか？\n削除後は元に戻せません", onConfirm: {
                    inventoryInquiryDataModel.paintDelete(dialogsDataModel: dialogsDataModel, inventorySearchDataModel: inventorySearchDataModel, id: inventoryInquiryDataModel.id)
                },confirmText: "はい", cancelText: "いいえ")
            }
            .modal(isPresented: $chargeCancellationDataModel.showUnsubscribeDialog) {
                ConfirmModal(showModal: $chargeCancellationDataModel.showUnsubscribeDialog, text: "本当に解約してよろしいですか？", onConfirm: {
                    chargeCancellationDataModel.cancellingSubscriptions(dialogsDataModel: dialogsDataModel)
                })
            }
            .modal(isPresented: $inventoryDataModel.showNewConfirmDialog) {
                ConfirmModal(showModal: $inventoryDataModel.showNewConfirmDialog, text: "登録してよろしいですか？", onConfirm: {
                    inventoryDataModel.saveAndUploadImage(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                })
            }
            .modal(isPresented: $dialogsDataModel.tooltipDialog) {
                TooltipModal(showModal: $dialogsDataModel.tooltipDialog, title: dialogsDataModel.tooltipTitle, description: dialogsDataModel.tooltipDescription)
            }
            .modal(isPresented: $chatDataModel.showSendBankNumberDialog) {
                ConfirmModal(showModal: $chatDataModel.showSendBankNumberDialog, text: "銀行口座情報や金額変更等のやりとりは禁止されています。\n送付いたしますか？", onConfirm: {
                    chatDataModel.sendChatMessage(mainViewDataModel:  mainViewDataModel,type:0,content: chatDataModel.chatText,dialogsDataModel: dialogsDataModel,needNumberCheck: false)
                })
            }
            .modal(isPresented: $inputCreditCardInformationDataModel.tooltipDialog) {
                TooltipModal(showModal: $inputCreditCardInformationDataModel.tooltipDialog, title: inputCreditCardInformationDataModel.tooltipTitle, description: inputCreditCardInformationDataModel.tooltipDescription)
            }
            .modal(isPresented: $accountManagementDataModel.showLogoutConfirmDialog) {
                ConfirmModal(showModal: $accountManagementDataModel.showLogoutConfirmDialog, text: "ログアウトしてよろしいですか？", onConfirm: {
                    accountManagementDataModel.logout(dialogsDataModel: dialogsDataModel)
                })
            }
            .modal(isPresented: $dialogsDataModel.showConfirmAccountDeleteDialog) {
                ConfirmModal(showModal: $dialogsDataModel.showConfirmAccountDeleteDialog, text: "アカウントを削除しても\nよろしいでしょうか？\n\n削除した場合、在庫、チャット履歴、\nチーム・フレンド、支払い情報\nがすべて失われます", onConfirm: {
                    accountManagementDataModel.deleteAccount(dialogsDataModel: dialogsDataModel)
                }, frameHeight: 371, textXPadding: 10)
            }
            .modal(isPresented: $dialogsDataModel.showConfirmGroupDeleteDialog) {
                ConfirmModal(showModal: $dialogsDataModel.showConfirmGroupDeleteDialog, text: "グループ削除をしても\nよろしいでしょうか？\n\n削除した場合、在庫、チャット履歴、\nチーム・フレンド、支払い情報\nがすべて失われます", onConfirm: {
                    groupInfoChangeDataModel.deleteGroup(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, groupManagementDataModel: groupManagementDataModel)
                }, frameHeight: 371, textXPadding: 10)
            }
            .modal(isPresented: $inventoryEditDataModel.showEditConfirmDialog) {
                ConfirmModal(showModal: $inventoryEditDataModel.showEditConfirmDialog, text: "更新してよろしいですか？", onConfirm: {
                    inventoryEditDataModel.saveAndUploadImage(dialogsDataModel: dialogsDataModel, inventorySearchDataModel: inventorySearchDataModel, inventoryInquiryDataModel: inventoryInquiryDataModel)
                })
            }
            .modal(isPresented: $dialogsDataModel.showLargeImage) {
                ImageModal(showModal: $dialogsDataModel.showLargeImage, logoImage: dialogsDataModel.largeImage)
            }
            .modal(isPresented: $memberCancelDataModel.showBlock) {
                DefiniteModal(showModal: $memberCancelDataModel.showBlock, title: "このユーザーをブロックしますか？", content: "ブロックしたユーザーからは、あなたのグループ情報や在庫情報などが一切見れなくなります。") {
                    memberCancelDataModel.block(dialogsDataModel: dialogsDataModel)
                }
            }
            .modal(isPresented: $memberCancelDataModel.showRemove) {
                DefiniteModal(showModal: $memberCancelDataModel.showRemove, title: "このユーザーを削除しますか？", content: "ブロックしたユーザーを削除するとブロックは解除され、あなたのグループ情報や在庫情報が検索できるようになります。") {
                    memberCancelDataModel.delete(dialogsDataModel: dialogsDataModel)
                }
            }
            .modal(isPresented: $cameraDetectDataModel.showCameraNoti) {
                CameraModal(showModal: $cameraDetectDataModel.showCameraNoti, text: "注意事項", onConfirm: {
                    
                })
            }
            .modal(isPresented: $orderConfirmDataModel.showPayNoti) {
                ErrorModal(showModal: $orderConfirmDataModel.showPayNoti, text: "合計金額を 0 にすることはできません。", onConfirm: {
                    orderConfirmDataModel.showPayNoti = false
                })
            }
            .modal(isPresented: $dialogsDataModel.showNumberOnlyDialog) {
                ErrorModal(showModal: $dialogsDataModel.showNumberOnlyDialog, text: "数量を入力してください", onConfirm: {
                    dialogsDataModel.showNumberOnlyDialog = false
                })
            }
            .modal(isPresented: $dialogsDataModel.showPriceNoti) {
                ErrorModal(showModal: $dialogsDataModel.showPriceNoti, text: "金額は100円以上で設定をしてください。", onConfirm: {
                    dialogsDataModel.showPriceNoti = false
                })
            }
            .modal(isPresented: $orderConfirmDataModel.showConfirmNoti) {
                ConfirmModal(showModal: $orderConfirmDataModel.showConfirmNoti, text: "ご注文を確定しますか？", onConfirm: {
                    orderConfirmDataModel.showConfirmNoti = false
                   // if orderConfirmDataModel.free == true {
                    //}else{
                    orderConfirmDataModel.confirm(totalAmount: Int(String(format:"%.0f",(Float(inventoryInquiryDataModel.priceValue.filter{$0 != ","}) ?? 0)*(Float(orderConfirmDataModel.confirmNumber) ?? 0))) ?? 0, number: String(orderConfirmDataModel.confirmNumber), paintId: inventoryInquiryDataModel.id, dialogsDataModel: dialogsDataModel)
                    //}
                })
            }
            .modal(isPresented: $managerViewDataModel.showSavedManagerInfoDialog) {
                DefiniteModal(showModal: $managerViewDataModel.showSavedManagerInfoDialog, title: "お振込み先情報に\nお間違いはありませんか？", content: "誤った場合の訂正の手数料等はご負担いただいております。",color: Color(hex: "#F16161"),confirmButtonText: "確定する") {
                    managerViewDataModel.saveManagerInfo(dialogsDataModel: dialogsDataModel)

                }
            }
            .modal(isPresented: $doUpdataDataModel.showUpdate, disableDismiss: true) {
                NotifyModal(showModal: $doUpdataDataModel.showUpdate, text: doUpdataDataModel.updateText, onConfirm: {
                    openURL(URL(string: "https://apps.apple.com/jp/app/paintlinks/id6450660802")!)
                })
            }
            .modal(isPresented: $groupInfoChangeDataModel.showGroupCreatedDialog) {
                NotifyModal(showModal: $groupInfoChangeDataModel.showGroupCreatedDialog, text: " 保存しました\n次は「倉庫管理」より\n倉庫の登録をしてください", onConfirm: {
                    // go to「倉庫管理」
                    dialogsDataModel.mainViewNavigationTag = 23
                })
            }
    }
}
