//
//  ViewController.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 02.05.2023.
//

import UIKit

final class TaskListViewController: UIViewController, TaskListView {
    
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    private let coordinator: Coordinator
    var presenter: TaskListPresenter!
    private var tasksList: [[Task]]!
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: "TaskListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "cat")
        
        setUpNavBar()
        setUpTableView()
        setUpBackButton()
        setUpEditButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateTaskListData()
    }
    
    func updateTaskListData(tasks: [[Task]]) {
        self.tasksList = tasks
        taskListTableView.reloadData()
    }
    
    func updateViewBackground(isHidden: Bool) {
        taskListTableView.isHidden = isHidden
        backgroundImageView.isHidden = !isHidden
    }
    
    @IBAction private func buttonWasTapped(_ sender: UIButton) {
        coordinator.navigateToAddNewTaskVC(from: self, task: nil)
    }
    
    private func setUpBackButton() {
        let backButton = UIBarButtonItem(title: String.localized(text: "Back"), style: .plain, target: nil, action: nil)
        backButton.tintColor = .red
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setUpEditButton() {
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let systemIconView = UIImageView(image: UIImage(systemName: "list.bullet"))
        systemIconView.contentMode = .scaleAspectFit
        systemIconView.tintColor = .red
        systemIconView.translatesAutoresizingMaskIntoConstraints = false
        
        let editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.red, for: .normal)
        editButton.addTarget(self, action: #selector(toggleEditMode), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(systemIconView)
        containerView.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            systemIconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            systemIconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            systemIconView.widthAnchor.constraint(equalToConstant: 24),
            systemIconView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            editButton.leadingAnchor.constraint(equalTo: systemIconView.trailingAnchor, constant: 0),
            editButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            editButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            editButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        let customBarButtonItem = UIBarButtonItem(customView: containerView)
        navigationItem.rightBarButtonItem = customBarButtonItem
    }
    
    private func setUpTableView() {
        taskListTableView.register(TaskTableViewCell.getNib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
        
        taskListTableView.dataSource = self
        taskListTableView.delegate = self
    }
    
    private func handleDeleteSwipe(_ task: Task) {
        presenter.deleteTask(id: task.id)
    }
    
    private func handleEditAction(_ task: Task) {
        coordinator.navigateToAddNewTaskVC(from: self, task: task)
    }
    
    private func handleCompleteAction(_ task: Task) {
        presenter.updateTaskStatus(id: task.id)
    }
    
    @objc private func toggleEditMode() {
        let isEditing = taskListTableView.isEditing
        taskListTableView.setEditing(!isEditing, animated: true)
    }
    
    private func createDeleteAction(task: Task) -> UIContextualAction  {
        let deleteAction =  UIContextualAction(
            style: .destructive,
            title: nil) { [weak self]
                (action, view, completionHandler) in
                
                let alert = UIAlertController(title: String.localized(text: "Delete Confirmation"),
                                              message: String.localized(text: "Delete the task?"),
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: String.localized(text: "Yes"),
                                              style: .default,
                                              handler: { _ in
                    self?.handleDeleteSwipe(task)
                    completionHandler(true)
                }))
                
                alert.addAction(UIAlertAction(title: String.localized(text: "No"),
                                              style: .cancel,
                                              handler: { _ in
                    completionHandler(false)
                }))
                
                self?.present(alert, animated: true, completion: nil)
            }
        deleteAction.image = UIImage(systemName: "basket.fill")
        deleteAction.backgroundColor = .systemRed
        
        return deleteAction
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasksList.allSatisfy{ $0.isEmpty } ? 0 : tasksList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasksList[section].count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        sourceIndexPath.section != destinationIndexPath.section
        ? tableView.reloadData()
        : presenter.rearrengeTasks(firstId: sourceIndexPath.row,
                                   secondId: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = tasksList[indexPath.section][indexPath.row]
        cell.configure(with: task)
        
        indexPath.row == tasksList[indexPath.section].count - 1
        ? cell.hideSeparator()
        : cell.showSeparetor()
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = tasksList[indexPath.section][indexPath.row]
        
        let completeAction = UIContextualAction(style: .destructive,
                                                title: nil) { [weak self]
            (action, view, completionHandler) in
            self?.handleCompleteAction(task)
            completionHandler(true)
        }
        
        completeAction.image = UIImage(systemName: "checkmark")
        completeAction.backgroundColor = .systemGreen
        
        let config = UISwipeActionsConfiguration(actions: [completeAction])
        
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = tasksList[indexPath.section][indexPath.row]
        
        let deleteAction  = createDeleteAction(task: task)
        
        let editAction = UIContextualAction(style: .destructive,
                                            title: nil) { [weak self]
            (action, view, completionHandler) in
            self?.handleEditAction(task)
            completionHandler(true)
        }
        
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemYellow
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return config
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let headerLabel = UILabel(frame: CGRect(x: 0, y: -8, width: tableView.frame.width, height: 30))
        headerLabel.text = section == 0
        ? String.localized(text: "Active")
        : String.localized(text: "Completed")
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textColor = .black
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasksList[indexPath.section][indexPath.row]
        coordinator.navigateToAddNewTaskVC(from: self, task: task)
    }
}

extension TaskListViewController: NavigationBarSetup {
    func setUpNavBar() {
        self.title = String.localized(text: "Task Manager")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.layoutSubviews()
    }
}

extension TaskListViewController: TaskTableViewCellDelegate {
    func didTouchStatusButton(id: UUID) {
        presenter.updateTaskStatus(id: id)
    }
    
    func didSelectCell(id: UUID) {
        coordinator.navigateToAddNewTaskVC(from: self,
                                           task: tasksList.flatMap { $0 }.first(where: { $0.id == id }))
    }
}
