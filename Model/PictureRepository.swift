//
//  PictureRepository.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 21/11/2021.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class PictureRepository: ObservableObject {

    func uploadPicture(image: UIImage, childRef: String, type: String) {
//        let storageRef = Storage.storage().reference().child(childRef)
//        if let uploadData = image.pngData() {
//            storageRef.putData(uploadData, metadata: nil) { _, error in
//                if error != nil {
//                    print("error")
//                    self.delegate?.uploadPictureFailed()
//                    return
//                } else {
//                    storageRef.downloadURL(completion: { url, _ in
//                        print(url!.absoluteString)
//                        var ref: DatabaseReference!
//                        ref = Database.database().reference()
//                        ref.child("Users").child(Auth.auth().currentUser!.uid).child(type).setValue("\(url!.absoluteString)")
//                        dataFile.profileImage = "\(url!.absoluteString)"
//                        let imageType = type == "icon" ? "profile" : "banner"
//                        self.delegate?.uploadPictureSucces(type: imageType)
//                    })
//                }
//            }
//        }
    }

}
