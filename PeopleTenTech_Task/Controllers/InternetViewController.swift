//
//  SecondViewController.swift
//  PeopleTenTech_Task
//
//  Created by Raghuram on 29/05/20.
//  Copyright © 2020 Raghuram. All rights reserved.
//

import UIKit
import WebKit

class InternetViewController: UIViewController ,WKNavigationDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Internet"
        self.view.addSubview(webView)
        webViewCons()
        //navigationButtons()
    }

    
    var webView:  WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        var request = URLRequest(url: URL.init(string: Constants.webUrl)!)
        webView.load(request)
         webView.allowsBackForwardNavigationGestures = true
        return webView
        
    }()
    
    func webViewCons(){
        
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    

}

