//
//  StoreManager.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/8/21.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var dialogsDataModel: DialogsDataModel?
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        debugPrintLog(message:"Did receive response")
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    //self.products.append(fetchedProduct)
                    self.product = fetchedProduct
                }
            }
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            debugPrintLog(message:"Invalid identifiers found: \(invalidIdentifier)")
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        debugPrintLog(message:"Request did fail: \(error)")
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            debugPrintLog(message:"User can't make payment.")
        }
    }
    
    @Published var transactionState: SKPaymentTransactionState?
    
    // @Published var products = [SKProduct]()
    
    @Published var product: SKProduct?
    
    var request: SKProductsRequest!
    
    func getProducts(productIDs: [String]) {
        debugPrintLog(message:"Start requesting products ...")
        //products.removeAll()
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                upgradeUser()
                //UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                //UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .restored
            case .failed, .deferred:
                debugPrintLog(message:"Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                transactionState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func restoreProducts() {
        debugPrintLog(message:"Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func upgradeUser() {
        UrlUtils.postRequest(url: UrlConstants.USER_UPGRADE, body: EmptyBody(), dialogsDataModel: dialogsDataModel!)
            .then {
                DispatchQueue.main.async {
                    self.dialogsDataModel!.showPaymentDialog = false
                }
            }
    }
}
