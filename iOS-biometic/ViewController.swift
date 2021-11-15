//
//  ViewController.swift
//  iOS-biometic
//
//  Created by Mavin Sao on 15/11/21.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var secretTextView: UITextView!
    
    //Define Local Auth Context
    let localAuthenticationContext = LAContext()
    
    let myScretText = "Baby, I love you!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        secretTextView.isEditable = false
    }
    
    @IBAction func readData(_ sender: Any) {
        authentication()
    }
    
    func authentication(){
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"
        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {[weak self] success, error in
                
                if success {
                    DispatchQueue.main.async {
                        self?.secretTextView.text = self?.myScretText
                    }
                   
                }else{
                    DispatchQueue.main.async {
                        // Failed to authenticate
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                  
                }
            }
        }else{
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
        
        
    }
    
}

