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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reloadInputViews()
    }
    
    func configure(with task: Task) {
        taskTitleLabel.text = task.title
        if let description = task.description {
            textDescriptionLabel.text = description
        } else {
            textDescriptionLabel.isHidden = true
        }
        updateTaskStatus(isCompleted: task.isCompleted)
    }
    
    func updateTaskStatus(isCompleted: Bool) {
        isCompletedButton.layer.cornerRadius = Constants.cornerRadius
        isCompletedButton.backgroundColor = isCompleted ? .red : .clear
        
        if isCompleted {
            let myAttribute = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            let myAttrString = NSAttributedString(string: taskTitleLabel.text!, attributes: myAttribute)
            
            taskTitleLabel.attributedText = myAttrString
            taskTitleLabel.textColor = .lightGray
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
