//
//  UIImageView + Extensions.swift
//  RikMastersApp
//
//  Created by Марк Киричко on 20.05.2025.
//

import UIKit

extension UIImageView {
    
    func loadImage(from urlString: String) {
       
        // Проверяем корректность URL
        guard let url = URL(string: urlString) else { return }

        // Загружаем изображение асинхронно
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Обработка ошибок
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return
            }

            // Проверка данных
            guard let data = data, let image = UIImage(data: data) else { return }

            // Обновление интерфейса в главном потоке
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
