//
//  OrderHistoryViewController.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/13.
//

import UIKit
import SnapKit

final class OrderHistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private var selectedYear = ""
    private var selectedMonth = ""

    // MARK: - UI Properties

    private let orderHistoryTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        return tableView
    }()
    private let emptyCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyOrderHistory")
        imageView.isHidden = true
        return imageView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setOrderHistoryTableView()
        setLayout()
        setCurrentYearMont()
        setButtonTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - setLayout

    private func setLayout() {
        orderHistoryTableView.backgroundColor = .white
        
        view.addSubview(orderHistoryTableView)
        orderHistoryTableView.addSubview(emptyCellImageView)
        
        orderHistoryTableView.snp.makeConstraints({ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        })
        emptyCellImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }
    }

    // MARK: - setOrderHistoryTableView

    private func setOrderHistoryTableView() {
        orderHistoryTableView.dataSource = self
        orderHistoryTableView.delegate = self
        orderHistoryTableView.register(
            OrderHistoryTableViewCell.self,
            forCellReuseIdentifier: "cellID"
        )
        orderHistoryTableView.register(
            OrderHistoryTableViewHeaderView.self,
            forHeaderFooterViewReuseIdentifier: "header"
        )
    }

    // MARK: - setNavigation

    private func setNavigation() {
        navigationController?.isNavigationBarHidden = true
        title = "주문내역"
        let orderDateSelectButton = UIBarButtonItem()
        orderDateSelectButton.title = "2022년 05월 >"
        orderDateSelectButton.tintColor = .black
        navigationItem.leftBarButtonItem = orderDateSelectButton
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(orderDateSelectButtonTapped)
    }

    // MARK: - Inherited Method

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let orderHistoryTableViewHeaderHeight = orderHistoryTableView
            .headerView(forSection: 0)?
            .frame.height ?? 0
        if scrollView.contentOffset.y > orderHistoryTableViewHeaderHeight {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    // MARK: - Methods

    private func setCurrentYearMont() {
        let today = Date()
        
        let formatterYear = DateFormatter()
        formatterYear.dateFormat = "yyyy"
        selectedYear = formatterYear.string(from: today)

        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MM"
        selectedMonth = formatterMonth.string(from: today)
    }
    @objc private func orderDateSelectButtonTapped() {
        let alert = UIAlertController(
            title: "나의 주문 내역",
            message: nil,
            preferredStyle: .actionSheet
        )
        let selectMonthViewController = SelectOrderDatePickerViewController()
        alert.setValue(selectMonthViewController, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.selectedYear = String(selectMonthViewController.selectedYear)
            self.selectedMonth = String(selectMonthViewController.selectedMonth)
            self.setButtonTitle()
            self.fetchOrderHistory()
        }))
        
        present(alert, animated: true)
    }
    private func setButtonTitle() {
        navigationItem.leftBarButtonItem?.title = "\(selectedYear)년 \(selectedMonth)월 >"
    }
    private func fetchOrderHistory() {
        orderHistoryTableView.reloadData()
    }
    @objc private func reorderButtonTapped() {
        let nextViewController = UINavigationController(rootViewController: ReorderViewController())
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
    @objc private func writeStoryButtonTapped() {
        let nextViewController = WriteStoryViewController()
        nextViewController.navigationController?.setToolbarHidden(false, animated: true)
        nextViewController.navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension OrderHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = 5
        if number == 0 {
            emptyCellImageView.isHidden = false
        }
        return number
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let dequecell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        guard let cell = dequecell as? OrderHistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.reorderButton.addTarget(
            self,
            action: #selector(reorderButtonTapped),
            for: .touchUpInside
        )
        cell.writeStoryButton.addTarget(self,
                                        action: #selector(writeStoryButtonTapped),
                                        for: .touchUpInside
        )
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dequeheader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        guard let header = dequeheader as? OrderHistoryTableViewHeaderView else {
            return UIView()
        }
        header.orderDateSelectButton.setTitle(
            "\(selectedYear)년 \(selectedMonth)월 >",
            for: .normal
        )
        header.orderDateSelectButton.addTarget(
            self,
            action: #selector(orderDateSelectButtonTapped),
            for: .touchUpInside
        )
        return header
    }
}
