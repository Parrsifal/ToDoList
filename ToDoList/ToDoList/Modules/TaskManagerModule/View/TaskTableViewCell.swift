//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var isCompletedButton: UIButton!
    @IBOutlet private weak var taskTitleLabel: UILabel!
    @IBOutlet private weak var textDescriptionLabel: UILabel!
    static let identifier = "TaskCell"
    
    func configure(with task: Task) {
        taskTitleLabel.text = task.title
        if let description = task.description {
            textDescriptionLabel.text = description
            textDescriptionLabel.isHidden = false
        } else {
            textDescriptionLabel.isHidden = true
        }
        updateTaskStatus(task: task)
    }
    
    func updateTaskStatus(task: Task) {
        isCompletedButton.layer.cornerRadius = Constants.cornerRadius
        isCompletedButton.backgroundColor = task.isCompleted ? .red : .clear
        
        if task.isCompleted {
            let myAttribute = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            let myAttrString = NSAttributedString(string: taskTitleLabel.text!, attributes: myAttribute)
            
            taskTitleLabel.attributedText = myAttrString
            taskTitleLabel.textColor = .lightGray
        } else {
            taskTitleLabel.attributedText = .none
            taskTitleLabel.text = task.title
        }
    }
    
    func hideSeparator() {
        separatorView.isHidden = true
    }
    
    func showSeparetor() {
        separatorView.isHidden = false
    }
    
    static func getNib() -> UINib {
        let identifier = String(describing: TaskTableViewCell.self)
        return UINib(nibName: identifier, bundle: nil)
    }
}
