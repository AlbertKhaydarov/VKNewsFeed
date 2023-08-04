//
//  ViewController.swift
//  VKNews
//
//  Created by Альберт Хайдаров on 14.06.2023.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
//        view.backgroundColor = .red
    }


    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

