//
//  LoginVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 01/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
class LoginVC: UIViewController, UITextFieldDelegate{
    
    //MARK: Public API
    @IBOutlet weak var digitOne: UITextField!
    @IBOutlet weak var digitTwo: UITextField!
    @IBOutlet weak var digitThree: UITextField!
    @IBOutlet weak var digitFour: UITextField!
    @IBOutlet weak var digitFive: UITextField!
    @IBOutlet weak var digitSix: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    
    var myVideoLayer:AVCaptureVideoPreviewLayer?
    var myDevice : AVCaptureDevice?
    private var myVideoOutPut:AVCaptureMovieFileOutput!
    
    var mySession: AVCaptureSession?
    var myImageOutput: AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?

    
    var position: AVCaptureDevicePosition?
    
    var password = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldInitialize()
        
        backgroundCameraInitialize()

        
        
    }
    
    
    //MARK: textFieldInitialize ~ delegate and function for 6 textfield
    func textfieldInitialize(){
        digitOne.delegate = self
        digitTwo.delegate = self
        digitThree.delegate = self
        digitFour.delegate = self
        digitFive.delegate = self
        digitSix.delegate = self
        
        
        
        digitOne.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitTwo.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitThree.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitFour.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitFive.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
        digitSix.addTarget(self, action: #selector(RegisterVC.textFieldChanged(_:)), forControlEvents: .EditingChanged)
    }
    
    
    
    //MARK: backgroundCameraInitialize ~ add camera to background for unplesant guest
    func backgroundCameraInitialize(){

        mySession = AVCaptureSession()
        mySession?.sessionPreset = AVCaptureSessionPresetHigh
        
        
        myImageOutput = AVCaptureStillImageOutput()
        
        let devices = AVCaptureDevice.devices()
        
        position = AVCaptureDevicePosition.Front
        
        for device in devices {
            if (device.position == position!){
                myDevice = device as! AVCaptureDevice
            }
        }
        
        do{
            let videoCaptureDevice = myDevice
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if (mySession!.canAddInput(videoInput)){
                mySession!.addInput(videoInput)
            }
        }catch let error as NSError{
            
        }
        
        
        
        
        
        mySession!.addOutput(myImageOutput)
        
        myVideoOutPut = AVCaptureMovieFileOutput()
        
        mySession!.addOutput(myVideoOutPut)
        
        myVideoLayer = AVCaptureVideoPreviewLayer(session: mySession)
        myVideoLayer!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        myVideoLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        myVideoLayer!.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
        self.view.layer.addSublayer(myVideoLayer!)
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        mySession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back


        mySession!.startRunning()
        
        self.view.bringSubviewToFront(loginView)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func takePhotoGuest(){
        if let videoConnection = self.myImageOutput?.connectionWithMediaType(AVMediaTypeVideo){
            self.myImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                if sampleBuffer != nil {

                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    print(PhotoManager().saveImageForUnplesantGuest(imageData))
                        
                }
                
                
            })
        }
        
    }
    
    
    //MARK: checkPassword ~ login authorization
    func checkPassword(password:String){
        //Is password correct
        if(SafeBrain().checkForLogin(password)){
            print("mert1")
        }
        //Else take a photo of unplesant guest
        else{
            self.view.shake()
            digitOne.becomeFirstResponder()
            clearAll(0)
            takePhotoGuest()
        }
        
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
    
    
    
    


}
