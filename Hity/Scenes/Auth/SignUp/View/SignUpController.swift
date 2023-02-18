//
//  SignUpController.swift
//  Hity
//
//  Created by Ekrem Alkan on 11.02.2023.
//

import UIKit
import RxSwift

final class SignUpController: UIViewController {
    
    //MARK: - Properties
    
    private let signUpView = SignUpView()
    private let signUpViewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK: - Gettable Properties
    
    var username: String {
        guard let username = signUpView.userNameTextField.text else { return ""}
        return username
    }
    
    var email: String {
        guard let email = signUpView.emailTextField.text else { return ""}
        return email
    }
    
    var password: String {
        guard let password = signUpView.passwordTextField.text else { return ""}
        return password
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        view = signUpView
        signUpView.interface = self
        createCallbacks()
    }
    
    
}

//MARK: - SignUpViewInterface

extension SignUpController: SignUpViewInterface {
    func signUpButtonTapped(_ view: SignUpView) {
        signUpViewModel.signUp(username, email, password)
    }
    
    
}


//MARK: - Creating Sign In Callbacks

extension SignUpController {
    
    private func createCallbacks() {
        
        signUpViewModel.isAccCreatingSuccess.subscribe { [weak self] value in
            let controller = SignInController()
            self?.navigationController?.pushViewController(controller, animated: true)
        }.disposed(by: disposeBag)
        
        
        signUpViewModel.isDatabaseCreatingSuccess.subscribe(onNext: { value in
            print("data base oluşturuldu")
        }).disposed(by: disposeBag)
        
        signUpViewModel.errorMsg.subscribe(onNext: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    
}