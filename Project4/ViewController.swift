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
	var progressView: UIProgressView!

	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let url = URL(string: "https://www.hackingwithswift.com")!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
																												style: .plain,
																												target: self,
																												action: #selector(openTapped))

		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		toolbarItems = [progressButton, spacer, refresh]
		navigationController?.isToolbarHidden = false

	}

	@objc func openTapped() {
		let ac = UIAlertController(title: "Open ...", message: nil, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
		ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
		present(ac, animated: true)
	}

	@objc func openPage(action: UIAlertAction) {
		let url = URL(string: "https://www." + action.title!)!
		webView.load(URLRequest(url: url))
	}

	// MARK: - WKNavigationDelegate
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
}

