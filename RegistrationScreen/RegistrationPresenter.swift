import Foundation

final class RegistrationPresenter: RegistrationPresenterProtocol {

    weak var view: RegistrationViewProtocol?
    var router: RegistrationRouterProtocol?

    func saveButtonTapped() {
        view?.clearTextFieldsColor()

        guard let password = view?.getPassword(),
              let secondPassword = view?.getSecondPassword(),
              let account = view?.getLogin(),
        else { return }

        if password.isEmpty {
            view?.setTextFieldsColor(.password)
            view?.showError(title: "Ошибка", message: "Введите пароль")
            return
        }

        if secondPassword.isEmpty {
            view?.setTextFieldsColor(.secondPassword)
            view?.showError(title: "Ошибка", message: "Повторите пароль")
            return
        }

        if account.isEmpty {
            view?.setTextFieldsColor(.login)
            view?.showError(title: "Ошибка", message: "Введите логин")
            return
        }
        
        if password != secondPassword {
            view?.setTextFieldsColor(.password)
            view?.setTextFieldsColor(.secondPassword)
            view?.showError(title: "Ошибка", message: "Пароли должны совпадать")
            return
        } else {
            // secondPasswordTextField.backgroundColor = .systemBackground // подумать тут
        }
        
        // Проверка на уникальность логина
        let savedLogin = UserDefaults.standard.string(forKey: "login")
        if account == savedLogin {
            view?.setTextFieldsColor(.login)
            view?.showError(title: "Ошибка", message: "Пользователь с таким логином уже существует")
            return
        }

        UserDefaults.standard.set(account, forKey: "login")

        KeychainService.shared.savePasswordToKeychain(login: account, password: password)

        router?.closeRegistrationVC()
    }

}