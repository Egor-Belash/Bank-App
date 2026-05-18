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
            content.body = self.messages.randomElement() ?? String(localized: .notificationMessage6)
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
        String(localized: .notificationMessage1),
        String(localized: .notificationMessage2),
        String(localized: .notificationMessage3),
        String(localized: .notificationMessage4),
        String(localized: .notificationMessage5)
    ]
}
