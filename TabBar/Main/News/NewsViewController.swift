//
//  NewsViewController.swift
//  Bank App
//
//  Created by Egor on 01.05.2026.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: – Properties
    private var news: [NewsModel] = []
    var presenter: NewsPresenterProtocol?

    // MARK: – Subviews
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = String(localized: .news)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .secondarySystemBackground
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 25
        button.isHidden = true
        return button
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
        activityIndicator.startAnimating()
        presenter?.viewDidLoad()
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        
        view.addSubview(mainTitleLabel)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(label)
        view.addSubview(reloadButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            mainTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            reloadButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 100),
            reloadButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: – Actions
    private func showReloadButton() {
        label.isHidden = false
        reloadButton.isHidden = false
    }
    
    @objc private func reloadButtonTapped() {
        presenter?.reloadTapped()
    }
    
}

// MARK: – UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: news[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: – UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.didSelectNews(news[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: – NewsViewProtocol
extension NewsViewController: NewsViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
        label.isHidden = true
        reloadButton.isHidden = true
    }
    
    func showNews(_ news: [NewsModel]) {
        self.news = news
        activityIndicator.stopAnimating()
        label.isHidden = false
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        activityIndicator.stopAnimating()
        label.text = message
        showReloadButton()
    }
    
}
