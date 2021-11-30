//
//  ImagePicker.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 21/11/2021.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
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
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
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
                var randomString: String {
                    let letters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"
                    return String((0 ..< 24).map { _ in letters.randomElement()! })
                }
                let childRef = parent.refPic == "" ? randomString + ".png" : parent.refPic
                PictureRepository.shared.uploadPicture(image: image, childRef: childRef)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}