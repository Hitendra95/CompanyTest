//
//  Alert.swift
//  CompanyTest
//
//  Created by Hitendra Dubey on 20/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import Foundation
import UIKit

class AlertView : UIView{
    
    let label : UILabel = {
        
        let lb = UILabel()
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 12)
        lb.textAlignment = .center
        return lb
    }()
    
   override init(frame: CGRect) {
       super.init(frame: frame)
       backgroundColor = .white
       addSubview(label)
       addConstraints()

   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   
   fileprivate func addConstraints() {
       super.updateConstraints()
        backgroundColor = UIColor(red: 94.255, green: 194/255, blue: 236/255, alpha: 1)
        label.setAnchors(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 20, width: 20)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
   }
    
}
