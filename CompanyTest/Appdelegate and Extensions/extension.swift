//
//  extension.swift
//  CompanyTest
//
//  Created by Hitendra Dubey on 20/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//
import UIKit
import Foundation

extension UIView {
func setAnchors(top:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,right:NSLayoutXAxisAnchor?,paddingTop:CGFloat,paddingLeft:CGFloat,paddingBottom:CGFloat,paddingRight:CGFloat,height:CGFloat,width:CGFloat)
{
  self.translatesAutoresizingMaskIntoConstraints = false
  if let top = top
  {
    self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
  }
  if let left = left
  {
    self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
  }
  if let bottom = bottom
  {
    self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
  }
  if let right = right
  {
    self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
  }
  if height != 0
  {
    self.heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  if width != 0
  {
    self.widthAnchor.constraint(equalToConstant: width).isActive = true
  }
}
}

extension UIViewController {
    
    /**
     Hides the keyboard when tapped anywhere on the screen
     Call this in view did load
     
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NSNotification.Name
{
    static let timeData = Notification.Name("timeData")
}
