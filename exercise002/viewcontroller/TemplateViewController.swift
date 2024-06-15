//
//  FolderTemplateViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit
import SnapKit

class TemplateViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let mainView = UIView()
    let titleTextField = UITextField()
    let detailTextView = UITextView()
    let saveButton = UIButton()
    var bottomConstraint: Constraint!
    
    var keyboardUtil: KeyboardUtil!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = ""
        
        setUpViews()
        
        titleTextField.delegate = self
        detailTextView.delegate = self
        
        keyboardUtil = KeyboardUtil(viewController: self, view: view, bottomConstraint: bottomConstraint)
        keyboardUtil.keyboardNotification()
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped(sender: UIButton){
   
    }
 
    private func setUpViews(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
        }
        
        scrollView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
        }
        
        mainView.addSubview(titleTextField)
        titleTextField.font = UIFont(name: "HelveticaNeue", size: 17)
        titleTextField.placeholder = "Enter title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        mainView.addSubview(detailTextView)
        detailTextView.font = UIFont(name: "HelveticaNeue", size: 17)
        detailTextView.text = "Enter detail"
        detailTextView.textColor = .lightGray
        detailTextView.layer.borderWidth = 0.4
        detailTextView.layer.borderColor = UIColor.lightGray.cgColor
        detailTextView.layer.cornerRadius = 5
        detailTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(150)
        }
        
        mainView.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: saveButton, attribute: .top, relatedBy: .equal, toItem: detailTextView, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: saveButton, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: saveButton, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: saveButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        ])
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(detailTextView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(150)
        }
        
        let tapGuestureRecognizer = UITapGestureRecognizer()
        mainView.addGestureRecognizer(tapGuestureRecognizer)
        tapGuestureRecognizer.addTarget(self, action: #selector(viewEndEdit))
    }
    
    @objc func viewEndEdit(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let previousTraitCollection = previousTraitCollection else { return }
        
        if previousTraitCollection.verticalSizeClass == .regular &&
            previousTraitCollection.horizontalSizeClass == .compact {
            //portrait
        } else if previousTraitCollection.verticalSizeClass == .compact &&
                    previousTraitCollection.horizontalSizeClass == .regular {
            //landscape iPhone 15 pro max
        } else if previousTraitCollection.verticalSizeClass == .compact &&
                    previousTraitCollection.horizontalSizeClass == .compact {
            //landscape iPhone 15 and iPhone SE series
        } else {
            //iPad trait
        }
    }
    
}

extension TemplateViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            detailTextView.becomeFirstResponder()
        }
        return true
    }
   
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == detailTextView.text {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
}
