class Employee:
    def __init__(self,name,salary):
        self.name = name
        self._salary = salary 
    
    def get_salary(self):
        return self._salary 
    
    def work(self):
        return f"{self.name} is working"
    
#inherited class 

class Developer(Employee):
    def work(self):
        return f"{self.name} is writing coding"

class Manager(Employee):
    def work(self):
        return f"{self.name} is managing the team."
    
developer = Developer("Swathi", 45000)
manager = Manager("Sandhiya", 80000)

for employee in [developer,manager]:
    print(employee.work())
    print(f"{employee.name}'s salary is : {employee.get_salary()}")