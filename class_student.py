class Student:
    def __init__(self,student_id,student_name):
        self.student_id =  student_id 
        self.student_name = student_name

    def get_details(self):
        print(f"Student ID is {self.student_id}")
        print(f"Student Name is {self.student_name}")

student = Student(104,"Shreja")
print(student.get_details())
