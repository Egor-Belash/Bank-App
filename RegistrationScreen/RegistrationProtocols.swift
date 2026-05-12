import Foundation

protocol RegistrationViewProtocol: AnyObject {
    func getLogin() -> String
    func getPassword() -> String
    func getSecondPassword() -> String    
    func setTextFieldsColor(_ textField: RegistrationTextFields)
    func clearTextFieldsColor()
    func showError(title: "Ошибка", message: "Введите пароль")
}

protocol RegistrationPresenterProtocol: AnyObject {
    func saveButtonTapped()
    
}

protocol RegistrationRouterProtocol: AnyObject {
    func closeRegistrationVC()
}