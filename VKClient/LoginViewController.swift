//
//  LoginViewController.swift
//  VKClient
//
//  Created by Михаил Ластовкин on 13.06.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var circleOne: UIImageView!
    @IBOutlet weak var circleTwo: UIImageView!
    @IBOutlet weak var circlethree: UIImageView!
    
    
    let toTabBarSegueIdentifier = "fromLogintoTabBar"

    override func viewDidLoad() {
        super.viewDidLoad()
        animateCircles()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let gestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDie))
        backView.addGestureRecognizer(gestureRecognaizer)

    }
    
    @objc func keyboardDie() {
            self.scrollView.endEditing(true)
    }
    
    
    @objc func keyboardWasShow() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 250, right: 0)
        
    }
    
    @objc func keyboardHide() {
        scrollView.contentInset = UIEdgeInsets.zero
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showAllert(message: String, compeletion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let allertAction = UIAlertAction(title: "OK", style: .cancel, handler: compeletion)
        alertController.addAction(allertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func animateCircles() {
        circleOne.alpha = 0
        circleTwo.alpha = 0
        circlethree.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: { [weak self] in
                        self?.circleOne.alpha = 1 },
                       completion: nil)
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       options: [.autoreverse, .repeat],
                       animations: { [weak self] in
                        self?.circleTwo.alpha = 1 },
                       completion: nil)
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       options: [.autoreverse, .repeat],
                       animations: { [weak self] in
                        self?.circlethree.alpha = 1 },
                       completion: nil)
    }
                        

    @IBAction func pressLoginutton(_ sender: Any) {
//        if let login = loginTextField.text,
//           let password = passwordTextField.text,
//           !login.isEmpty,
//           !password.isEmpty,
//           login == "root",
//           password == "123" {
            performSegue(withIdentifier: toTabBarSegueIdentifier, sender: nil)
        }
//        else {
//            showAllert(message: "Error login or password") { _ in
//                return
//            }
//        }
//    }
    
    
    
    
}
