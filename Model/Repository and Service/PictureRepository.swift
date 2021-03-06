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
import FirebaseStorage

final class PictureRepository {
    
    private let ref = Database.database(url: Constantes.refURL).reference()

    func uploadPicture(image: UIImage, childRef: String) {
        let storageRef = Storage.storage().reference().child(childRef)
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil) { _, error in
                if error != nil {
                    return
                } else {
                    storageRef.downloadURL(completion: { url, _ in
                        self.ref.child("Users").child(Auth.auth().currentUser!.uid).child("Picture").setValue("\(url!.absoluteString)")
                        self.ref.child("Users").child(Auth.auth().currentUser!.uid).child("RefPic").setValue("\(childRef)")
                    })
                }
            }
        }
    }

}
