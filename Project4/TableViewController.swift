//
//  TableViewController.swift
//  Project4
//
//  Created by Paul Richardson on 09/04/2021.
//

import UIKit

class TableViewController: UITableViewController {

	var websites = ["apple.com", "hackingwithswift.com", "duckduckgo.com"]

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Websites"
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return websites.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath)
		cell.textLabel?.text = websites[indexPath.row]
		return cell
	}

	// MARK: - Table view delegate

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "ViewController") as ViewController
		vc.website = websites[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
}
