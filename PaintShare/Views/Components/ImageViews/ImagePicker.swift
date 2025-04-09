//
//  ImagePicker.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/15/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    var from: Int = 0//0、default. 1、cameraDetect
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                if parent.from == 1 {
                    parent.image = uiImage
                }else{
                    parent.image = uiImage.scalePreservingAspectRatio(targetSize: CGSize(width: 200, height: 200))
                }
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
