//
//  RegisterVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 01/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import KVNProgress
class RegisterVC: UIViewController, UITextFieldDelegate{
    
    //MARK: Public API
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var digitOne: UITextField!
    @IBOutlet weak var digitTwo: UITextField!
    @IBOutlet weak var digitThree: UITextField!
    @IBOutlet weak var digitFour: UITextField!
    @IBOutlet weak var digitFive: UITextField!
    @IBOutlet weak var digitSix: UITextField!
    
    var password = String()
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        digitOne.delegate = self
        digitTwo.delegate = self
        digitThree.delegate = self
        digitFour.delegate = self
        digitFive.delegate = self
        digitSix.delegate = self
        emailTextField.delegate = self
        
        
        digitOne.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitTwo.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitThree.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitFour.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitFive.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitSix.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        
        
        
    }
    
    func textFieldChanged(sender:UITextField){
        if(sender == digitOne){
            textFieldOperation(sender, index: 0)
        }
        if(sender == digitTwo){
            textFieldOperation(sender, index: 1)
        }
        if(sender == digitThree){
            textFieldOperation(sender, index: 2)
        }
        if(sender == digitFour){
            textFieldOperation(sender, index: 3)
        }
        if(sender == digitFive){
            textFieldOperation(sender, index: 4)
        }
        if(sender == digitSix){
            textFieldOperation(sender, index: 5)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == emailTextField){
            digitOne.becomeFirstResponder()
        }
        return true
    }


    
    func textFieldOperation(sender:UITextField,index:Int){
        var textFieldArray = [digitOne,digitTwo,digitThree,digitFour,digitFive,digitSix]
        if(sender.text?.characters.count == 1){
            password += sender.text!
            if(index == 5){
                sender.text = "😍"
                checkPassword(password)
            }
            else{
                textFieldArray[index+1].becomeFirstResponder()
                sender.text = "😍"
            }
            
        }
        if(sender.text?.characters.count > 1){
            password = ""
            let lastChar = "\(sender.text![(sender.text?.endIndex.predecessor())!])"
            password += lastChar
            if(index == 5){
                sender.text = "😍"
                checkPassword(password)
                
            }
            else{
                textFieldArray[index+1].becomeFirstResponder()
                sender.text = "😍"
            }
            
        }
    }
    
    func checkPassword(password:String){
        print(password)
        self.view.endEditing(true)
    }
    
    
    func clearAll(endIndex:Int){
        var textFieldArray = [digitOne,digitTwo,digitThree,digitFour,digitFive,digitSix]
        let count = textFieldArray.count-1
        for var i = count; i>=endIndex; --i{
            textFieldArray[i].text = ""
            password = String(password.characters.dropLast())
        }
    }
    


    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField.text?.characters.count == 1){
            if(textField == digitOne){
                clearAll(0)
            }
            if(textField == digitTwo){
                clearAll(1)
            }
            if(textField == digitThree){
                clearAll(2)
            }
            if(textField == digitFour){
                clearAll(3)
            }
            if(textField == digitFive){
                clearAll(4)
            }
            if(textField == digitSix){
                clearAll(5)
            }
        }
        print(password)
    }
    
    
    
    //MARK: registerButtonAction ~ Registers user to host
    @IBAction func registerButtonAction() {
        KVNProgress.show()
        if let email = emailTextField.text{
            if(password.characters.count < 6){
                //Password is empty or shorter than 6 char
                KVNProgress.showErrorWithStatus("Password is shorter than expected")
            }
            else{
                APIClient().register(email, password: password, completion: {(fieldError, error) -> Void in
                
                    if(fieldError != ""){
                        KVNProgress.showErrorWithStatus("This email address has already registered to database", completion:{
                            self.view.shake()
                            self.emailTextField.text = ""
                            self.emailTextField.becomeFirstResponder()
                        })
                        
                    }
                    else if(error != nil){
                        KVNProgress.showErrorWithStatus("Please check your internet connection and try again")
                    }
                    else{
                        //No problem
                        User(email: email, password: self.password).setUserDefaults()
                        KVNProgress.dismissWithCompletion({
                            NSNotificationCenter.defaultCenter().postNotificationName("showLanding2", object: nil)
                        })
                    }
                    
                    
                    
                })
            }
        }
        else{
            //Email is empty error
            KVNProgress.showErrorWithStatus("Email cannot be empty")
        }
        
        
        
        
    }
}


extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.addAnimation(animation, forKey: "shake")
    }
}

