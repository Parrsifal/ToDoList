//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 11.05.2023.
//

import UIKit

final class AddTaskViewController: UIViewController, AddTaskView {
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var createTaskButton: UIButton!
    @IBOutlet private weak var titleErrorMessageLabel: UILabel!
    @IBOutlet private weak var bottomSpace: NSLayoutConstraint!
    
    private var coordinator: Coordinator
     var presenter: AddEditTaskPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setUpScreenMode()
        registerKeyboardNotifcations()
        createTaskButton.alpha = 0
    }
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: String(describing: AddTaskViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func inputFieldsChanged(_ sender: UITextField) {
        presenter.inputFieldsWasChanged(titleTextField.text!, descriptionTextField.text)
    }
    
    @IBAction private func buttonDidTouch(_ sender: UIButton) {
        presenter.buttonDidTouch(title: titleTextField.text!, description: descriptionTextField.text)
        coordinator.navigateToRootVC(from: self)
    }
    
    func setUpScreenMode() {
        presenter.setUpScreenMode(title: titleTextField.text ?? "", description: descriptionTextField.text)
    }
    
     func setUpEditScreenMode(title: String, description: String?){
        self.title = "Edit task"
        self.createTaskButton.setTitle("Save task", for: .normal)
        self.descriptionTextField.text = description
        self.titleTextField.text = title
    }
    
     func setUpAddScreenMode(){
        self.title = "Add task"
        self.createTaskButton.setTitle("Add task", for: .normal)
    }
    
    func showButton(isHiden: Bool) {
        if isHiden {
            UIView.animate(withDuration: 0.5) {
                self.createTaskButton.alpha = 1.0
            }
        } else {
            self.createTaskButton.alpha = 0
        }
        createTaskButton.isHidden = !isHiden
        titleErrorMessageLabel.text = Constants.errorTitleMessage
        titleErrorMessageLabel.isHidden = isHiden
    }
    
    func reloadStatus() {
        titleTextField.text = ""
        descriptionTextField.text = ""
        hideKeyboard()
        createTaskButton.alpha = 0
    }
    
    func setupTextFields() {
        let titleInset = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 40))
        titleTextField.leftView = titleInset
        titleTextField.leftViewMode = .always
        titleTextField.layer.cornerRadius = 16
        
        let descriptionInset = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 40))
        descriptionTextField.leftView = descriptionInset
        descriptionTextField.leftViewMode = .always
        descriptionTextField.layer.cornerRadius = 16
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
