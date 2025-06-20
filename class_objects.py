class EmployeeManager:
    def __init__(self):
        self.employees = []
    def add_employees(self,emp_id,name,salary):
        self.employees.append({"id":emp_id, "name":name, "salary":salary})
        print(f"Employee {name} is added")
    def get_employees(self,emp_id):
        self.emp_id = emp_id
        for employee in self.employees:
            if employee["id"] == emp_id:
                return employee
        return f"No Employee found with id {emp_id}"

    def get_high_salary_employee(self,min_salary):
        return [emp for emp in self.employees if emp["salary"] > min_salary]

manager = EmployeeManager()
manager.add_employees(1123,"Priya",45000)
manager.add_employees(1124,"Rahul",50000)
manager.add_employees(1125,"Shreya",25000)

print(manager.get_employees(1124))

high_salary = manager.get_high_salary_employee(25000)
print(high_salary)
