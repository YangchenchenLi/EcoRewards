//
//  WebViewCtrl.swift
//  QRtest
//
//  Created by Yiwei Gao on 2020/9/25.
//  Author: Yiweo Gao.
//  Copyright © 2020 YiweiGao. All rights reserved.
//
// The QR code created from https://www.wwei.cn

import UIKit
import WebKit

class WebViewCtrl: UIViewController {

    @IBOutlet var webview: WKWebView!
    var url : NSString!
    
    // extract the URL in the QR code and send the content to the view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        let strURL = NSURL(string: url as String)
        // create quest based on URL
        let urlRequest = URLRequest(url: strURL! as URL)
        webview.load(urlRequest)
    }


}
