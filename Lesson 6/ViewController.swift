//
//  ViewController.swift
//  Lesson 6
//
//  Created by Phan Dinh Van on 3/14/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var googleRepos: [GoogleRepos]?
    @IBOutlet weak var tblView: UITableView!
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleRepos = [GoogleRepos]()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        tblView.estimatedRowHeight = 100
        tblView.rowHeight = UITableView.automaticDimension
        self.getData()
    }

    func getData() {
        let group = DispatchGroup()
        let url = URL(string: "https://api.github.com/users/google/repos")
        let session = URLSession.shared
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = session.dataTask(with: url!) { (data, response, error) in
                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    guard let jsons = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Any> else {
                        throw JSONError.ConversionFailed
                    }
                    for json in jsons {
                        if let element = json as? [String: Any] {
                            let repos = GoogleRepos(JSON: element)
                            self.googleRepos?.append(repos!)
                        }
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error as NSError {
                    print(error.debugDescription)
                }
                print(self.googleRepos?.count)
                group.leave()
            }
            dataTask.resume()
        }
        group.notify(queue: .main) {
            self.tblView.reloadData()
        }
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return googleRepos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reposcell", for: indexPath) as! ReposCell
        cell.lblName.text = googleRepos?[indexPath.row].name
        cell.lblDescription.text = googleRepos?[indexPath.row].description
        cell.lblLanguage.text = googleRepos?[indexPath.row].language
        if let watchers = googleRepos?[indexPath.row].watchers_count, let stars = googleRepos?[indexPath.row].stargazers_count, let forks = googleRepos?[indexPath.row].forks_count {
            cell.lblWatchersCount.text = "\(watchers)"
            cell.lblStarsCount.text = "\(stars)"
            cell.lblForksCount.text = "\(forks)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
