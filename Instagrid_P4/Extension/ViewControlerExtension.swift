//
//  ViewControlerExtension.swift
//  Instagrid_P4
//
//  Created by arnaud kiefer on 05/05/2021.
//

import Foundation
import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    /// This function implements 2 protocols
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        insertSelectedImageInButton(selectedImage)
        dismiss(animated: true)
    }
} // End of extension ViewController
