//
//  ViewController1.swift
//  exercise002
//
//  Created by @suonvicheakdev on 25/5/24.
//

import UIKit
import Hero

class ViewController1: UIViewController {
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        blackView.hero.id = "batMan"
        redView.hero.id = "ironMan"
        redView.hero.modifiers = [.fade]
    }
    
    @IBAction func tapTapped(_ sender: Any) {
//        performSegue(withIdentifier: "transitionViewController", sender: self)
        let storyboard = UIStoryboard(name: "Hero", bundle: nil)
        let heroViewController = storyboard.instantiateViewController(withIdentifier: "ViewController2")
        heroViewController.modalPresentationStyle = .fullScreen
        present(heroViewController, animated: true)
    }
    
    //prepare before perform segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
