//
//  OpenExternalUtil.swift
//  HelloBuildTest
//
//  Created by Andres Rivillas on 10/09/24.
//

import UIKit

func openMailApp(_ email: String, subject: String = "", body: String = "") {
    guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
          let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
          let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
          let mailURL = URL(string: "mailto:\(encodedEmail)?subject=\(encodedSubject)&body=\(encodedBody)")
    else {
        return
    }
    
    if UIApplication.shared.canOpenURL(mailURL) {
        UIApplication.shared.open(mailURL)
    }
}


func dialPhoneNumber(_ phoneNumber: String) {
    guard let phoneURL = URL(string: "tel://\(phoneNumber)"),
          UIApplication.shared.canOpenURL(phoneURL)
    else {
        return
    }
    
    UIApplication.shared.open(phoneURL)
}
