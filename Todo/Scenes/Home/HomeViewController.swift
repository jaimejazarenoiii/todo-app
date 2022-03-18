//
//  HomeViewController.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import ReSwift
import RxCocoa
import RxSwift
import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapAddButton(source: HomeViewController)
    func didTapEditButton(source: HomeViewController, selectedTask: TodoTask)
    func didTapSignout(source: WelcomeHeaderView)
}

class HomeViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = TodoTaskState

    lazy var tableView: UITableView = UITableView()
    lazy var emptyNoteLabel: UILabel = UILabel()
    lazy var welcomeHeaderView: WelcomeHeaderView = WelcomeHeaderView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))

    private var items: BehaviorRelay<[TodoTask]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    weak var delegate: HomeViewControllerDelegate?

    override func loadView() {
        super.loadView()
        setupScene()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItems = [addBarButton]
        store.subscribe(self) { $0.select({ $0.todoTaskState }) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBindings()
    }

    private func setupBindings() {
        store.dispatch(TodoTaskAction.getCurrentUser)
        store.dispatch(TodoTaskAction.getList)
        items.asObservable().bind(to: tableView.rx.items) { (tableView, index, item) -> UITableViewCell in
            let cell: TodoTaskTableViewCell = tableView
                .dequeueReusableCell(withIdentifier: "TodoTaskTableViewCell") as! TodoTaskTableViewCell
            cell.set(task: item)
            cell.delegate = self
            return cell
        }.disposed(by: disposeBag)

        items.map { !$0.isEmpty }.bind(to: emptyNoteLabel.rx.isHidden).disposed(by: disposeBag)
    }

    func newState(state: TodoTaskState) {
        items.accept(state.tasks.sorted(by: { $0.id > $1.id }))
        guard let currentUser = state.currentUser else { return }
        welcomeHeaderView.setup(user: currentUser, tasks: state.tasks)
    }

    @objc
    private func addTask() {
        delegate?.didTapAddButton(source: self)
    }
}

extension HomeViewController: WelcomeHeaderViewDelegate {
    func didTapSignout(source: WelcomeHeaderView) {
        delegate?.didTapSignout(source: source)
    }
}

extension HomeViewController: TodoTaskTableViewCellDelegate {
    func didTapEdit(source: TodoTaskTableViewCell, task: TodoTask) {
        delegate?.didTapEditButton(source: self, selectedTask: task)
    }

    func didTapDelete(source: TodoTaskTableViewCell, task: TodoTask) {
        store.dispatch(TodoTaskAction.delete(task: task))
    }
}
