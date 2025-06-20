class Library:
    def __init__(self):
        self.books = []

    def add_books(self,title,author):
        self.books.append({"title": title, "author":author , "available": True})
        print(f" {title} is added")

    def borrow_books(self,title):
        for book in self.books:
            if book["title"] == title:
                if book["available"]:
                    book["available"] = False
                    print(f"You borrowed {title} ")
                    return 
                else:
                    print(f" {title} book is currently unavailable")
                    return 
        print(f"The {title} is not found")

    def get_available_books(self):
        return [book for book in self.books if book["available"]]

library = Library()
library.add_books("Python Programming", "John Doe"),
library.add_books("Data Science", "Jane Doe"),
library.add_books("Machine Learning", "John Doe"),

library.borrow_books("Python Programming")


print(library.get_available_books())