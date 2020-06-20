//
//  BrowserView.swift
//  CompanyTest
//
//  Created by Hitendra Dubey on 20/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//
import UIKit
import Foundation

class BrowserView : UIView{
    
    let LogoImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icons8-ios-logo-64")
        return imageView
        
    }()
    
    let title : UILabel = {
        let logoTitle = UILabel()
        logoTitle.text = "What You Are Looking For!"
        logoTitle.textColor = .black
        logoTitle.font = .boldSystemFont(ofSize: 12)
        return logoTitle
    }()
    
    let browser : UISearchBar = {
       
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.barStyle = .default
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundColor = .clear
        searchBar.layer.cornerRadius = 4
        searchBar.clipsToBounds = true
        searchBar.autocapitalizationType = .none
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 46/255, green: 64/255, blue: 87/255, alpha: 1)
        addSubview(LogoImageView)
        addSubview(title)
        addSubview(browser)
        addConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func addConstraints() {
        super.updateConstraints()
        
        LogoImageView.setAnchors(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 100, width: 100)
        LogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.setAnchors(top: LogoImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 22, width: 0)
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        browser.setAnchors(top: title.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, height: 40, width: 0)
    }
}


protocol getYoutubeWatchedTimmer {
    func getTimmer(time: Int)
}
