class Employee:
    def __init__(self, emp_id,emp_name,salary,department):
        self.emp_id = emp_id
        self.emp_name = emp_name 
        self.salary = salary 
        self.department = department

    def calculate_overtime(self,hours,rate_per_hour):
        overtime = hours * rate_per_hour
        return overtime
    
    def get_details(self):
        print(f"Employee ID is {self.emp_id}")
        print(f"Employee Name is {self.emp_name}")
        print(f"Salary is {self.salary}")
        print(f"Department is {self.department}")

employee = Employee(101,"Lavanya",35000,"IT")
result = employee.get_details()
print(result)

pay = employee.calculate_overtime(10,200)
print("overtime pay:", pay)
