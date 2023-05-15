//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 11.05.2023.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var titleErrorMessageLabel: UILabel!
    @IBOutlet var bottomSpace: NSLayoutConstraint!
    
    var coordinator: Coordinator
    var presenter: AddEditTaskPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddTaskNavBar()
        registerKeyboardNotifcations()
        createTaskButton.alpha = 0
    }
    
    init(presenter: AddEditTaskPresenter, coordinator: Coordinator) {
        self.coordinator = coordinator
        self.presenter = presenter
        super.init(nibName: "AddTaskViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAddTaskNavBar() {
        self.title = "Add Task"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func titleFieldChanged(_ sender: UITextField) {
        if !isValidTaskTitle(titleTextField.text) {
            titleErrorMessageLabel.text = Constants.errorTitleMessage
            titleErrorMessageLabel.isHidden = false
            createTaskButton.isHidden = true
        } else {
            createTaskButton.isHidden = false
            titleErrorMessageLabel.isHidden = true
            UIView.animate(withDuration: 0.5) {
                self.createTaskButton.alpha = 1.0
            }
        }
    }

    private func isValidTaskTitle(_ title: String?) -> Bool {
        if let title = title {
            if title.count > 4 && title.count < 15 {
                return true
            }
        }
        return false
    }
    
    @IBAction func createTask(_ sender: UIButton) {
        let newTask = Task(title: titleTextField.text ?? "", description: descriptionTextField.text)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow(notification: )),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func kbWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            bottomSpace.constant = keyboardHeight + 10
            print(bottomSpace.constant)
        }
    }
    
    @objc private func kbWillHide() {
        bottomSpace.constant = 34
    }
}
