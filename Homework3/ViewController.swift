//
//  ViewController.swift
//  Homework3
//
//  Created by Ремзи Билялов on 21.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelSignIn: UILabel!
    
    @IBOutlet weak var labelBirthday: UILabel!
    
    @IBOutlet weak var labelEmail: UILabel!
    
    @IBOutlet weak var textfileEmail: UITextField!
    let borderLineEamil = CALayer()
    
    @IBOutlet weak var labelPassword: UILabel!
    
    @IBOutlet weak var textfieldPassword: UITextField!
    let borderLinePassword = CALayer()
    let buttonTogglePassword = UIButton()
    
    @IBOutlet weak var labelFeceID: UILabel!
    
    @IBOutlet weak var switchFaceID: UISwitch!
    
    @IBOutlet weak var buttonEnter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Enter button discription
        buttonEnter.layer.cornerRadius = 5
     
        //MARK: Birthday label discription
        labelBirthday.layer.borderColor = UIColor.lightGray.cgColor
        labelBirthday.layer.borderWidth = 3
        
        //MARK: Email textfile discription
        textfileEmail.borderStyle = .none
        textfileEmail.layer.addSublayer(borderLineEamil)
        
        borderLineEamil.frame = CGRect(x: 0,
                                       y: textfileEmail.frame.height,
                                       width: textfileEmail.frame.width,
                                       height: 1)
        borderLineEamil.backgroundColor = UIColor.lightGray.cgColor
        
        //MARK: Password textfile discription
        textfieldPassword.borderStyle = .none
        textfieldPassword.layer.addSublayer(borderLinePassword)
        
        borderLinePassword.frame = CGRect(x: 0,
                                       y: textfieldPassword.frame.height,
                                       width: textfieldPassword.frame.width,
                                       height: 1)
        borderLinePassword.backgroundColor = UIColor.lightGray.cgColor
        
        textfieldPassword.isSecureTextEntry = true
        textfieldPassword.rightView = buttonTogglePassword
        textfieldPassword.rightViewMode = .always
        
        //MARK: Toggale of password description
        view.addSubview(buttonTogglePassword)
        buttonTogglePassword.setBackgroundImage(UIImage(systemName: "eye"), for: UIControl.State.normal)
        buttonTogglePassword.frame = CGRect(x: textfieldPassword.frame.size.height,
                                            y: textfieldPassword.frame.width,
                                            width: 22,
                                            height: 22)
        buttonTogglePassword.tintColor = .lightGray
        buttonTogglePassword.setBackgroundImage(UIImage(systemName: "eye"), for: UIControl.State.normal)
        buttonTogglePassword.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)

    }
    
    //MARK: Function for toggle password
    @objc private func togglePassword() {
        let togglePassword = textfieldPassword.isSecureTextEntry
        textfieldPassword.isSecureTextEntry = togglePassword ? false : true
        if togglePassword {
            buttonTogglePassword.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            buttonTogglePassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
}

