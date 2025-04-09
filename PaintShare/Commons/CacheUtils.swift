//
//  CacheUtils.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/10/21.
//

import SwiftUI
import Promises

class ImgCacheKey : NSObject {

    var id: Int

    var updatedAt: UInt64

    init(id: Int, updatedAt: UInt64) {
        self.id = id
        self.updatedAt = updatedAt
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? ImgCacheKey else {
            return false
        }
        return id == other.id && updatedAt == other.updatedAt
    }

    override var hash: Int {
        return id.hashValue ^ updatedAt.hashValue
    }
}

//class CacheUtils {
//    static let cache = NSCache<ImgCacheKey, UIImage>()
//
//    static func getImg(key: ImgCacheKey, dialogsDataModel: DialogsDataModel) -> Promise<UIImage?> {
//        let promise = Promise<UIImage?> {
//            fullfill, reject in
//            if let cachedVersion = CacheUtils.cache.object(forKey: key) {
//                // cache hit
//                fullfill(cachedVersion)
//            } else {
//                // load from server
//                getImgFromServer(key: key, dialogsDataModel: dialogsDataModel)
//                    .then {
//                        image in
//                        fullfill(image)
//                    }
//            }
//        }
//        return promise
//    }
    
//    static func getImgFromServer(key: ImgCacheKey, dialogsDataModel: DialogsDataModel) -> Promise<UIImage?>{
//        let promise = Promise<UIImage?> {
//            fullfill, reject in
//                UrlUtils.getRequest(url: UrlConstants.IMAGE + "/\(key.id)", type: ImageDto.self, dialogsDataModel: dialogsDataModel)
//                    .then {
//                        imageDto in
//                        if (imageDto == nil) {
//                            fullfill(nil)
//                        } else {
//                            let imageData = NSData(base64Encoded: imageDto!.imageData, options: .ignoreUnknownCharacters)
//                            let image = UIImage(data: imageData! as Data)
//                            cache.setObject(image!, forKey: key)
//                            fullfill(image)
//                        }
//                    }
//                    .catch {
//                        err in
//                        reject(err)
//                    }
//        }
//        return promise
//    }
// }
