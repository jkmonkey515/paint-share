//
//  ImageLoader.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/15.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
        var data = Data() {
            didSet {
                didChange.send(data)
            }
        }

        init(urlString:String) {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.data = data
                }
            }
            task.resume()
        }
}
