//
//  OnBoardingCell.swift
//  Bank App
//
//  Created by Egor on 29.03.2026.
//

import UIKit
import Lottie

protocol OnBoardingCellDelegate: AnyObject {
    func buttonDidTap()
}

final class OnBoardingCell: UICollectionViewCell {
    
    // MARK: – Properties
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    weak var delegate: OnBoardingCellDelegate?

    // MARK: – Subviews
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let animationView: LottieAnimationView = {
        let lottieView = LottieAnimationView()
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        return lottieView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical) // приоритет на сопротивление сжатию
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = .init(width: 2, height: 2)
        return button
    }()
    
    // MARK: – INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        
    }
    
    private func setupSubviews() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            animationView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 400),
            
            label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40),
            
            button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -60),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configure(with model: CellModel) {
        titleLabel.text = model.mainTitle
        label.text = model.title
        button.setTitle(model.buttonTitle, for: .normal)
        button.backgroundColor = model.buttonColor
        
        let animation = LottieAnimation.named(model.animationName)
        animationView.animation = animation
        
        animationView.play()
    }
    
    // MARK: – Actions
    @objc private func buttonTapped() {
        delegate?.buttonDidTap()
    }
    
}
