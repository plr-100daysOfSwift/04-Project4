//
//  ViewController.swift
//  Project4
//
//  Created by Paul Richardson on 07/04/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

	var webView: WKWebView!

	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

