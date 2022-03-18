//
//  WelcomeHeaderView.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit
import RxCocoa
import RxSwift

protocol WelcomeHeaderViewDelegate: AnyObject {
    func didTapSignout(source: WelcomeHeaderView)
}

class WelcomeHeaderView: UIView {
    lazy private var titleLabel: UILabel = UILabel()
    lazy private var pendingTasksLabel: UILabel = UILabel()
    lazy private var avatarButton: UIButton = UIButton()
    private let disposeBag = DisposeBag()
    weak var delegate: WelcomeHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup(user: User, tasks: [TodoTask]) {
        titleLabel.text = "Hi \(user.name)"
        let pendingTasks = tasks.filter { $0.status == .active }
        let pendingText = pendingTasks.isEmpty ? "No pending task" : "\(pendingTasks.count) todos"
        pendingTasksLabel.text = pendingText
    }

    private func setupView() {
        setupAvatarImageView()
        setupTitleLabel()
        setupPendingTasksLabel()
        downloadImage(from: URL(string: "https://media.wired.co.uk/photos/607d91994d40fbb952b6ad64/master/w_1600,c_limit/wired-meme-nft-brian.jpg")!)
    }

    private func setupAvatarImageView() {
        let destruct = UIAction(title: "Sign out", attributes: .destructive) { [unowned self] _ in
            self.delegate?.didTapSignout(source: self)
        }

        avatarButton.menu = UIMenu(title: "", children: [destruct])
        avatarButton.showsMenuAsPrimaryAction = true
        avatarButton.layer.cornerRadius = 20
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.clipsToBounds = true

        addSubview(avatarButton)

        avatarButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }

    private func setupTitleLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 30)

        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.lessThanOrEqualTo(avatarButton.snp.left).priority(.medium)
        }
    }

    private func setupPendingTasksLabel() {
        pendingTasksLabel.font = .systemFont(ofSize: 24)
        pendingTasksLabel.textColor = .orange

        addSubview(pendingTasksLabel)

        pendingTasksLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    private func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.avatarButton.setImage(UIImage(data: data), for: .normal)
            }
        }
    }
}
