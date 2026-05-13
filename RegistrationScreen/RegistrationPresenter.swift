import Foundation

final class RegistrationPresenter: RegistrationPresenterProtocol {

    weak var view: RegistrationViewProtocol?
    var router: RegistrationRouterProtocol?

    func saveButtonTapped() {
        view?.clearTextFieldsColor()

        guard let password = view?.getPassword(),
              let secondPassword = view?.getSecondPassword(),
              let account = view?.getLogin()
        else { return }

        if password.isEmpty {
            view?.setTextFieldsColor(.password)
            view?.showError(title: String(localized: .error), message: String(localized: .registrationEnterPassword))
            return
        }

        if secondPassword.isEmpty {
            view?.setTextFieldsColor(.secondPassword)
            view?.showError(title: String(localized: .error), message: String(localized: .registrationSecondPasswordLabel))
            return
        }

        if account.isEmpty {
            view?.setTextFieldsColor(.login)
            view?.showError(title: String(localized: .error), message: String(localized: .registrationEnterLogin))
            return
        }
        
        if password != secondPassword {
            view?.setTextFieldsColor(.password)
            view?.setTextFieldsColor(.secondPassword)
            view?.showError(title: String(localized: .error), message: String(localized: .registrationPasswordsMustBeEqual))
            return
        }
        
        // Проверка на уникальность логина
        let savedLogin = UserDefaults.standard.string(forKey: "login")
        if account == savedLogin {
            view?.setTextFieldsColor(.login)
            view?.showError(title: String(localized: .error), message: String(localized: .registrationUsernameExists))
            return
        }

        saveData(login: account, password: password)

        router?.closeRegistrationVC()
    }

    func exitButtonTapped() {
        router?.closeRegistrationVC()
    }

    // MARK: – Privates 
    private func saveData(login: String, password: String) {
        UserDefaults.standard.set(login, forKey: "login")
        KeychainService.shared.savePasswordToKeychain(login: login, password: password)

        let name = view?.getName()
        UserDefaults.standard.set(name, forKey: "name")

        let phone = view?.getPhone()
        UserDefaults.standard.set(phone, forKey: "phone")

        let email = view?.getEmail()
        UserDefaults.standard.set(email, forKey: "email")
    }

}
