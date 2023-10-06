//
//  AuthService.swift
//  VKNews
//
//  Created by Admin on 18.06.2023.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFailed()
}


class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
//class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate: AnyObject {
    
    private let appId = "51675804"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String?{
        return VKSdk.accessToken().accessToken
    }
    
    var userId : String? {
        return VKSdk.accessToken()?.userId
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
     
    func wakeUpSession() {
        let scope = ["wall","friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
      
            case .initialized:
                 print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFailed()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
