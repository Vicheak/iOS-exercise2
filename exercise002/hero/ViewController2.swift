//
//  ViewController2.swift
//  exercise002
//
//  Created by @suonvicheakdev on 25/5/24.
//

import UIKit
import Hero

class ViewController2: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var whiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHeroEnabled = true
        blackView.hero.id = "batMan"
        redView.hero.id = "ironMan"
//        whiteView.hero.modifiers = [.translate(y: 100)]
        whiteView.hero.modifiers = [.cascade, .durationMatchLongest, .fade]
    }
    
    @IBAction func tapTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Hero", bundle: nil)
        let heroViewController = storyboard.instantiateViewController(withIdentifier: "ViewController1")
        heroViewController.modalPresentationStyle = .fullScreen
        present(heroViewController, animated: true)
    }
    
}
