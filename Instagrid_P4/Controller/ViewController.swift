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

    @IBOutlet weak var layout1Button: UIButton!     // on pourra lui ajouter ou enlever l'image Selected quand on appuie dessus
    @IBOutlet weak var layout2Button: UIButton!     // on pourra lui ajouter ou enlever l'image Selected quand on appuie dessus
    @IBOutlet weak var layout3Button: UIButton! // on pourra lui ajouter ou enlever l'image Selected quand on appuie dessus
    @IBOutlet weak var layoutStackView: UIStackView!


    @IBOutlet weak var topLeftButton: UIButton! // on pourra lui ajouter ou enlever l'image choisie quand on appuie dessus

    @IBOutlet weak var topRightButton: UIButton!    // on pourra lui ajouter ou enlever l'image choisie quand on appuie dessus
    @IBOutlet weak var subLeftButton: UIButton!    // on pourra lui ajouter ou enlever l'image choisie quand on appuie dessus
    @IBOutlet weak var subRightButton: UIButton!    // on pourra lui ajouter ou enlever l'image choisie quand on appuie dessus

    @IBOutlet weak var photoView: UIView!       // Va bouger lors du swipe de partage ? Changement de couleur de fond... pour améliorations éventuelles

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }// End of override func viewDidLoad


    // -------- IBAction du swipe to share ---------



    // -------- IBAction des boutons de changement de disposition -------
    @IBAction func layout1ButtonTouched(_ sender: Any) {
        // buttonTopRight doit etre caché et désactivé
        buttonIsNotPresent(button: topRightButton)
        // buttonSubRight doit etre affiché et activé
        buttonIsPresent(button: subRightButton)
        //layout1Button doit avoir l'image Selected
        layout1Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        // layout2(et 3)Button ne doivent plus avoir d'image
        removeButtonImage(button: layout2Button, button2: layout3Button)
    }// End of func layout1ButtonTouched

    @IBAction func layout2ButtonTouched(_ sender: Any) {
        // buttonTopRight doit etre affiché et activé
        buttonIsPresent(button: topRightButton)
        // buttonSubRight doit etre caché et désactivé
        buttonIsNotPresent(button: subRightButton)
        //layout2Button doit avoir l'image Selected
        layout2Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        // layout1(et 3)Button ne doivent plus avoir d'image
        removeButtonImage(button: layout1Button, button2: layout3Button)
    }// End of func layout2ButtonTouched

    @IBAction func layout3ButtonTouched(_ sender: Any) {
        // buttonTopRight doit etre affiché et activé
        buttonIsPresent(button: topRightButton)
        // buttonSubRight doit etre affiché et activé
        buttonIsPresent(button: subRightButton)
        //layout3Button doit avoir l'image Selected
        layout3Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        // layout2(et 1)Button ne doivent plus avoir d'image
        removeButtonImage(button: layout2Button, button2: layout1Button)
    }// End of func layout3ButtonTouched

    func buttonIsPresent(button: UIButton) {
        button.isHidden = false // le bouton n'est pas caché
        button.isEnabled = true // le bouton est activé
    } // End of func buttonIsPresent

    func buttonIsNotPresent(button: UIButton) {
        button.isHidden = true // le bouton est caché
        button.isEnabled = false // le bouton n'est pas activé
    } // End of func buttonIsNotPresent

    func removeButtonImage(button : UIButton, button2: UIButton) {
        button.setImage(nil, for: UIControl.State.normal)
        button2.setImage(nil, for: UIControl.State.normal)
    } // End of func removeButtonImage

    //-------- IBAction des boutons de la vue Photo : -----------
    //    pour éviter répétition : En faire 1 seule avec un paramètre bouton touché qui serait sur la mainStackView? possible ? A VOIR !!

    @IBAction func buttonTopLeftTouched(_ sender: Any) {
        // actions déclenchées par l'appui sur ce bouton : A définir ...

    }// End of func buttonTopLeftTouched

    @IBAction func buttonTopRightTouched(_ sender: Any) {
        // actions déclenchées par l'appui sur ce bouton : A définir ...

    }// End of func buttonTopRightTouched

    @IBAction func buttonSubRightTouched(_ sender: Any) {
        // actions déclenchées par l'appui sur ce bouton : A définir ...

    }// End of func buttonSubRightTouched

    @IBAction func buttonSubLeftTouched(_ sender: Any) {
        // actions déclenchées par l'appui sur ce bouton : A définir ...

    }// End of func buttonSubLeftTouched




}// End of class ViewController

