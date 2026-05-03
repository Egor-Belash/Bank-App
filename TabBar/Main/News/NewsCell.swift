//
//  NewsCell.swift
//  Bank App
//
//  Created by Egor on 01.05.2026.
//

import UIKit
import Kingfisher

final class NewsCell: UITableViewCell {
    
    // MARK: – Properties
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: – Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.textColor = .black
        return label
    }()
    
    // MARK: – INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        image.image = nil
        dateLabel.text = nil
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        addSubview(image)
        addSubview(titleLabel)
        addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
    
    // MARK: – Actions
    func configure(with model: NewsModel) {
        titleLabel.text = model.nameRu
        
        // форматирование даты
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: model.startDate) {
            formatter.dateFormat = "dd.MM.yyyy"
            dateLabel.text = formatter.string(from: date)
        }
        
        // отображение url фото с помощью Kingfisher
        guard let url = URL(string: model.img) else { return }
        
        image.kf.setImage(with: url)
        
    }
    
}
