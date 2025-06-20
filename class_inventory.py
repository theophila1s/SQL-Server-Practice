class Inventory:
    def __init__(self):
        self.products = {}

    def add_product(self,product_id,name,quantity,price):
        if product_id in self.products:
            self.products[product_id]["quantity"] += quantity 
            print(f"Updated {name}: New quantity is {self.products[product_id]["quantity"]}")
        else:
            self.products[product_id] = {"name": name, "quantity":quantity, "price":price}
            print(f"Added :{name}")
    
    def get_products(self,product_id):
        return self.products.get(product_id, "Product not found")
        
    def get_low_stock(self,threshold):
        return {pid : data for pid, data in self.products.items() if data["quantity"] < threshold}

inventory = Inventory()
inventory.add_product(1,"Apple",10,150)
inventory.add_product(2,"Banana",20,100)
inventory.add_product(3,"Orange",15,120)
inventory.add_product(4,"Mango",5,150)

print(inventory.get_products(2))
print(inventory.get_products(1))

low_stock = inventory.get_low_stock(15)
print(low_stock)