//
//  SkeletonViewController1.swift
//  exercise002
//
//  Created by @suonvicheakdev on 25/5/24.
//

import UIKit
import SkeletonView

class SkeletonViewController1: UIViewController {
    
    //lazy loading
    lazy var titleLabel = UILabel()
    lazy var saveButton: UIButton = {
        let thisButton = UIButton()
        thisButton.setTitle("Save", for: .normal)
        thisButton.backgroundColor = .systemBlue
        return thisButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        view.addSubview(saveButton)
    }

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.view.hideSkeleton()
//        }
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
}
