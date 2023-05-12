//
//  ViewController.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 02.05.2023.
//

import UIKit

final class TaskListViewController: UIViewController {
    
    @IBOutlet weak var taskListTableView: UITableView!
    
    @IBOutlet weak var addTaskButton: UIButton!
    
    var coordinator: Coordinator
    var presenter: TaskListPresenter
    var tasksList: [[Task]] {
        presenter.getTasks()
    }
    
    init(coordinator: Coordinator, presenter: TaskListPresenter) {
        self.coordinator = coordinator
        self.presenter = presenter
        super.init(nibName: "TaskListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTaskListNavBar()
        setUpTableView()
        setUpBackButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskListTableView.reloadData()
    }
    
    @IBAction func didTouchButton(_ sender: UIButton) {
        coordinator.addNewTask(from: self)
    }
    
    private func setUpBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        backButton.tintColor = .red
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setUpTableView() {
        taskListTableView.register(TaskTableViewCell.getNib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
        
        taskListTableView.dataSource = self
        taskListTableView.delegate = self
    }
    
    private func setUpTaskListNavBar() {
        self.title = "Task Manager"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.layoutSubviews()
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasksList.allSatisfy{ $0.isEmpty } ? 0 : tasksList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasksList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = tasksList[indexPath.section][indexPath.row]
        cell.configure(with: task)
        
        if indexPath.row == tasksList[indexPath.section].count - 1 {
            cell.hideSeparator()
        } else {
            cell.showSeparetor()
        }
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let headerLabel = UILabel(frame: CGRect(x: 0, y: -8, width: tableView.frame.width, height: 30))
        headerLabel.text = section == 0 ? "Active" : "Completed"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textColor = .black
        headerView.addSubview(headerLabel)
        return headerView
    }
}
