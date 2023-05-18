//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func didTouchStatusButton(id: Int)
    func didSelectCell(id: Int)
}

final class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var textFieldsVStack: UIStackView!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var isCompletedButton: UIButton!
    @IBOutlet private weak var taskTitleLabel: UILabel!
    @IBOutlet private weak var textDescriptionLabel: UILabel!
    static let identifier = "TaskCell"
    weak var delegate: TaskTableViewCellDelegate?
    var task: Task?
    
    func configure(with task: Task) {
        self.task = task
        updateTaskStatus()
        setUpTextFieldsStack()
    }
    
    @objc private func didTapCell() {
        if let task {
            delegate?.didSelectCell(id: task.id)
        }
    }
    
    private func setUpTextFieldsStack() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTapCell))
        textFieldsVStack.isUserInteractionEnabled = true
        textFieldsVStack.addGestureRecognizer(tap)
    }
    
    private func updateTaskStatus() {
        guard let task else { return }
        
        let foo: NSMutableAttributedString = NSMutableAttributedString(string: task.title,
                                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        let fooRange: NSRange = NSRange(location: 0, length: foo.length)
        
        if task.isCompleted {
            
            foo.addAttributes([NSAttributedString.Key.strikethroughStyle: 1, NSAttributedString.Key.foregroundColor: UIColor.lightGray], range: fooRange)
        } else {
            foo.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], range: fooRange)
        }
        
        taskTitleLabel.attributedText = foo
        textDescriptionLabel.attributedText = NSMutableAttributedString(string: task.description ?? "",
                                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        isCompletedButton.layer.cornerRadius = Constants.cornerRadius
        isCompletedButton.backgroundColor = task.isCompleted ? .red : .clear
    }
    
    func hideSeparator() {
        separatorView.isHidden = true
    }
    
    func showSeparetor() {
        separatorView.isHidden = false
    }
    
    @IBAction func didTouchStatusButton(_ sender: UIButton) {
        if let task {
            delegate?.didTouchStatusButton(id: task.id)
        }
    }
    
    @IBAction func didSelectCell(_ sender: UIGestureRecognizer) {
        if let task {
            delegate?.didSelectCell(id: task.id)
        }
    }
    
    static func getNib() -> UINib {
        let identifier = String(describing: TaskTableViewCell.self)
        return UINib(nibName: identifier, bundle: nil)
    }
}
