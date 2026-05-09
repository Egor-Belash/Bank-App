//
//  SettingsViewController.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//
import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: – Properties
    
    // MARK: – Subviews
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        return label
    }()
    
    private let nightModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Theme:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let nightModeSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["System", "Light", "Dark"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private let notificationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Disable notifications:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let notificationSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.isOn = false
        return switcher
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 22
        button.backgroundColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        setupNavigationBar()
        loadThemeValue()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        nightModeSegment.addTarget(self, action: #selector(nightModeSegmentChanged), for: .valueChanged)
        notificationSwitch.addTarget(self, action: #selector(notificationSwitchTapped), for: .valueChanged)
        
        view.addSubview(label)
        view.addSubview(nightModeLabel)
        view.addSubview(nightModeSegment)
        view.addSubview(notificationsLabel)
        view.addSubview(notificationSwitch)
        view.addSubview(logOutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nightModeLabel.centerYAnchor.constraint(equalTo: nightModeSegment.centerYAnchor),
            nightModeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nightModeLabel.trailingAnchor.constraint(equalTo: nightModeSegment.leadingAnchor, constant: -20),
            
            nightModeSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nightModeSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nightModeSegment.heightAnchor.constraint(equalToConstant: 34),
            nightModeSegment.widthAnchor.constraint(equalToConstant: 200),
            
            notificationsLabel.centerYAnchor.constraint(equalTo: notificationSwitch.centerYAnchor),
            notificationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notificationsLabel.trailingAnchor.constraint(equalTo: notificationSwitch.leadingAnchor, constant: -20),
            
            notificationSwitch.topAnchor.constraint(equalTo: nightModeSegment.bottomAnchor, constant: 30),
            notificationSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logOutButton.heightAnchor.constraint(equalToConstant: 44),
            logOutButton.widthAnchor.constraint(equalToConstant: 130),
            
        ])
    }
    
    private func setupNavigationBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: – Actions
    @objc private func logOutButtonTapped() {
        showWarningAlertBeforeExit(title: "Attention", message: "You are going to log out.\nAre you sure?")
    }
    
    @objc private func nightModeSegmentChanged(_ segment: UISegmentedControl) {
        let selectedTheme = AppTheme(rawValue: segment.selectedSegmentIndex) ?? .system
        
        UserDefaults.standard.set(selectedTheme.rawValue, forKey: "theme")
        
        ThemeManager.applyTheme(selectedTheme)
    }
    
    private func loadThemeValue() {
        let themeValue = UserDefaults.standard.integer(forKey: "theme")
        let theme = AppTheme(rawValue: themeValue) ?? .system
        
        nightModeSegment.selectedSegmentIndex = theme.rawValue
    }
    
    @objc private func notificationSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            NotificationService.shared.requestPermission { granted in
                if granted {
                    self.notificationsLabel.text = "Disable notifications"
                    UserDefaults.standard.set(true, forKey: "notifications")
                    NotificationService.shared.scheduleNotification()
                } else {
                    self.notificationsLabel.text = "Enable notifications"
                    sender.setOn(false, animated: true)
                    UserDefaults.standard.set(false, forKey: "notifications")
                    
                    self.showAlertToOpenSettings()
                }
            }
        } else {
            notificationsLabel.text = "Enable notifications"
            UserDefaults.standard.set(false, forKey: "notifications")
            NotificationService.shared.cancelNotifications()
        }
            
    }
    
    @objc private func appWillEnterForeground() {
        loadNotificationsValue()
    }
    
    // Проверка состояния разрешения уведомлений
    private func loadNotificationsValue() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("⚠️ Нет разрешения")
                DispatchQueue.main.async {
                    self.notificationSwitch.isOn = false
                    self.notificationsLabel.text = "Enable notifications"
                    UserDefaults.standard.set(false, forKey: "notifications")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.notificationSwitch.isOn = true
                self.notificationsLabel.text = "Disable notifications"
                UserDefaults.standard.set(true, forKey: "notifications")
            }
        }
    }
    
    private func showAlertToOpenSettings() {
        let alert = UIAlertController(
            title: "Уведомления отключены",
            message: "Разрешите уведомления в настройках устройства",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        present(alert, animated: true)

    }
    
    private func showWarningAlertBeforeExit(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { [weak self] _ in
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = scene.windows.first else
            { return }
            
            window.rootViewController = LogInViewController()
            
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionFlipFromBottom,
                animations: nil,
                completion: nil
            )
        }
        
        alert.addAction(cancelAction)
        alert.addAction(logOutAction)
        
        present(alert, animated: true)
    }
    
}

