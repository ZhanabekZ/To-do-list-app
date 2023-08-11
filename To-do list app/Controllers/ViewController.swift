//
//  ViewController.swift
//  To-do list app
//
//  Created by ZhZinekenov on 09.08.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let tableView = UITableView()
    var fetchedResultsController: NSFetchedResultsController<Task>?
    let countLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To-do list"
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        view.backgroundColor = .systemBlue
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let createButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonTapped))
        navigationItem.rightBarButtonItem = createButton
        tableView.delegate = self
        tableView.dataSource = self

        DispatchQueue.main.async {
            self.setupUI()
            self.setupFetchedResultsController()
            self.refreshCountLabel()
        }
    }
    
    func setupUI() {
        countLabel.textColor = .white
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(countLabel)
        tableView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - NSFetchedResultsController functions
    func setupFetchedResultsController() {
        fetchedResultsController = createNotesFetchedResultsController()
        
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
        refreshCountLabel()
    }
    
    func createNotesFetchedResultsController() -> NSFetchedResultsController<Task> {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Task.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func refreshCountLabel() {
        let count = fetchedResultsController!.sections![0].numberOfObjects
        countLabel.text = "\(count) \(count == 1 ? "Task" : "Tasks")"
    }
    
    // MARK: - Task creation functions
    @objc func createButtonTapped() {
        let ac = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let textField = ac.textFields?.first, let enteredText = textField.text {
                DispatchQueue.main.async {
                    self.addNewTask(enteredText)
                }
            }
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    func addNewTask(_ text: String) -> Task {
        let task = appDelegate.createTask(name: text)
        return task
    }
}

