//
//  WebviewViewController.swift
//  CompanyTest
//
//  Created by Hitendra Dubey on 20/06/20.
//  Copyright © 2020 Hitendra Dubey. All rights reserved.
//

import UIKit
import WebKit

class WebviewViewController: UIViewController{

    
    var timmer : Timer?
    var time = 0
    var url : URL?
    var isYoutubeUrl = false
    lazy var webView = WKWebView()
    private var activityIndicatorContainer: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    var delegate : getYoutubeWatchedTimmer?

    lazy var alert = AlertView(frame: CGRect(x: self.view.frame.maxX-40, y: self.view.frame.maxY-100, width: 40, height: 40))
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUrl()
    }
    
    
    func checkUrl()
    {
        guard let searchUrl = url else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        if searchUrl.host == "www.youtube.com"
        {
            webView.addSubview(alert)
            isYoutubeUrl = true
            timmer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimmer), userInfo: nil, repeats: true)
        }
        addWebviewInView(url: searchUrl)

        
    }
    
    func addWebviewInView(url : URL)
    {
        let urlRequest = URLRequest(url: url)
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        let guide = view.safeAreaLayoutGuide
        webView.setAnchors(top: guide.topAnchor, left: view.leftAnchor, bottom: guide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        setToolBar()
        webView.load(urlRequest)
    }
    
    @objc func updateTimmer(){
        time += 1
        alert.label.text = "\(time)"
        print("test")
    }

}


// To set Toolbar
extension WebviewViewController{
    
      fileprivate func setToolBar() {
        let screenWidth = self.view.bounds.width
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolBar.isTranslucent = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.items = [backButton]
        webView.addSubview(toolBar)
    // Constraints
        toolBar.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0).isActive = true
      }
      @objc private func goBack() {
        if webView.canGoBack {
          webView.goBack()
        } else {
          self.dismiss(animated: true, completion: nil)
          timmer?.invalidate()
            if isYoutubeUrl
            {
                sendDurationofUnrestrictedContentWatched()
            }
        }
      }
    
    func sendDurationofUnrestrictedContentWatched()
    {
        // with Notification
        let timeDataDict:[String: Int] = ["time": time]
        NotificationCenter.default.post(name: .timeData, object: nil, userInfo: timeDataDict)
        
        //with delegate
        //uncomment below code for delegate method
        //delegate?.getTimmer(time: time)
    }
    
}

// show activity Indicator
extension WebviewViewController: WKNavigationDelegate{
    
      fileprivate func setActivityIndicator() {
        // Configure the background containerView for the indicator
        activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicatorContainer.center.x = webView.center.x
        // Need to subtract 44 because WebKitView is pinned to SafeArea
        //   and we add the toolbar of height 44 programatically
        activityIndicatorContainer.center.y = webView.center.y - 44
        activityIndicatorContainer.backgroundColor = UIColor.black
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
      
        // Configure the activity indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorContainer.addSubview(activityIndicator)
        webView.addSubview(activityIndicatorContainer)
        
        // Constraints
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
      }
    
      fileprivate func showActivityIndicator(show: Bool) {
        if show {
          activityIndicator.startAnimating()
        } else {
          activityIndicator.stopAnimating()
          activityIndicatorContainer.removeFromSuperview()
        }
      }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      self.showActivityIndicator(show: false)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      // Set the indicator everytime webView started loading
      self.setActivityIndicator()
      self.showActivityIndicator(show: true)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      self.showActivityIndicator(show: false)
    }
}
