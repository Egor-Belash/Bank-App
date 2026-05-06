//
//  NotificationService.swift
//  Bank App
//
//  Created by Egor on 03.05.2026.
//

import Foundation
import UserNotifications

final class NotificationService {
    static let shared = NotificationService()
    
    private init() {}
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            print(granted ? "✅ Разрешено" : "❌ Отклонено")
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func scheduleNotification() {
        // Шаг 1: Проверяем текущий статус разрешений.
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("⚠️ Нет разрешения")
                return
            }
            
            // Шаг 2: Формируем содержимое уведомления.
            let content = UNMutableNotificationContent()
            content.title = "💸 BankApp 💸"
            content.body = self.messages.randomElement() ?? "Вы помните, какой банк лучший? 😎"
            content.sound = .defaultRingtone
            content.badge = 1
            
            var dateComponents = DateComponents()
            dateComponents.hour = 21
            dateComponents.minute = 00
            
            // Шаг 3: Создаём триггер — условие срабатывания уведомления.
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents,
                repeats: true
            )
            
            // Шаг 4: Собираем запрос из identifier + content + trigger.
            let request = UNNotificationRequest(
                identifier: "dailyReminder",
                content: content,
                trigger: trigger
            )
            
            // Шаг 5: Передаём запрос в очередь уведомлений.
            UNUserNotificationCenter.current().add(request) { error in
                if let error {
                    print("❌ Ошибка: \(error.localizedDescription)")
                } else {
                    print("✅ Запланировано")
                }
            }
        }
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
    }
    
    let messages = [
        "Ваш баланс скучает без пополнения 😢",
        "Кажется, вы забыли потратить деньги 💳",
        "Банк переживает за ваши финансы 🫣",
        "Поздравляем 🎉, у вас новый долг",
        "Ваш кошелёк стал слишком лёгким 🤨"
    ]
}
