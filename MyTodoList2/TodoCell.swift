//
//  TodoCell.swift
//  MyTodoList2
//
//  Created by 최유리 on 1/11/24.
//

import UIKit

class TodoCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: TodoCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
    var todo: Todo?
    
    @IBAction func didValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            titleLabel.textColor = .gray
        } else {
            titleLabel.textColor = .black
        }
    }
    
    func configure(with todo: Todo) {
        self.todo = todo
        titleLabel.text = todo.description
        isDoneSwitch.isOn = todo.isDone
    }
}
