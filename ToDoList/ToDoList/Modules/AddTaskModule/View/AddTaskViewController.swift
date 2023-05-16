//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 11.05.2023.
//

import UIKit

enum TaskDetailsScreenMode {
    case addTask
    case editTask
}

final class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var titleErrorMessageLabel: UILabel!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    
    var coordinator: Coordinator
    var presenter: AddEditTaskPresenter
    
    var screenMode: TaskDetailsScreenMode = .addTask
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenMode = task != nil ? .editTask : .addTask
        setUpAddTaskNavBar(screenMode)
        registerKeyboardNotifcations()
        createTaskButton.alpha = 0
        
    }
    
    init(presenter: AddEditTaskPresenter, coordinator: Coordinator, task: Task? = nil) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.task = task
        super.init(nibName: String(describing: AddTaskViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAddTaskNavBar(_ screenMode: TaskDetailsScreenMode) {
        let title = screenMode == .addTask ? "Add Task" : "Edit Task"
        
        self.title = title
        let buttonTitle = screenMode == .addTask ? "Create Task" : "Save Task"
        self.createTaskButton.setTitle(buttonTitle, for: .normal)
        self.titleTextField.text = task?.title
        self.titleTextField.layer.cornerRadius = 15
        self.descriptionTextField.text = task?.description
    }
    
    private func setUpEditScreen() {
        self.title = "Edit task"
        titleTextField.text = task?.title
        descriptionTextField.text = task?.description
    }
    
    @IBAction func InputFieldsChanged(_ sender: UITextField) {
        if isValidTaskInput(titleTextField.text) && isValidTaskInput(descriptionTextField.text) {
            
            createTaskButton.isHidden = false
            titleErrorMessageLabel.isHidden = true
            UIView.animate(withDuration: 0.5) {
                self.createTaskButton.alpha = 1.0
            }
        } else {
            titleErrorMessageLabel.text = Constants.errorTitleMessage
            titleErrorMessageLabel.isHidden = false
            createTaskButton.isHidden = true
            
        }
    }
    
    private func isValidTaskInput(_ inputText: String?) -> Bool {
        if let inputText {
            return (inputText.count > 4 && inputText.count < 15)
        }
        return false
    }
    
    @IBAction func createTask(_ sender: UIButton) {
        let newTask = Task(title: titleTextField.text! , description: descriptionTextField.text)
      //  screenMode == .addTask ? presenter.addTask(task: newTask) : presenter.
        presenter.addTask(task: newTask)
        coordinator.navigateToRootVC(from: self)
        reloadStatus()
    }
    
    func reloadStatus() {
        titleTextField.text = ""
        descriptionTextField.text = ""
        hideKeyboard()
        createTaskButton.alpha = 0
    }
    
    private func registerKeyboardNotifcations() {
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyaboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            bottomSpace.constant = keyboardHeight + 10
            print(bottomSpace.constant)
        }
    }
    
    @objc private func keyaboardWillHide() {
        bottomSpace.constant = 34
    }
}

extension AddTaskViewController: NavigationBarSetup {
    func setUpNavBar() {
        self.title = "Add Task"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
