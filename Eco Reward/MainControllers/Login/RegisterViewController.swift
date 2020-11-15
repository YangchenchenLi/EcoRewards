//
//  RegisterViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 14/10/20.
//  Author: Yang Xu
//
//  Code adapted from iOS Academy by Afraz Siddiqui
//  Source: (https://www.youtube.com/playlist?list=PL5PR3UyfTWvdlk-Qi-dPtJmjTj-2YIMMf)


import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // To create a container view to wrap all the elements.
    // so in case the user has small size screen, it can scroll the view
    // to avoid keyboard blocking the elements.
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
        
    }()
    
    // create a text field for email
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    // create a text field for password
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    // create a text field for first name
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    // create a text field for email
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    // create a register button
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
        
    }()
    
    // showing the logo on the top
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    
    
    // load the view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Log In"
        
        // create the Register button on the top right corner
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        
        // add target to the button
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTapped),
                                 for: .touchUpInside)
        
        // when user hit the return, it automatically call the login function
        emailField.delegate = self
        passwordField.delegate = self
        
        // add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        // change the profile picture gesture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
        
    }
    
    // function to handle the action of changing the profile picture
    @objc func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
    
    // add a frame to all elements, setting up their layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        imageView.layer.cornerRadius = imageView.width/2
        
        firstNameField.frame = CGRect(x: 30,
                                      y: imageView.bottom + 10,
                                      width: scrollView.width - 60,
                                      height: 52)
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        registerButton.frame = CGRect(x: 30,
                                      y: passwordField.bottom + 10,
                                      width: scrollView.width - 60,
                                      height: 52)
        
    }
    // the function to handle the log in action
    @objc private func registerButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        // user input validation
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6
        else {
            alertUserloginError()
            return
        }

        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, err in
                                guard let strongSelf = self else {
                                    return}
                                
                                if let x = err {
                                    let err = x as NSError
                                    switch err.code {
                                    case AuthErrorCode.wrongPassword.rawValue:
                                        self!.showAlert(errorMessage: "Wrong Password")
                                        print("wrong password")
                                    case AuthErrorCode.invalidEmail.rawValue:
                                        self!.showAlert(errorMessage: "Invalid Email")
                                        print("invalid email")
                                    case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                                        self!.showAlert(errorMessage: "Account Exists With Different Credential")
                                        print("accountExistsWithDifferentCredential")
                                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                                        self!.showAlert(errorMessage: "Email Already In Use")
                                        print("email is alreay in use")
                                    default:
                                        self!.showAlert(errorMessage: "Unknown Error")
                                        print("unknown error: \(err.localizedDescription)")
                                    }}
                                else {
                                    print("User created")
                                    // user was created sucessfully, now initialize the user account
                                    
                                    
                                    let db = Firestore.firestore()
                                    guard let image = strongSelf.imageView.image,
                                          let imageData = image.pngData() else {
                                        return
                                    }
                                    
                                    var safeEmail = email.replacingOccurrences(of: ".", with: "_")
                                    safeEmail = safeEmail.replacingOccurrences(of: "@", with: "_")
                                    
                                    let fileName = "\(safeEmail)_profile_picture.png"
                                    
                                    
                                    
                                    db.collection("users").document(result!.user.uid).setData(["firstname":firstName,
                                                                                               "lastname":lastName,
                                                                                               "nickname":firstName,
                                                                                               "useremail":email,
                                                                                               "uid":result!.user.uid,
                                                                                               "points": 100]) { (error) in
                                        if error != nil {
                                            // Show error message
                                            print("Error creating user account")
                                        }}
                                    
                                    StorageManager.shared.uploadProfilePicture(with: imageData, fileName: fileName) { result in
                                        switch result {
                                        case .success(let downloadUrl):
                                            UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_rul")
                                            print(downloadUrl)
                                        case .failure(let error):
                                            print("Storage manager error: \(error)")
                                        
                                            
                                        }
                                    }
                                    strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                                    
                                }
            
        })
        
    }
    
    
    
    
    // to tell the user to enter all information
    func alertUserloginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to create a new account.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    
    // this private function can only be accessed by this class
    // action of going to the the RegisterViewController
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: - Showing Error errror: String
    
    func showAlert(errorMessage: String) {
        
        let alert = UIAlertController(title: "Failed to create account", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print(errorMessage)
            
        }))
        
        present(alert, animated: true)
    }
    
    
    
}




// handle the text field delegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
    
}

// handle selecting profile picture
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // action sheet
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentCamera()
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentPhotoPicker()
                                            }))
        present(actionSheet, animated: true)
    }
    
    //
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
