//
//  AnswersTableViewController.swift
//  Quiz admin
//
//  Created by kant on 17/09/2019.
//  Copyright © 2019 kant. All rights reserved.
//

import UIKit

class AnswersTableViewController: UITableViewController {
    
    // MARK: Dependencies
    
    private let cellMAnager = CellManager()
    private let networkManager = NetworkManager<Answer>(apiURL: "http://localhost:8080/answers")!
    
    // MARK: Private properties
    
    private var answers = [Answer]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getAll { (answers, error) in
            guard let answers = answers as? [Answer] else { return }
            self.answers = answers
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource implementation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        let answer = answers[indexPath.row]
        cellMAnager.configure(cell, with: answer)
        return cell
    }
}
