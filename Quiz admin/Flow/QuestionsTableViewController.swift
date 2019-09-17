//
//  QuestionsTableViewController.swift
//  Quiz admin
//
//  Created by kant on 17/09/2019.
//  Copyright © 2019 kant. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController {
    
    // MARK: Dependencies
    
    private let cellMAnager = CellManager()
    private let networkManager = NetworkManager<Question>(apiURL: "http://localhost:8080/questions")!
    
    // MARK: Private properties
    
    private var questions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getAll { (questions, error) in
            guard let questions = questions as? [Question] else { return }
            self.questions = questions
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource implementation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        let question = questions[indexPath.row]
        cellMAnager.configure(cell, with: question)
        return cell
    }
}
