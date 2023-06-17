//
//  LoginView.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import UIKit

class LoginView: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }
    func configView() {
        tfUser.placeholder = "Nombre de usuario"
        tfUser.borderStyle = .roundedRect
        tfUser.translatesAutoresizingMaskIntoConstraints = false
        
        tfPassword.placeholder = "Contraseña"
        tfPassword.borderStyle = .roundedRect
        tfPassword.isSecureTextEntry = true
        tfPassword.translatesAutoresizingMaskIntoConstraints = false
        
        btnLogin.setTitle("Iniciar sesión", for: .normal)
        btnLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        
        lblError.textColor = .red
        lblError.textAlignment = .center
        lblError.translatesAutoresizingMaskIntoConstraints = false
        lblError.isHidden = true
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = tfUser.text,
              let password = tfPassword.text else {
            return
        }
        
        viewModel.login(username: username, password: password) { [weak self] isLoggedIn in
            if isLoggedIn {
                self?.changeRootViewControllerWithAnimation()
            } else {
                self?.showErrorLabel()
            }
        }
    }
    private func showErrorLabel() {
        lblError.text = "Credenciales incorrectas"
        lblError.isHidden = false
    }
    private func changeRootViewControllerWithAnimation() {
        let moviesViewModel = MoviesViewModel(repository: RemoteMoviesRepository(), coreDataManager: CoreDataManager())
        let newRootViewController = MoviesView(viewModel: moviesViewModel)
        setRootViewControllerWithAnimation(newRootViewController)
    }
    
    private func setRootViewControllerWithAnimation(_ newRootViewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        let moviesViewController = BaseNavigationController(rootViewController: newRootViewController)
        window.rootViewController = moviesViewController
        
        let animationDuration = 0.5
        let animationOptions: UIView.AnimationOptions = .transitionCrossDissolve
        
        UIView.transition(with: window, duration: animationDuration, options: animationOptions, animations: nil, completion: nil)
    }
}
