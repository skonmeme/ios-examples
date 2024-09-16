import Foundation
import Observation

struct Book: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var author: String
    var cover: String
    var year: Int
    var selected: Bool
    var displayYear: String {
        get {
            return String(year)
        }
    }
}

@Observable class ApplicationData {
    @ObservationIgnored var books: [Book] {
        didSet {
            selectedBooks = find(search: "")
        }
    }
    var selectedBooks: [Book] = [] {
        didSet {
            indexedBooks = getIndexedBooks()
        }
    }
    var indexedBooks: [(key: String, value: [Book])] = []

    private func find(search: String, author: String = "") -> [Book] {
        if search.isEmpty {
            return books.map { $0 }
        } else {
            return books.filter( { item in
                (author.isEmpty || author == item.author) &&
                    item.title.localizedStandardContains(search)
            })
        }
    }

    func filter(search: String, author: String) {
        selectedBooks = find(search: search, author: author)
    }

    func delete(key: String, atOffsets offsets: IndexSet, search: String, author: String) {
        for offset in offsets {
            var found: Book?
            for book in indexedBooks {
                if book.key == key {
                    found = book.value[offset]
                    break
                }
            }
            if let book = found {
                books = books.filter( { item in
                    item.title != book.title || item.author != book.author || item.author != book.author
                })
            }
        }
        filter(search: search, author: author)
    }

    func getInitial(title: String) -> String {
        let first = String(title.prefix(1))
        if first.range(of: "\\p{Hangul}", options: .regularExpression) != nil {
            let firstConsonant = first.unicodeScalars.first!.value
            if firstConsonant >= 0xAC00 && firstConsonant <= 0xD7A3 {
                let index = (firstConsonant - 0xAC00) / 28 / 21
                let consonant = UnicodeScalar(0x1100 + index)!
                return String(consonant)
            }
        }
        return first.uppercased()
    }

    func getIndexedBooks() -> [(key: String, value: [Book])] {
        let listGroup: [String: [Book]] = Dictionary(grouping: selectedBooks, by: { book in
            return getInitial(title: book.title)
        })
        return listGroup.sorted(by: { $0.key < $1.key })
    }

    init() {
        books = [
            Book(title: "하늘이시여", author: "Unknown", cover: "nocover", year: 2025, selected: false),
            Book(title: "Steve Jobs", author: "Walter Isaacson", cover: "book1", year: 2011, selected: false),
            Book(title: "HTML5 for Masterminds", author: "J.D Gauchat", cover: "book2", year: 2017, selected: false),
            Book(title: "The Road Ahead", author: "Bill Gates", cover: "book3", year: 1995, selected: false),
            Book(title: "The C Programming Language", author: "Brian W. Kernighan", cover: "book4", year: 1988, selected: false),
            Book(title: "Being Digital", author: "Nicholas Negroponte", cover: "book5", year: 1996, selected: false),
            Book(title: "Only the Paranoid Survive", author: "Andrew S. Grove", cover: "book6", year: 1999, selected: false),
            Book(title: "Accidental Empires", author: "Robert X. Cringely", cover: "book7", year: 1996, selected: false),
            Book(title: "Bobby Fischer Teaches Chess", author: "Bobby Fischer", cover: "book8", year: 1982, selected: false),
            Book(title: "New Guide to Science", author: "Isaac Asimov", cover: "book9", year: 1993, selected: false),
            Book(title: "Christine", author: "Stephen King", cover: "book10", year: 1983, selected: false),
            Book(title: "IT", author: "Stephen King", cover: "book11", year: 1987, selected: false),
            Book(title: "Ending Aging", author: "Aubrey de Grey", cover: "book12", year: 2007, selected: false),
            Book(title: "호눌이시여", author: "Unknown", cover: "nocover", year: 2025, selected: false)
        ]
        selectedBooks = find(search: "")
    }
}
