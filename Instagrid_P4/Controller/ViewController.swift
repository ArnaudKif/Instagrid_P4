//
//  ViewController.swift
//  Instagrid_P4
//
//  Created by arnaud kiefer on 26/04/2021.
//

import UIKit

class ViewController: UIViewController {

    // les IBOutlet permettront au contrôleur de changer des éléments de la vue
    @IBOutlet weak var swipeView: UIStackView! // pour le faire bouger quand on va swiper pour partager

    @IBOutlet var layoutButtons: [UIButton]!

    @IBOutlet var imageButton: [UIButton]!

    @IBOutlet weak var switchButton: UIButton!
    
    @IBOutlet weak var photoView: UIView!       // Va bouger lors du swipe de partage(animation) ? Changement de couleur de fond... pour améliorations éventuelles
    var touchedButton: UIButton!
    var myImageView: UIImage!
    private let myImagePickerController = UIImagePickerController()
    var indexOfColor = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonIsPresent(button: imageButton[1]) // valide la disposition de départ
        buttonIsNotPresent(button: imageButton[3])

    }// End of override func viewDidLoad

    @IBAction func switchColorView(_ sender: Any) {
        let colors: [UIColor] = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.5910229683, green: 0.3601167798, blue: 0, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.1315900385, green: 0.3851100206, blue: 0.567650497, alpha: 1)]
        photoView.backgroundColor = colors[indexOfColor]
        indexOfColor += 1
        print(indexOfColor)
        if indexOfColor == 9 {
            indexOfColor = 0
        }
    }

    // -------- IBAction du swipe to share ---------



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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    /// This function implements 2 protocols
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        insertSelectedImageInButton(selectedImage)
        dismiss(animated: true)
    }


} // End of extension ViewController
