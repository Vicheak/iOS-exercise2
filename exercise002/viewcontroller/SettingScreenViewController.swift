//
//  SettingScreenViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class SettingScreenViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Setting"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lock.slash.fill"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .normal)
        
        setUpViews()
        
        titleLabel.text = "Welcome \(navigationController!.tabBarItem.badgeValue!)"
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem){
        dismiss(animated: false)
    }
    
    private func setUpViews(){
        view.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: view.safeAreaLayoutGuide, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 10)
        ])
        titleLabel.numberOfLines = 1
    }
    
}
