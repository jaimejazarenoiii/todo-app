//
//  TodoTaskTableViewCell.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit
import RxSwift

protocol TodoTaskTableViewCellDelegate: AnyObject {
    func didTapEdit(source: TodoTaskTableViewCell, task: TodoTask)
    func didTapDelete(source: TodoTaskTableViewCell, task: TodoTask)
}

class TodoTaskTableViewCell: UITableViewCell {
    lazy private var containerView: UIView = UIView()
    lazy private var titleLabel: UILabel = UILabel()
    lazy private var descriptionLabel: UILabel = UILabel()
    lazy private var editButton: UIButton = UIButton()
    lazy private var deleteButton: UIButton = UIButton()

    let underlinedAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 11),
        .foregroundColor: UIColor.gray,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    private let disposeBag = DisposeBag()
    private var todoTask: TodoTask?
    weak var delegate: TodoTaskTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBindings() {
        editButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [unowned self] _ in
                guard let task = self.todoTask else { return }
                self.delegate?.didTapEdit(source: self, task: task)
            }.disposed(by: disposeBag)
        deleteButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [unowned self] _ in
                guard let task = self.todoTask else { return }
                self.delegate?.didTapDelete(source: self, task: task)
            }.disposed(by: disposeBag)
    }

    func set(task: TodoTask) {
        todoTask = task
        titleLabel.text = task.title
        descriptionLabel.text = task.description
    }

    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        setupContainerView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupEditButton()
        setupDeleteButton()
    }

    private func setupContainerView() {
        containerView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .white : .offWhite
        containerView.layer.cornerRadius = 20.0
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 12.0
        containerView.layer.shadowOpacity = 0.3

        contentView.addSubview(containerView)

        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(30)
        }
    }

    private func setupTitleLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black

        containerView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(30)
            make.height.greaterThanOrEqualTo(20)
        }
    }

    private func setupDescriptionLabel() {
        descriptionLabel.font = .boldSystemFont(ofSize: 14)
        descriptionLabel.textColor = .black

        containerView.addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(20)
            make.left.right.equalTo(titleLabel)
        }
    }

    private func setupEditButton() {
        let attributeString = NSMutableAttributedString(
            string: "Edit",
            attributes: underlinedAttributes
        )
        editButton.setAttributedTitle(attributeString, for: .normal)
        editButton.contentHorizontalAlignment = .left

        containerView.addSubview(editButton)

        editButton.snp.makeConstraints { make in
            make.left.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().inset(30)
        }
    }

    private func setupDeleteButton() {
        let attributeString = NSMutableAttributedString(
            string: "Delete",
            attributes: underlinedAttributes
        )
        deleteButton.contentHorizontalAlignment = .left
        deleteButton.setAttributedTitle(attributeString, for: .normal)

        containerView.addSubview(deleteButton)

        deleteButton.snp.makeConstraints { make in
            make.left.equalTo(editButton.snp.right).offset(5)
            make.top.width.bottom.equalTo(editButton)
        }
    }
}


