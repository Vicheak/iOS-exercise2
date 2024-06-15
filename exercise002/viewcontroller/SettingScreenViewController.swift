//
//  SettingScreenViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit
import SnapKit

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
        
        let username = UserDefaults.standard.string(forKey: "username");
        
//        titleLabel.text = "Welcome \(navigationController!.tabBarItem.badgeValue!)"
        titleLabel.text = "Welcome \(String(describing: username!))";
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem){
        //clear data from UserDefaults
        UserDefaults.standard.set(false, forKey: "isLogOn")
        UserDefaults.standard.set(nil, forKey: "username")
        
        dismiss(animated: false)
    }
    
    private func setUpViews(){
        view.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 24)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        titleLabel.numberOfLines = 1
    }
    
}
