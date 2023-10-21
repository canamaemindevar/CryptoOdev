//
//  ViewController.swift
//  KriptoParaUygulamasi
//
//  Created by Atil Samancioglu on 21.10.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    var cryptoList = [Crypto]()
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemGray
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.layer.cornerRadius = 0

        return tableView
    }()

    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = false
        loader.color = .red
        return loader
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension ViewController {

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(loader)
        self.tableView.frame = view.bounds
        setupBindings()
        cryptoVM.requestData()
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.heightAnchor.constraint(equalToConstant: view.frame.height / 10),
            loader.widthAnchor.constraint(equalToConstant: view.frame.width / 5)
        ])
    }

    func setupBindings() {
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }.disposed(by: disposeBag)

        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }.disposed(by: disposeBag)

        cryptoVM
            .loading
            .bind(to: self.loader.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()}

        cell.currency = cryptoList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.frame.height / 10
    }
}
