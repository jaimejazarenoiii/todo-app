//
//  TaskFormViewController.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation
import UIKit
import ReSwift

protocol TaskFormViewControllerDelegate: AnyObject {
    func successfullySaved(source: TaskFormViewController)
}

class TaskFormViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = TodoTaskState

    lazy var titleTextField: UITextField = UITextField()
    lazy var descriptionTextField: UITextField = UITextField()
    var action: MutateAction = .add
    var selectedTask: TodoTask?
    weak var delegate: TaskFormViewControllerDelegate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    convenience init(action: MutateAction, selectedTask: TodoTask?) {
        self.init(nibName: nil, bundle: nil)
        self.action = action
        self.selectedTask = selectedTask
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        super.loadView()
        setupScene()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneFillUp))
        navigationItem.rightBarButtonItems = [addBarButton]
        title = action == .edit ? "Edit task" : "Add task"
        store.subscribe(self) { $0.select({ $0.todoTaskState }) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    func newState(state: TodoTaskState) {
        if state.formState == .done {
            store.dispatch(TodoTaskAction.set(formState: .none))
            delegate?.successfullySaved(source: self)
        }
    }

    @objc
    private func doneFillUp() {
        action == .edit ? editTask() : addTask()
    }

    private func addTask() {
        guard let title = titleTextField.text, title.count > 3 else { return showValidationError() }
        store.dispatch(TodoTaskAction.add(task: TodoTask(title: title, description: descriptionTextField.text ?? "")))
    }

    private func editTask() {
        guard let title = titleTextField.text, title.count > 3,
            var selectedTask = selectedTask else { return showValidationError() }
        selectedTask.title = title
        selectedTask.description = descriptionTextField.text ?? ""
        store.dispatch(TodoTaskAction.edit(task: selectedTask))
    }

    private func showValidationError() {
        let alert = UIAlertController(title: "Error",
                                      message: "Title should be at least 4 characters.",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
