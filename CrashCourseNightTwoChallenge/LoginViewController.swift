//
//  LoginViewController.swift
//  WordsAndWeather
//
//  Created by Franks, Kent on 11/5/15.
//  Copyright © 2015 Franks, Kent. All rights reserved.
//

import UIKit
import CoreData


class LoginViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var addCityTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    var citiesArray = [String]()
    var loginExists = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.hidden = true
        
        let outsideTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(outsideTap)
        
        setupTextFields()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let _ = defaults.objectForKey("userIDExists") else {
            loginButton.setTitle("Create Login", forState: UIControlState.Normal)
            return
        }
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginExists = defaults.objectForKey("userIDExists") as! Bool
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let _ = defaults.objectForKey("citiesArray") else {
            return
        }
        citiesArray = defaults.objectForKey("citiesArray") as! [String]
        print("Printing all cities saved in user defaults")
        for city in citiesArray {
            print("saved city = \(city)")
        }
    }
    
    // MARK: - UISetup
    func setupTextFields() {
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.cornerRadius = 6.0
        usernameTextField.layer.borderColor = UIColor .lightGrayColor().CGColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 6.0
        passwordTextField.layer.borderColor = UIColor .lightGrayColor().CGColor
        addCityTextField.layer.borderWidth = 1.0
        addCityTextField.layer.cornerRadius = 6.0
        addCityTextField.layer.borderColor = UIColor .lightGrayColor().CGColor
    }
    
    // MARK: - Actions
    @IBAction func loginAction(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if loginExists {
            // When getting value for a key in a dictionary you need to use as! String
            let userID = defaults.objectForKey("appUserID") as! String
            let password = defaults.objectForKey("appPassword") as! String
            if userID == usernameTextField.text && password == passwordTextField.text {
                print("Login Successful")
            } else {
                print("Login failed, check your username and password")
            }
        } else {
            defaults.setValue(usernameTextField.text, forKey: "appUserID")
            defaults.setValue(passwordTextField.text, forKey: "appPassword")
            defaults.setBool(true, forKey: "userIDExists")
            loginExists = true
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            print("Login created")
        }
    }
    
    @IBAction func addCityAction(sender: AnyObject) {
        citiesArray.append(addCityTextField.text!)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(citiesArray, forKey: "citiesArray")
        print("Printing all cities after add")
        for city in citiesArray {
            print(city)
        }
    }
    
    @IBAction func deleteAction(sender: AnyObject) {

    }
    
    
    // MARK: - TextField Delegate 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag=textField.tag+1;
        if let nextResponder=textField.superview?.viewWithTag(nextTag) as UIResponder! {
            nextResponder.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldHasChanged() {

    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        return true
    }
    
}
