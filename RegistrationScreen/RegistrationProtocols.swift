import Foundation

protocol RegistrationViewProtocol: AnyObject {
    func getLogin() -> String
    func getPassword() -> String
    func getSecondPassword() -> String   
    func getName() -> String 
    func getPhone() -> String
    func getEmail() -> String
    func setTextFieldsColor(_ textField: RegistrationTextFields)
    func clearTextFieldsColor()
    func showError(title: String, message: String)
}

protocol RegistrationPresenterProtocol: AnyObject {
    func saveButtonTapped()
    func exitButtonTapped() 
}

protocol RegistrationRouterProtocol: AnyObject {
    func closeRegistrationVC()
}
