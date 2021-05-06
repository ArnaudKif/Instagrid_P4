//
//  ViewController.swift
//  Instagrid_P4
//
//  Created by arnaud kiefer on 26/04/2021.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - @IBOutlets

    @IBOutlet weak var swipeView: UIStackView!
    @IBOutlet weak var swipeImageView: UIStackView!
    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet var imageButton: [UIButton]!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var photoView: UIView!

    // MARK: - Class Properties

    private var touchedButton: UIButton!
    private let myImagePickerController = UIImagePickerController()
    private var indexOfColor = 0
    private var firstStart = true
    private var swipeGesture: UISwipeGestureRecognizer?

    // MARK: - override func viewDidLoad, viewDidLayoutSubviews & viewWillTransition

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonIsPresent(button: imageButton[1])
        buttonIsNotPresent(button: imageButton[3])
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        guard let swipeGesture = swipeGesture else { return }
        swipeView.addGestureRecognizer(swipeGesture)
        swipeImageView.addGestureRecognizer(swipeGesture)
    } // End of override func viewDidLoad

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if firstStart {
            firstStart = false
            detectOrientation()
        }
    } // End of ViewDidLayoutSubviews

/// This function checks the orientation of the phone at each change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        detectOrientation()
    } // End of viewWillTransition

    // MARK: - @IBActions

    @IBAction func layoutTouched(_ sender: UIButton) {
        layoutButtonTouched(buttonTouched: sender)
    }// End of func layoutTouched

    @IBAction func imageButtonTouched(_ sender: UIButton) {
        touchedButton = sender
        openPhotoLibrary()
    } // End of imageButtonTouched

    @IBAction func switchColorView(_ sender: Any) {
chooseColorBackground()
    }// End of switchColorView

    // MARK: - Class methods for the swipe and the share actions

/// set the swipe direction according to the screen orientation
    private func detectOrientation() {
        if UIDevice.current.orientation.isLandscape {
            swipeGesture?.direction = .left
        } else {
            swipeGesture?.direction = .up
        }
    } // End of detectOrientation

    /// manages the animation during the swipe and calls the share function
    @objc private func swipeAction() {
        if swipeGesture?.direction == .up {
            UIView.animate(withDuration: 0.5, animations: { self.photoView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)}, completion: {_ in
                self.share()
            })
            } else {
                UIView.animate(withDuration: 0.5, animations: { self.photoView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)}, completion: {_ in
                    self.share()
                })

            }
    } // End of swipeAction

    /// Create the image to share and launch the UIActivityViewControler
    private func share() {
        let image = photoView.ExtensionasImage()
//        guard let image = photoView.ExtensionasImage() else { return }
        let activityViewControler = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewControler, animated: true)
        activityViewControler.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5) {
                self.photoView.transform = .identity
            }
        }
    } // End of share

    // MARK: - Class methods for the layout management

    /// Depending on the button touched, adds the Selected image and changes the layout of the photos
    private func layoutButtonTouched(buttonTouched: UIButton) {
        for butt in layoutButtons {
            self.removeButtonImage(button: butt)
        }
        buttonTouched.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        for imagebutt in imageButton {
            buttonIsPresent(button: imagebutt)
        }
        if buttonTouched.tag == 1 {
            buttonIsNotPresent(button: imageButton[1])
        }
        if buttonTouched.tag == 2 {
            buttonIsNotPresent(button: imageButton[3])
        }
    } // End of layoutButtonTouched

    /// displays and activates the button
    private func buttonIsPresent(button: UIButton) {
        button.isHidden = false // le bouton n'est pas caché
        button.isEnabled = true // le bouton est activé
    } // End of func buttonIsPresent

    /// hides and disables the button
    private func buttonIsNotPresent(button: UIButton) {
        button.isHidden = true // le bouton est caché
        button.isEnabled = false // le bouton n'est pas activé
    } // End of func buttonIsNotPresent

    /// removes the image of the button set as parameter
    private func removeButtonImage(button : UIButton) {
        button.setImage(nil, for: UIControl.State.normal)
    } // End of func removeButtonImage

    // MARK: - Class methods for insertion of pictures

    /// Opens the phone's image library
    private func openPhotoLibrary() {
        print("tapGesture on Image View")
        myImagePickerController.sourceType = .photoLibrary
        myImagePickerController.allowsEditing = true
        myImagePickerController.delegate = self
        present(myImagePickerController, animated: true)
    } // func openGallary(){

    /// Insert a image in the button
    func insertSelectedImageInButton(_ image: UIImage) {
        touchedButton.setImage(image, for: UIControl.State.normal)
    }

    /// Changes the background color
    private func chooseColorBackground() {
        let colors: [UIColor] = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.7853941321, green: 0.9267250896, blue: 0.6275908351, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.2523820337, green: 0.01414077414, blue: 0.8124809939, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)]
        photoView.backgroundColor = colors[indexOfColor]
        indexOfColor += 1
        print(indexOfColor)
        if indexOfColor == 9 {
            indexOfColor = 0
        }
    }

}// End of class ViewController

// MARK: - extension of ViewController

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    /// This function implements 2 protocols
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        insertSelectedImageInButton(selectedImage)
        dismiss(animated: true)
    }
} // End of extension ViewController
