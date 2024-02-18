//
//  TextInputTableViewCell.swift
//  SeSAC_Day33_Assignment
//
//  Created by 쩡화니 on 2/18/24.
//

import UIKit

final class TextInputTableViewCell: BaseTableViewCell {
    
    // MARK: Initializing a Cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(editableTextField)
        NSLayoutConstraint.activate([
            editableTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editableTextField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            editableTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Reusing Cells
    
    override func prepareForReuse() {
        super.prepareForReuse()
        changeHandler = { _ in }
    }
    
    // MARK: Managing the Content

    func configure(for model: TextInputFormItem) {
        editableTextField.text = model.text
        editableTextField.placeholder = model.placeholder
        changeHandler = model.didChange
    }
    
    lazy private var editableTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(TextInputTableViewCell.textDidChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: Handling Text Input
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        editableTextField.becomeFirstResponder()
    }
    
    private var changeHandler: (String) -> () = { _ in }
    
    @objc private func textDidChange() {
        changeHandler(editableTextField.text ?? "")
    }
}
