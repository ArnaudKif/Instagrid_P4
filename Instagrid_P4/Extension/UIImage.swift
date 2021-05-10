//
//  UIImage.swift
//  Instagrid_P4
//
//  Created by arnaud kiefer on 05/05/2021.
//

import Foundation
import UIKit

extension UIView {

    /// transforms an object into a UIImage
    func extensionAsImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    } // End of extensionAsImage()

}// End of extension UIView
