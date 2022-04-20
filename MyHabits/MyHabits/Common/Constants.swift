import UIKit

struct Consts {
    struct FontPalette {
        struct Title3 {
            static let font: UIFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
            static let color: UIColor = UIColor(rgb: 0x000000, a: 1.00)
        }
        struct Headline {
            static let font: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
            static let color: UIColor = UIColor(rgb: 0x296DFF, a: 1.00)
            
        }
        struct Body {
            static let font: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
            static let color: UIColor = UIColor(rgb: 0x000000, a: 1.00)
            
        }
        struct FootnoteStatus {
            static let font: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
            static let color: UIColor = UIColor(rgb: 0x000000, a: 0.50)
        }
        struct Footnote {
            static let font: UIFont = UIFont.systemFont(ofSize: 13, weight: .regular)
            static let color: UIColor = UIColor(rgb: 0x8E8E93, a: 1.00)
        }
        struct Caption {
            static let font: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
            static let color: UIColor = UIColor(rgb: 0xAEAEB2, a: 1.00)
        }
    }
    
    struct ColorPalette {
        static let backgroundNavigationBar: UIColor = UIColor(rgb: 0xF9F9F9, a: 0.94)
        static let backgroundTabBar: UIColor = UIColor(rgb: 0xF9F9F9, a: 0.94)
        static let backgroundViewController: UIColor = UIColor(rgb: 0xF2F2F7, a: 1.00)
        static let backgroundView: UIColor = .white
        static let defaultHabitColor: UIColor = .orange
        struct PregressBar {
            static let background: UIColor = .systemGray5
            static let progress: UIColor = .purple
        }
    }
    
    struct HabitEditView {
        struct Caption {
            static let nameField: String = "НАЗВАНИЕ"
            static let colorField: String = "ЦВЕТ"
            static let timeField: String = "ВРЕМЯ"
            static let timeFieldPrefix: String =  "Каждый день в "
        }
        struct SizeItem {
            static let colorView: CGFloat = 30.0
            static let datePicker: CGFloat = 216
        }
        struct Margin {
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = -16.0
        }
        static let placeholderNameField: String = "Бегать по утрам, спать 8 часов и т.п."
        static let defaultHabitName: String = "Привычка без имени"
        
    }
    struct HabitDetailTableViewCell {
        struct Margin {
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = -16.0
        }

    }
    
    struct TabPage {
        static let infoPageName: String = "Информация"
        static let habitPageName: String = "Привычки"
        static let habitPageButtomTitle: String = "Сегодня"
    }
    struct HabitsCollectionView {
        struct Margin {
            static let left: CGFloat = 16
            static let right: CGFloat = 16
            static let lineSpacing: CGFloat = 12
        }
    }
    struct HobitsCollectionViewCell {
        struct Caption {
            static let countField: String = "Счетчик:"
        }
        struct SizeItem {
            static let imageTakenToday: CGFloat = 60.0
        }
        struct Margin {
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
            static let widthMultiplier: CGFloat = 0.7
        }
    }
    struct HobitsProgressCollectionViewCell {
        struct Caption {
            static let title: String = "Все получится!"
        }
        struct SizeItem {
            static let progressBar: CGFloat = 7.0
        }
        struct Margin {
            static let leading: CGFloat = 12
            static let trailing: CGFloat = -12
            static let top: CGFloat = 10
            static let topBar: CGFloat = 10
        }
    }
    struct InfoContentView {
        struct Caption {
            static let title: String = "Привычка за 21 день"
        }
        struct SizeItem {
            static let title: CGFloat = 24
        }
        struct Margin {
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let topTitle: CGFloat = 22
            static let topInfo: CGFloat = 22
            static let bottom: CGFloat = -16
        }
    }
    struct Global {
        static let borderColor: CGColor = UIColor.lightGray.cgColor
        static let borderWidth: CGFloat = 0.5
        static let localeIdentifier: Locale = Locale(identifier: "ru_RU")
        static let intoText: String =
        """
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        
        1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
        
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.
        
        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
        
        4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
        
        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        
        6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
        """
    }
}
