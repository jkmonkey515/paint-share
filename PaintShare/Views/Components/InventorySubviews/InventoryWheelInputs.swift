//
//  InventoryWheelInputs.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/17/21.
//

import SwiftUI

struct InventoryWheelInputs: View {
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var orderConfirmDataModel: OrderConfirmDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var body: some View {
        // 在庫一覧用
        if inventorySearchDataModel.showPicker{
            CommonPicker(selection:$inventorySearchDataModel.selection,pickList: inventorySearchDataModel.pickList,onCancel:{
                inventorySearchDataModel.showPicker = false
            }, onCompleted: {
                inventorySearchDataModel.showPicker = false
                inventorySearchDataModel.setPickValue(pickId: inventorySearchDataModel.selection)
            })
        }
        // 在庫登録用
        if inventoryDataModel.showPicker{
            CommonPicker(selection:$inventoryDataModel.selection,pickList: inventoryDataModel.pickList,onCancel:{
                inventoryDataModel.showPicker = false
            },onCompleted: {
                inventoryDataModel.showPicker = false
                inventoryDataModel.setPickValue(pickId: inventoryDataModel.selection, dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
            })
        }
        if inventoryDataModel.showDatePicker{
            CommonDatePick(currentDate: $inventoryDataModel.expireDate,onCancel:{
                inventoryDataModel.showDatePicker = false
            },onCompleted: {
                inventoryDataModel.showDatePicker = false
                inventoryDataModel.expireDateStr = DateTimeUtils.dateToStr(date: inventoryDataModel.expireDate)
            })
        }
        if inventoryDataModel.showAmountPicker{
            CommonAmountPick(amountInteger: $inventoryDataModel.amountInteger, amountDecimal: $inventoryDataModel.amountDecimal,onCancel:{
                inventoryDataModel.showAmountPicker = false
            },onCompleted: {
                inventoryDataModel.showAmountPicker = false
                inventoryDataModel.setAmount(amountInteger: inventoryDataModel.amountInteger, amountDecimal: inventoryDataModel.amountDecimal)
            })
        }
        // 在庫照会用
        if inventoryInquiryDataModel.showAmountModal{
            ModalAmountPick(showModal: $inventoryInquiryDataModel.showAmountModal, showPick: $inventoryInquiryDataModel.showAmountPicker, onConfirm: {
                inventoryInquiryDataModel.changeAmount(dialogsDataModel: dialogsDataModel,inventorySearchDataModel: inventorySearchDataModel)
            },amountInteger: $inventoryInquiryDataModel.amountInteger, amountDecimal: $inventoryInquiryDataModel.amountDecimal, amountStr: inventoryInquiryDataModel.amount)
            
        }
        if inventoryInquiryDataModel.showWishModal{
            ModalAmountPick(isWish: true, showModal: $inventoryInquiryDataModel.showWishModal, showPick: $inventoryInquiryDataModel.showWishPicker, onConfirm: {
                inventoryInquiryDataModel.wishNumber = String(inventoryInquiryDataModel.wishNumberInteger) + "." + String(inventoryInquiryDataModel.wishNumberDecimal)
            },amountInteger: $inventoryInquiryDataModel.wishNumberInteger, amountDecimal: $inventoryInquiryDataModel.wishNumberDecimal, amountIsIntDecimalList: inventoryInquiryDataModel.maxFloat == 0 ? [0] : [0,inventoryInquiryDataModel.maxFloat], amountStr: inventoryInquiryDataModel.wishNumber, isInt: true, maxInt: inventoryInquiryDataModel.maxInt, maxFloat: inventoryInquiryDataModel.maxFloat)
        }
        if orderConfirmDataModel.showConfirmModal{
            ModalAmountPick(isWish: true, showModal: $orderConfirmDataModel.showConfirmModal, showPick: $orderConfirmDataModel.showConfirmPicker, onConfirm: {
                orderConfirmDataModel.confirmNumber = String(orderConfirmDataModel.confirmNumberInteger) + "." + String(orderConfirmDataModel.confirmNumberDecimal)
            },amountInteger: $orderConfirmDataModel.confirmNumberInteger, amountDecimal: $orderConfirmDataModel.confirmNumberDecimal, amountIsIntDecimalList: inventoryInquiryDataModel.maxFloat == 0 ? [0] : [0,inventoryInquiryDataModel.maxFloat], amountStr: orderConfirmDataModel.confirmNumber, isInt: true, maxInt: inventoryInquiryDataModel.maxInt, maxFloat: inventoryInquiryDataModel.maxFloat)
        }
        // 在庫編集用
        if inventoryEditDataModel.showPicker{
            CommonPicker(selection: $inventoryEditDataModel.selection,pickList: inventoryEditDataModel.pickList,onCancel:{
                inventoryEditDataModel.showPicker = false
            },onCompleted: {
                inventoryEditDataModel.showPicker = false
                inventoryEditDataModel.setPickValue(pickId: inventoryEditDataModel.selection, dialogsDataModel: dialogsDataModel)
            })
        }
        if inventoryEditDataModel.showDatePicker{
            CommonDatePick(currentDate: $inventoryEditDataModel.expireDate,onCancel:{
                inventoryEditDataModel.showDatePicker = false
            },onCompleted: {
                inventoryEditDataModel.showDatePicker = false
                inventoryEditDataModel.expireDateStr = DateTimeUtils.dateToStr(date: inventoryEditDataModel.expireDate)
            })
        }
        if inventoryEditDataModel.showAmountPicker{
            CommonAmountPick(amountInteger: $inventoryEditDataModel.amountInteger, amountDecimal: $inventoryEditDataModel.amountDecimal,onCancel:{
                inventoryEditDataModel.showAmountPicker = false
            },onCompleted: {
                inventoryEditDataModel.showAmountPicker = false
                inventoryEditDataModel.setAmount(amountInteger: inventoryEditDataModel.amountInteger, amountDecimal: inventoryEditDataModel.amountDecimal)
            })
        }
    }
}
