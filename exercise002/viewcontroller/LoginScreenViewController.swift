//
//  LoginScreenViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit
import SnapKit

class LoginScreenViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let mainView = UIView()
    let stackView = UIStackView()
    let stackViewTextField = UIStackView()
    let stackViewButton = UIStackView()
    let imageView = UIImageView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    var bottomConstraint: Constraint!
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    var keyboardUtil: KeyboardUtil!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpViews()
        
        keyboardUtil = KeyboardUtil(viewController: self, view: view, bottomConstraint: bottomConstraint)
        keyboardUtil.keyboardNotification()
        
        tapGestureRecognizer.addTarget(self, action: #selector(tapEndEdit))
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        let isLogOn = UserDefaults.standard.bool(forKey: "isLogOn")
        let savedUsername = UserDefaults.standard.string(forKey: "username")
         
        if isLogOn {
            DispatchQueue.main.async {
                self.setUpTabBarThenNavigate(username: savedUsername)
            }
        }
    }
    
    private func setUpViews(){
        view.addSubview(scrollView)
        view.addGestureRecognizer(tapGestureRecognizer)
        scrollView.addSubview(mainView)
        mainView.backgroundColor = .white
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(stackViewTextField)
        stackView.addArrangedSubview(stackViewButton)
        stackViewTextField.addArrangedSubview(usernameTextField)
        stackViewTextField.addArrangedSubview(passwordTextField)
        stackViewButton.addArrangedSubview(loginButton)
        
        //scroll view
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
        }
        
        //main view
        mainView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
        }
        
        //stack view
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.contentMode = .scaleToFill
        
        stackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        //image view
        imageView.image = UIImage(systemName: "person.2.badge.key.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        //stack view for text field container
        stackViewTextField.axis = .vertical
        stackViewTextField.alignment = .fill
        stackViewTextField.distribution = .fill
        stackViewTextField.spacing = 20
        stackViewTextField.contentMode = .scaleToFill
        
        //username text field
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "Enter username"
   
        //password text field
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        
        //stack view for button container
        stackViewButton.axis = .vertical
        stackViewButton.alignment = .fill
        stackViewButton.distribution = .fill
        stackViewButton.spacing = 0
        
        //login button
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 10
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    @objc func tapEndEdit(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func loginButtonTapped(sender: UIButton){
        doLoginProcess()
    }
    
    func doLoginProcess(){
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let isLogOn = UserDefaults.standard.bool(forKey: "isLogOn")
        let savedUsername = UserDefaults.standard.string(forKey: "username")
         
        if isLogOn {
            setUpTabBarThenNavigate(username: savedUsername)
            return
        }
        
        if LoginValidation.validate(target: self, username: username, password: password){
            if (username == "Admin" || username == "aditi") && password == "2024" {
                setUpTabBarThenNavigate(username: username)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Incorrect username and password" , preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .destructive)
                alertController.addAction(alertAction)
                present(alertController, animated: true)
            }
        }
    }
    
    func setUpTabBarThenNavigate(username: String?){
        let tabBarController = UITabBarController()
        
        let homeScreenNavigationController = UINavigationController(rootViewController: HomeScreenViewController())
        homeScreenNavigationController.tabBarItem = UITabBarItem(title: "Folders", image: UIImage(systemName: "folder.fill"), tag: 0)
        homeScreenNavigationController.tabBarItem.title = "Folders"
        homeScreenNavigationController.navigationBar.prefersLargeTitles = true
        homeScreenNavigationController.navigationItem.largeTitleDisplayMode = .always
        
        let settingScreenViewController = UINavigationController(rootViewController: SettingScreenViewController())
        settingScreenViewController.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "person.2.badge.gearshape.fill"), tag: 0)
        settingScreenViewController.tabBarItem.badgeColor = .red
        settingScreenViewController.navigationBar.prefersLargeTitles = true
        settingScreenViewController.navigationItem.largeTitleDisplayMode = .always
        
        tabBarController.setViewControllers([homeScreenNavigationController, settingScreenViewController], animated: true)
        tabBarController.selectedViewController = homeScreenNavigationController
        tabBarController.modalPresentationStyle = .fullScreen
        
        present(tabBarController, animated: true) { [weak self] in
            guard let self = self else { return }
            
            //save data to UserDefaults
            UserDefaults.standard.set(true, forKey: "isLogOn")
            UserDefaults.standard.set(username, forKey: "username")
            
            usernameTextField.text = ""
            passwordTextField.text = ""
        }
    }

}
