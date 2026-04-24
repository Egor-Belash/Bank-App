//
//  ViewController.swift
//  Bank App
//
//  Created by Egor on 29.03.2026.
//

import UIKit
import Lottie

final class OnBoardingViewController: UIViewController {
    
    // MARK: – Properties
    private let slides = [
        CellModel(
            mainTitle: "Добро пожаловать в Bank App!",
            animationName: "OnlinePayment",
            title: "Лучший банк в вашей жизни",
            buttonTitle: "Далее",
            buttonColor: UIColor(named: "yellowColor2")!
        ),
        CellModel(
            mainTitle: "Скорость – это про нас!",
            animationName: "MoneyMoneyMoney",
            title: "Принимаем деньги быстрее, чем выдаём",
            buttonTitle: "Супер!",
            buttonColor: UIColor(named: "lightBlueColor2")!
        ),
        CellModel(
            mainTitle: "Ваши деньги под надёжной защитой!",
            animationName: "MoneyPhoneServers",
            title: "Мошенники не смогут украсть ваши деньги, если это сделаем мы",
            buttonTitle: "ОГО!",
            buttonColor: UIColor(named: "blueColor2")!
        ),
        CellModel(
            mainTitle: "Начните прямо сейчас!",
            animationName: "OnlineMoneyTransfer",
            title: "Больше денег у вас – меньше денег у вас",
            buttonTitle: "Начать",
            buttonColor: UIColor(named: "yellowColor2")!
        ),

    ]
    
    // MARK: – Subviews
    private let layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(named: "yellowColor2")
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    deinit {
        print("OndoardingVC is deinit")
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseIdentifier)
        
        collectionView.contentInsetAdjustmentBehavior = .never          // убрать status bar сверху
        collectionView.isPagingEnabled = true                           // чтобы доскроливал
        
        setupPageControl()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
    }
    
}

// MARK: – UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseIdentifier, for: indexPath) as? OnBoardingCell else { return UICollectionViewCell() }

        cell.configure(with: slides[indexPath.item])
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: – UICollectionViewDelegate
extension OnBoardingViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {         // чтобы при скроле точки загорались
        let currentIndex = Int(scrollView.contentOffset.y / scrollView.frame.height)
        pageControl.currentPage = currentIndex
    }
}

// MARK: – UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: – OnBoardingCellDelegate
extension OnBoardingViewController: OnBoardingCellDelegate {
    func buttonDidTap() {
        let currentIndex = Int(collectionView.contentOffset.y / collectionView.frame.height) // нашли текущий индекс
        let nextIndex = currentIndex + 1
        
        if nextIndex < slides.count {   // для первых экранов
            collectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .top, animated: true)
            pageControl.currentPage = nextIndex         // обновляем чтобы по нажатию на кнопку тоже работал
        } else {                        // для последнего экрана
            goToLogInScreen()
        }
    }
    
    private func goToLogInScreen() {
        // Showing onboarding once
        UserDefaults.standard.set(true, forKey: "onboardingIsDone")
        
        // Go to the LogInVC
        let vc = LogInViewController()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window
        else { return }
    
        window.rootViewController = vc
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
    
}
