//
//  BackEndSinglton.swift
//  Todd 1.0
//
//  Created by Rabus Mccaleb on 3/17/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class BackendSingleton{
    private init(){/* back end singlton init of no real use*/}
    static var share = BackendSingleton()
    
    var SignInPasswordInitial : String?
    var SignInEmail : String?
    //                                                          The basic logic for email password athenitcate... not ready yet... build the ui's make sure they look right and can allow for easy functional connection.
    ///                                     Signing up for emial and passowrd :
    
    
    var ContinueTitle : String?
    var ContinueArtists : String?
    var ContinueImage : String?
    var ContinueContentType : String?
    var ContinueSummary : String?// will be a Url in th future
    var ContinueRefferenceToContent : String?// will be a Url to grab the tree such that all the data can be loaded
    var ContinueCreatorsImage : String?
    var ThereIsUnfinishedContent : Bool = true
    func ContinueContent()-> Bool{
    // meant to make requests to back end for user unfinished content
        if(ThereIsUnfinishedContent == true){// soon this will check if there is content on the backend that is unfinished
            
            return true
        }else{
            return false
        }
    }
    
    
    func PassWordSet(PasswordStrings : String) -> Bool{
        var PasswordDataType = NSPredicate(format : "SELF MATCHES %@", "^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%?])[0-9A-Za-z!@#$%?]{8,20}$")
        return PasswordDataType.evaluate(with: PasswordStrings)
    }
        
        var PasswordInitial : String?
        var PasswordConfimation : String?
        func PasswordComparisonCheck( InitialPassword : String? , ConfirmPassword : String?)-> String?{
            if InitialPassword != nil && ConfirmPassword != nil {
                if InitialPassword == ConfirmPassword{
                    //if PassWordSet(PasswordStrings: InitialPassword!) ==  true{// force unwrapped because we should know if the data is nil or not by then
                        return InitialPassword
//                    }else{
//                        return nil
//                    }
                    }else{
                        return nil
                    }
                }else{
                        return nil
            }
        }
    
    
    
        var UserName : String?
        var Email : String?
        var Password : String?
        
        func CheckIfUserNameEmailPasswordIsNotNil()->Bool{
            if UserName == nil || Email == nil || Password == nil{
                if UserName == nil {
                    // will be used to notify the user that the feild is empty in the future... just not quite yet
                    print("UserName is Empty")
                }
                if Email == nil {
                    // will be used to notify the user that the feild is empty in the future... just not quite yet
                    print("Email is Empty")
                }
                if PasswordInitial == nil {
                    // will be used to notify the user that the feild is empty in the future... just not quite yet
                    print("Password is Empty")
                }
                
                return false
            }else{ return true}
    }
    
    
    
    
    
    func FetchData(){
       // Firestore.firestore().
    }
    
    
    
    
    
    
    
        func signUp(){
                Auth.auth().createUser(withEmail: self.Email!, password: self.PasswordInitial!, completion: { AuthDataResult, Error in
                if let err = Error {
                    // call function to throw an error that the email or password was not a placed into the system and to not allow the next view to be navigated to
                }
                    let DataBase  = Firestore.firestore()
                    DataBase.collection("Users").addDocument(data: ["UserName" : self.UserName! ], completion: {(Error) in
                        if Error != nil {
                            print("Error loading data")
                        }
                    })
                if let ThisUser = Auth.auth().currentUser?.createProfileChangeRequest(){
                    ThisUser.displayName = self.UserName!
                    ThisUser.commitChanges(completion: {(error) in
                        if let ErrorAddingUserName = error {
                    // Here is where you do the same thing call function to throw an error that the email or password was not a placed into the system and to not allow the next view to be navigated to                    }
                            self.eitherFailedOrSuccessfulSignUp(false)
                        }else{
                            self.eitherFailedOrSuccessfulSignUp(true)
                                }// else statment for commit changes completion handler
                            }// completion hander for commit changes end bracket
                        )//commit changes end parentheses
                    }//adding user name completion handler end bracket
                }// adding email password completion handeler end bracket
            )// create user parantheses
        }// function end bracket
    
    
    
    
    
    
    
        func eitherFailedOrSuccessfulSignUp(_ SignUpWasSuccessful : Bool){
            if SignUpWasSuccessful == true{
                // propper sign up animation
                print("Sign Up Was A Success Woop Woop \n BackendSingleton class eitherFailedOrSuccessfulSignUp() method")
            }else{
                // Tell the user to re-enter data/ check data because the signup wasn't successful... password should delete on the re-entry attempt
            }
        }
    
    
    
    
    
    
    
    
        func signIn(){
            Auth.auth().signIn(withEmail: self.SignInEmail ?? "" , password: self.SignInPasswordInitial ?? "" ,  completion: { AuthDataResult, Error in
                if let err = Error {
                    // call function to throw an error that the email or password was not a placed into the system and to not allow the next view to be navigated to
                }else{
                    print(AuthDataResult!)
                }
                
            })
        }
    
    
        func checkForValidEmailProtocol(_ email : String){
            if email == nil || email == ""{
                // if nothing is in the email space then automatically return to the user that they need to enter a valid email
                // else we will do the email check to see if it conforms to protocol
            }else{
    
            }
        }
    
//    var ColorTester = #colorLiteral(red: 0.2572472394, green: 0.5592103004, blue: 1, alpha: 1)
//
//    var ColorTester2 = #colorLiteral(red: 1, green: 0.7855075598, blue: 0.2572472394, alpha: 1)
}



