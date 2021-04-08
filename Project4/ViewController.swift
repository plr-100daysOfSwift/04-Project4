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
	var website: String?

	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		if let website = website {
			let url = URL(string: "https://" + website)!
			webView.load(URLRequest(url: url))
			webView.allowsBackForwardNavigationGestures = true
			webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
		}

		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		let back = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: webView, action: #selector(webView.goBack))
		let forward = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: webView, action: #selector(webView.goForward))
		toolbarItems = [progressButton, spacer, back, spacer, forward, spacer, refresh]
		navigationController?.isToolbarHidden = false
	}

	// MARK: - Key-Value Observing

	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}

	// MARK: - WKNavigationDelegate
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}

	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url
		if let website = website, let host = url?.host {
				if host.contains(website) {
					decisionHandler(.allow)
					return
				}
		}

		decisionHandler(.cancel)
		let ac = UIAlertController(title: "This link is blocked.", message: url?.absoluteString, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}
}

