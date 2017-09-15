//
//  WebView.swift
//  WorldTrotter
//
//  Created by Sophia Shaw on 9/14/17.
//  Copyright © 2017 Soph Shaw. All rights reserved.
//
import UIKit
import WebKit

class WebView: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.bignerdranch.com/")
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
