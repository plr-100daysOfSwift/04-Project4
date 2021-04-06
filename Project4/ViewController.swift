//
//  ViewController.swift
//  Project4
//
//  Created by Paul Richardson on 07/04/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {

	var webView: WKWebView!

	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		webView.allowsBackForwardNavigationGestures = true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

