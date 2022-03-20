//
//  TaskFormViewController+Scene.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit

extension TaskFormViewController {
    func setupScene() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        setupTitleTextField()
        setupDescriptionTextField()
    }

    private func setupTitleTextField() {
        titleTextField.text = action == .edit ? selectedTask?.title : ""
        titleTextField.placeholder = "Enter title"
        titleTextField.font = .systemFont(ofSize: 24)

        view.addSubview(titleTextField)

        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.left.right.equalToSuperview().inset(40)
        }
    }

    private func setupDescriptionTextField() {
        descriptionTextField.text = action == .edit ? selectedTask?.description : ""
        descriptionTextField.placeholder = "Enter description"
        descriptionTextField.font = .systemFont(ofSize: 24)

        view.addSubview(descriptionTextField)

        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.left.right.equalTo(titleTextField)
        }
    }
}
