class BankAccount:
    """Base class for a generic bank account."""
    def __init__(self, account_holder, balance=0):
        self.account_holder = account_holder  # Public attribute
        self.__balance = balance  # Private attribute

    # Encapsulated method to access private balance
    def get_balance(self):
        return self.__balance

    def deposit(self, amount):
        """Deposit money into the account."""
        if amount > 0:
            self.__balance += amount
            print(f"{amount} deposited. New balance: {self.__balance}")
        else:
            print("Invalid deposit amount!")

    def withdraw(self, amount):
        """Withdraw money from the account (to be overridden)."""
        raise NotImplementedError("Withdraw method must be implemented by subclasses.")

    def get_account_info(self):
        """Return account information (to be overridden)."""
        raise NotImplementedError("get_account_info method must be implemented by subclasses.")

# Savings Account class
class SavingsAccount(BankAccount):
    """Savings account with interest and minimum balance."""
    def __init__(self, account_holder, balance=0, interest_rate=0.03):
        super().__init__(account_holder, balance)
        self.interest_rate = interest_rate  # Public attribute

    def withdraw(self, amount):
        """Savings account allows withdrawal only if balance >= 500 after withdrawal."""
        if self.get_balance() - amount >= 500:
            # Access private balance using deposit method to decrease balance
            self.deposit(-amount)  # Using negative deposit to reduce balance
            print(f"{amount} withdrawn from Savings Account.")
        else:
            print("Insufficient balance! Minimum balance of 500 must be maintained.")

    def calculate_interest(self):
        """Add interest to the account balance."""
        interest = self.get_balance() * self.interest_rate
        self.deposit(interest)
        print(f"Interest of {interest} added.")

    def get_account_info(self):
        return f"SavingsAccount: Holder: {self.account_holder}, Balance: {self.get_balance()}"

# Current Account class
class CurrentAccount(BankAccount):
    """Current account with overdraft facility."""
    def __init__(self, account_holder, balance=0, overdraft_limit=1000):
        super().__init__(account_holder, balance)
        self.overdraft_limit = overdraft_limit

    def withdraw(self, amount):
        """Current account allows withdrawal even if balance goes negative, up to overdraft limit."""
        if self.get_balance() - amount >= -self.overdraft_limit:
            self.deposit(-amount)  # Using negative deposit to reduce balance
            print(f"{amount} withdrawn from Current Account.")
        else:
            print("Exceeded overdraft limit!")

    def get_account_info(self):
        return f"CurrentAccount: Holder: {self.account_holder}, Balance: {self.get_balance()}"

# Main program demonstrating all concepts
def main():
    # Create accounts
    savings = SavingsAccount("Lavanya", balance=9000, interest_rate=0.04)
    current = CurrentAccount("Shrithi", balance=1000, overdraft_limit=1000)

    # Polymorphism: Different behaviors for the same method
    accounts = [savings, current]

    for account in accounts:
        print("\n" + account.get_account_info())
        account.deposit(12000)
        account.withdraw(1000)

        if isinstance(account, SavingsAccount):
            account.calculate_interest()  # Specific to SavingsAccount

    print("\nFinal Account Information:")
    for account in accounts:
        print(account.get_account_info())

if __name__ == "__main__":
    main()

