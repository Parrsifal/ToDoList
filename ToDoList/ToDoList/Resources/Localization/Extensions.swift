//
//  Extensions.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 21.05.2023.
//

import Foundation

extension String{
    static func localized(text: String) -> String {
        return NSLocalizedString(text, comment: "")
    }
}
