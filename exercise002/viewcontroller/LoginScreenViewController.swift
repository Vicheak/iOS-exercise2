//
//  LoginScreenViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

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
    var bottomConstraint = NSLayoutConstraint()
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Login"
        
        setUpViews()
        
        tapGestureRecognizer.addTarget(self, action: #selector(tapEndEdit))
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showKeyboard(notification: Notification){
        guard let size = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        bottomConstraint.constant = size.height
        view.layoutIfNeeded()
    }
    
    @objc func hideKeyboard(){
        bottomConstraint.constant = 0
        view.layoutIfNeeded()
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        bottomConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        bottomConstraint.isActive = true
        
        //main view
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0).isActive = true
        mainView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1, constant: 0).isActive = true
        let mainViewHeightConstraint = mainView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 1, constant: 0)
        mainViewHeightConstraint.priority = .defaultLow
        mainViewHeightConstraint.isActive = true
        
        //stack view
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: mainView, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: stackView, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: stackView, attribute: .trailing, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //image view
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
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
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func tapEndEdit(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func loginButtonTapped(sender: UIButton){
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if LoginValidation.validate(target: self, username: username, password: password){
            print(username)
            print(password)
            if username == "Admin" && password == "2024" {
                //proceed home screen
                let tabBarController = UITabBarController()
                
                let homeScreenNavigationController = UINavigationController(rootViewController: HomeScreenViewController())
                homeScreenNavigationController.tabBarItem = UITabBarItem(title: "Notes", image: UIImage(systemName: "note.text"), tag: 0)
                homeScreenNavigationController.tabBarItem.title = "Notes"
                homeScreenNavigationController.navigationBar.prefersLargeTitles = true
                homeScreenNavigationController.navigationItem.largeTitleDisplayMode = .always
                
                let settingScreenViewController = UINavigationController(rootViewController: SettingScreenViewController())
                settingScreenViewController.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "person.2.badge.gearshape.fill"), tag: 0)
                settingScreenViewController.tabBarItem.badgeColor = .red
                settingScreenViewController.tabBarItem.badgeValue = username
                settingScreenViewController.navigationBar.prefersLargeTitles = true
                settingScreenViewController.navigationItem.largeTitleDisplayMode = .always
                
                tabBarController.setViewControllers([homeScreenNavigationController, settingScreenViewController], animated: true)
                tabBarController.selectedViewController = homeScreenNavigationController
                
                tabBarController.modalPresentationStyle = .fullScreen
                present(tabBarController, animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Incorrect username and password" , preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .destructive)
                alertController.addAction(alertAction)
                present(alertController, animated: true)
            }
        }
    }

}
