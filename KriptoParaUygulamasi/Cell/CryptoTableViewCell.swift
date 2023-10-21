//
//  CryptoTableViewCell.swift
//  KriptoParaUygulamasi
//
//  Created by Emincan Antalyalı on 21.10.2023.
//

import UIKit

final class CryptoTableViewCell: UITableViewCell {

    static let identifier = "CryptoTableViewCell"

    var upOrDownArr = [UIImage(systemName: "arrow.up")!,UIImage(systemName: "arrow.down")!]

    var currency: Crypto? {
        didSet {
            self.currencyName.text = currency?.currency
            self.currencyprice.text = currency?.price
            self.gainImageView.image = upOrDownArr.randomElement()
        }
    }
    private let currencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()
    private let currencyprice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()
   private let gainImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = .checkmark
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .cyan
        return iv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        currency = nil
    }

    private func setup() {
        contentView.addSubview(currencyName)
        contentView.addSubview(currencyprice)
        contentView.addSubview(gainImageView)

        NSLayoutConstraint.activate([
            currencyName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            currencyName.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: currencyName.bottomAnchor),
            currencyName.widthAnchor.constraint(equalToConstant: self.frame.width / 2.5),
        ])

        NSLayoutConstraint.activate([
            currencyprice.leadingAnchor.constraint(equalTo: currencyName.trailingAnchor),
            currencyprice.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currencyName.widthAnchor.constraint(equalToConstant: self.frame.width / 2.5),
            contentView.bottomAnchor.constraint(equalTo: currencyName.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            gainImageView.leadingAnchor.constraint(equalTo: currencyprice.trailingAnchor,constant: 16),
            gainImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            bottomAnchor.constraint(equalTo: gainImageView.bottomAnchor,constant: 16),
            contentView.trailingAnchor.constraint(equalTo: gainImageView.trailingAnchor,constant: 8),
           gainImageView.widthAnchor.constraint(equalToConstant: self.frame.width / 4),
        ])
    }

}
