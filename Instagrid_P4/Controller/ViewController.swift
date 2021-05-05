//
//  ViewController.swift
//  Instagrid_P4
//
//  Created by arnaud kiefer on 26/04/2021.
//

import UIKit

class ViewController: UIViewController {

    // les IBOutlet permettront au contrôleur de changer des éléments de la vue
    @IBOutlet weak var swipeView: UIStackView!
    @IBOutlet weak var swipeImageView: UIStackView!
    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet var imageButton: [UIButton]!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var photoView: UIView!

    private var touchedButton: UIButton!
    private let myImagePickerController = UIImagePickerController()
    private var indexOfColor = 0
    private var firstStart = true
    private var swipeGesture: UISwipeGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonIsPresent(button: imageButton[1]) // valide la disposition de départ
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

/// à chaque fois que le téléphone est tourné, on change de sens du swipe
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        detectOrientation()
    } // End of viewWillTransition


    @IBAction func switchColorView(_ sender: Any) {
        let colors: [UIColor] = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.7853941321, green: 0.9267250896, blue: 0.6275908351, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.2523820337, green: 0.01414077414, blue: 0.8124809939, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0, green: 0.4076067805, blue: 0.6132292151, alpha: 1)]
        photoView.backgroundColor = colors[indexOfColor]
        indexOfColor += 1
        print(indexOfColor)
        if indexOfColor == 9 {
            indexOfColor = 0
        }
    }// End of switchColorView


    // -------- IBAction du swipe to share ---------

/// défini la direction du swipe en fonction de l'orientation de l'écran
    fileprivate func detectOrientation() {
        if UIDevice.current.orientation.isLandscape {
            swipeGesture?.direction = .left
        } else {
            swipeGesture?.direction = .up
        }
    } // End of detectOrientation

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

    func share() {

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
 

    // -------- IBAction des boutons de changement de disposition -------


    @IBAction func layoutTouched(_ sender: UIButton) {
        layoutButtonTouched(buttonTouched: sender)
    }// End of func layoutTouched

    /// Suivant le bouton touché, ajoute l'image Selected et change la disposition des photos
    func layoutButtonTouched(buttonTouched: UIButton) {
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

    /// affiche et active le bouton
    func buttonIsPresent(button: UIButton) {
        button.isHidden = false // le bouton n'est pas caché
        button.isEnabled = true // le bouton est activé
    } // End of func buttonIsPresent

    /// cache et désactive le bouton
    func buttonIsNotPresent(button: UIButton) {
        button.isHidden = true // le bouton est caché
        button.isEnabled = false // le bouton n'est pas activé
    } // End of func buttonIsNotPresent

    /// supprime l'image du bouton mis en paramètre.
    func removeButtonImage(button : UIButton) {
        button.setImage(nil, for: UIControl.State.normal)
    } // End of func removeButtonImage


    //-------- IBAction des boutons de la vue Photo : -----------

    @IBAction func imageButtonTouched(_ sender: UIButton) {
        touchedButton = sender
        openPhotoLibrary()
    } // End of imageButtonTouched

    func openPhotoLibrary() {
        print("tapGesture on Image View")
        myImagePickerController.sourceType = .photoLibrary
        myImagePickerController.allowsEditing = true
        myImagePickerController.delegate = self
        present(myImagePickerController, animated: true)
    } // func openGallary(){

    func insertSelectedImageInButton(_ image: UIImage) {
        touchedButton.setImage(image, for: UIControl.State.normal)
    }
}// End of class ViewController

