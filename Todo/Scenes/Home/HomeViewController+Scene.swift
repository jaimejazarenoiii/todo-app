//
//  HomeViewController+Scene.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit

extension HomeViewController {
    func setupScene() {
        setupTableView()
        setupEmptyNoteLabel()
    }

    private func setupTableView() {
        tableView.register(TodoTaskTableViewCell.self, forCellReuseIdentifier: "TodoTaskTableViewCell")
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        welcomeHeaderView.delegate = self
        tableView.tableHeaderView = welcomeHeaderView

        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupEmptyNoteLabel() {
        emptyNoteLabel.text = "No task yet. Start your journey by tapping the plus icon at the top right of this page."
        emptyNoteLabel.textAlignment = .center
        emptyNoteLabel.numberOfLines = 0
        emptyNoteLabel.font = .systemFont(ofSize: 24)
        emptyNoteLabel.isHidden = true

        view.addSubview(emptyNoteLabel)

        emptyNoteLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
            make.height.greaterThanOrEqualTo(30)
        }
    }
}
