//
//  StoreDetailInfoCell.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/26.
//

import UIKit
import SnapKit

final class StoreDetailInfoTableViewCell: UITableViewCell {

    // MARK: - UI Properties

    private let couponeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray6
        label.text = "9개만 더 모으면 쿠폰으로 사용 가능해요 ❗️"
        label.font = .boldSystemFont(ofSize: 16)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }()
    private let storeBenefitsLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .gray
        lable.text = "매장혜택"
        return lable
    }()
    private let storeBenefitsValueLabel: UILabel = {
        let lable = UILabel()
        lable.text = "🅟 20개 적립 시 할인 쿠폰 제공"
        return lable
    }()
    private lazy var storeBenefitsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [storeBenefitsLabel, storeBenefitsValueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private let businessHoursLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .gray
        lable.text = "영업시간"
        return lable
    }()
    private let businessHoursValueLabel: UILabel = {
        let lable = UILabel()
        lable.text = "월 화 수 목 금 08:00~20:00"
        return lable
    }()
    private lazy var businessHoursStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [businessHoursLabel, businessHoursValueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private let holidayLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .gray
        lable.text = "휴무일"
        return lable
    }()
    private let holidayValueLabel: UILabel = {
        let lable = UILabel()
        lable.text = "매주 일요일"
        return lable
    }()
    private lazy var holidayStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [holidayLabel, holidayValueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private let telNumberLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .gray
        lable.text = "전화번호"
        return lable
    }()
    private let telNumberValueLabel: UILabel = {
        let lable = UILabel()
        lable.text = "0320000000"
        return lable
    }()
    private lazy var telNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [telNumberLabel, telNumberValueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private let addressLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .gray
        lable.text = "주소"
        return lable
    }()
    private let addressValueLabel: UILabel = {
        let lable = UILabel()
        lable.text = "경기도 부천시 서울 특별시 경기도 하남시 경기도 동두천시"
        lable.numberOfLines = 0
        return lable
    }()
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressLabel, addressValueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.distribution = .fill
        return stackView
    }()
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                storeBenefitsStackView,
                businessHoursStackView,
                holidayStackView,
                telNumberStackView,
                addressStackView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    private let storeMapView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setLayout

    private func setLayout() {
        addSubview(couponeLabel)
        addSubview(infoStackView)
        addSubview(seperatorView)
        addSubview(storeMapView)

        couponeLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        storeBenefitsLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        businessHoursLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        holidayLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        telNumberLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        addressLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(couponeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        storeMapView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalToSuperview()
        }
    }
}
