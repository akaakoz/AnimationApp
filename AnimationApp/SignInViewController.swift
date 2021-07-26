//
//  SignInViewController.swift
//  AnimationApp
//
//  Created by Akiya Ozawa on R 3/07/14.
//

import UIKit
import SwiftUI
import Combine

struct Article: Codable {
    let title: String
    let url: String
}

enum WebApiError: Error {
    case invalidParameters
    
}

enum LoginError: LocalizedError {
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials: return "Invalid Credentials"
        }
    }
}

var cancellables = [AnyCancellable]()

func fetchArticle() -> AnyPublisher<[Article], Error>? {

    guard let url = URL(string: "https://qiita.com/api/v2/items") else {return nil}
    
    let request = URLRequest(url: url)
    
    return URLSession.shared
        .dataTaskPublisher(for: request)
        .map({$0.data})
        .decode(type: [Article].self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    
}


class SignInViewController: UIViewController {
    
   // var validation: ValidationService?
    
    var validation = ValidationService()
    
//    init(validation: ValidationService) {
//        self.validation = validation
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        self.validation = ValidationService()
//        super.init(coder: coder)
//
//    }
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .lightGray
        tf.placeholder = "e.g. John Wall"
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let pwtf = UITextField()
        pwtf.backgroundColor = .lightGray
        pwtf.isSecureTextEntry = true
        return pwtf
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("validation", validation)
        view.backgroundColor = .yellow
        
        setupView()
    }
    
    @objc fileprivate func handleSignIn() {
        print("tapping sign in button")
        
        do {
            
            let username = try validation.validateUserName(username: usernameTextField.text)
            let password = try validation.ValidatePassword(password: passwordTextField.text)
            
            if username == "timmy" && password == "123123123" {
            
                let qrViewController = QRViewController()
                present(qrViewController, animated: true, completion: nil)
               //presentAlert(with: "You Are Successfullyed signed in!")
                
            } else {
                print("something went wrong")
                throw LoginError.invalidCredentials
            }
            
        } catch let error{
            present(error)
            
        }
    }
    
    private func setupView() {
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, signInButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: view.frame.height / 4, width: 0)
        
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

struct SignInIntegratedController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        return UINavigationController(rootViewController: SignInViewController())
      
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //
    }
    
    typealias UIViewControllerType = UIViewController
}

struct SignInContentView: View {
    var body: some View {
        
        SignInIntegratedController().edgesIgnoringSafeArea(.all)
    }
}

struct SignInContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInContentView()
    }
}

extension SignInViewController {
    
    enum LoginError: LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Incorrect username or password. Please try again."
            }
        }
    }
}

extension Int {
    func square() -> Int {
        return self * self
    }
}
