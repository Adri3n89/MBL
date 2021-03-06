//
//  ImagePicker.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 21/11/2021.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    var pictureRepo = PictureRepository()
    var sourceType: UIImagePickerController.SourceType
    var refPic: String
    
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false

        imagePicker.sourceType = sourceType == .camera ? .camera : .photoLibrary

        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, refPic: refPic)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker, refPic: String) {
            self.parent = parent
            self.parent.refPic = refPic
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let childRef = parent.refPic == "" ? String().imageName() + ".png" : parent.refPic
                parent.pictureRepo.uploadPicture(image: image.aspectFittedToHeight(100), childRef: childRef)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
