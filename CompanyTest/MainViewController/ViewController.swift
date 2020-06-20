//
//  ViewController.swift
//  CompanyTest
//
//  Created by Hitendra Dubey on 20/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UINavigationController,UISearchBarDelegate{

    // Initilise main view
    lazy var browserView = BrowserView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBrowserView()
        
        //hide keyboard on tap
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(showTimmer(_ :)), name: .timeData, object: nil)
    }
    
    func addBrowserView()
    {
        browserView.browser.delegate = self
        self.view.addSubview(browserView)

    }

    // Search Button Pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchLink = browserView.browser.text else {return}
        openUrlInternally(urlString: searchLink)
    }

    //open webview to show url
    func openUrlInternally(urlString: String)
    {
        var checkUrl = urlString.lowercased()
        if !checkUrl.contains("https://")
        {
            checkUrl = "https://"+checkUrl
        }
        guard let url = URL(string: checkUrl) else {return}

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WebviewViewController") as? WebviewViewController
            else {return}
        vc.url = url
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    
    }
    
    
}

// SHow how much time user use youtube
extension MainViewController: getYoutubeWatchedTimmer{
    func getTimmer(time: Int) {
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds:time)
        showAlert(hour: h, min: m, sec: s)
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    //Notification function to show timmer
    @objc func showTimmer(_ notification : NSNotification)
    {
        guard let time = notification.userInfo?["time"] as? Int else {return}
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: time)
        showAlert(hour: h, min: m, sec: s)
    }
    
    //Delegate functaion to show Timmer
    func showAlert(hour: Int,min: Int,sec: Int)
    {
        let alert = UIAlertController(title: "Restricted Content Watched", message: "You have watched Restricted content for \(hour) H:\(min) M:\(sec) S", preferredStyle: .alert)
        
        alert.view.clipsToBounds = true
        alert.view.sizeToFit()
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
