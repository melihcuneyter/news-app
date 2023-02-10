//
//  NewsDisplayVC.swift
//  news-app
//
//  Created by Melih Cüneyter on 8.02.2023.
//

import UIKit
import WebKit

final class NewsDisplayVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var url: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let url = URL(string: self.url!)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
