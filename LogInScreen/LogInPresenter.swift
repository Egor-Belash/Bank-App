import Foundation

final class LogInPresenter: LogInPresenterProtocol {

    weak var view: LogInViewProtocol?
    var router: LogInRouterProtocol?

    func loginButtonTapped(_ login: String, _ password: String) {
        guard !login.isEmpty, !password.isEmpty else {
            view?.showError(title: "Ошибка", message: "Введите логин и пароль")
            return
        }
        
        guard let savedLogin = UserDefaults.standard.string(forKey: "login") else {
            view?.showError(title: "Ошибка", message: "Пользователь не зарегистрирован")
            return
        }
        
        guard let savedPassword = KeychainService.shared.loadPasswordFromKeychain(login: savedLogin) else {
            view?.showError(title: "Ошибка", message: "Пароль не найден")
            return
        }
        
        if login == savedLogin && password == savedPassword {
            // If user us LoggedIn, he will be loggedIn directly to the MainTabBarViewController
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
            // Go to the MainTabBarViewController
            router?.goToMainTabBarScreen()
        } else {
            view?.showError(title: "Ошибка", message: "Неверный логин или пароль")
        }
    }

    func registrationButtonTapped() {
        router?.goToRegistrationScreen()
    }
}
