class Rectangle:
    def __init__(self,length,breadth):
        self.length = length
        self.breadth = breadth
    def get_details(self):
        return f" Rectangle area is {self.length * self.breadth }"
    
rectangle = Rectangle(4,5)
print(rectangle.get_details())