//
//  LoginViewController.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    private var viewModel: LoginViewModel!

    var onLoginSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(loginManager: LoginManager())
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {

        guard let username = usernameTextField.text,
              let password = passwordTextField.text,
              !username.isEmpty,
              !password.isEmpty else {
            showAlert("Please enter username and password")
            return
        }

        viewModel.login { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.onLoginSuccess?()
                } else {
                    self?.showAlert("Login failed")
                }
            }
        }
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Login",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        present(alert, animated: true)
    }
}
