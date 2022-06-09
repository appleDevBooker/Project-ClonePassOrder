//
//  StoreDetailTableViewController.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/26.
//

import UIKit
import SnapKit

class StoreDetailViewController: UIViewController {
    enum SelectedView {
        case infoView
        case storyView
    }

    // MARK: - Properties
    
    var viewModel: CafeListViewModelItem
    var currentSelectedView: SelectedView = .infoView

    // MARK: - UI Properties

    private let storeDetailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    private let floatingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let floatingButton: UIButton = {
        let button = UIButton()
        button.setTitle("가져 갈게요\n메뉴 보기", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4730066061, blue: 0.2864735723, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - viewLifeCycle
    
    init(viewModel: CafeListViewModelItem) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
        setNavi()
    }

    // MARK: - setLayout

    private func setLayout() {
        view.addSubview(storeDetailTableView)
        view.addSubview(floatingView)
        view.bringSubviewToFront(floatingView)
        floatingView.addSubview(floatingButton)
        
        storeDetailTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        floatingView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        floatingButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - setNavi
    
    func setNavi() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - setTableView

    private func setTableView() {
        storeDetailTableView.delegate = self
        storeDetailTableView.dataSource = self
        storeDetailTableView.register(StoreDetailTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        storeDetailTableView.register(StoreDetailInfoTableViewCell.self, forCellReuseIdentifier: "infocell")
        storeDetailTableView.register(StoryTableViewCell.self, forCellReuseIdentifier: "storycell")
    }

    // MARK: - Methods

    func reloadstoreDetailTableView() {
        storeDetailTableView.reloadData()
    }
    @objc func informationButtonTapped() {
        switch currentSelectedView {
            case .infoView:
                return
            case .storyView:
                currentSelectedView = .infoView
                reloadstoreDetailTableView()
        }
    }
    @objc func storyButtonTapped() {
        switch currentSelectedView {
            case .infoView:
                currentSelectedView = .storyView
                reloadstoreDetailTableView()
            case .storyView:
                return
        }
    }
    @objc func moreButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "신고", style: .default))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
    @objc func commentsButtonTapped() {
        let nextViewController = UINavigationController(rootViewController: StoryCommentViewController())
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension StoreDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentSelectedView {
            case .infoView:
                return 1
            case .storyView:
                return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentSelectedView {
            case .infoView:
                let dequedCell = tableView.dequeueReusableCell(withIdentifier: "infocell")
                guard let cell = dequedCell as? StoreDetailInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.viewModel = viewModel
                return cell
            case .storyView:
                let dequedCell = tableView.dequeueReusableCell(withIdentifier: "storycell")
                guard let cell = dequedCell as? StoryTableViewCell else {
                    return UITableViewCell()
                }
                cell.commentsButton.addTarget(self, action: #selector(commentsButtonTapped), for: .touchUpInside)
                cell.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
                cell.selectionStyle = .none
                return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dequedHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        guard let headerView = dequedHeaderView as? StoreDetailTableViewHeaderView else {
            return UIView()
        }
        headerView.viewModel = viewModel
        headerView.informationButton.addTarget(self, action: #selector(informationButtonTapped), for: .touchUpInside)
        headerView.storyButton.addTarget(self, action: #selector(storyButtonTapped), for: .touchUpInside)
        return headerView
    }
}
