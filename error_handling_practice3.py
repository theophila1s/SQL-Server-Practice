import json

try:
    with open(r'C:\Users\theop\OneDrive\Desktop\py\sample_csv.csv', 'r') as file:
        data = json.load(file)
except FileNotFoundError:
    print("The file was not found.")
except json.JSONDecodeError:
    print("Invalid JSON format.")




import csv
data = [
    ['Name', 'Age', 'City'],
    ['A', 28, 'Boston'],
    ['B', 35, 'San Francisco']
]
# Open a file in write mode
with open(r'C:\Users\theop\OneDrive\Desktop\py\sample_csv.csv', 'w', newline='') as file:
    csv_writer = csv.writer(file)
    # Write rows
    csv_writer.writerows(data)



import csv

# Data to write
data = [
    ['Name', 'Age', 'City'],
    ['Alice', 28, 'Boston'],
    ['Bob', 35, 'San Francisco']
]

# Open a file in write mode
with open(r'C:\Users\theop\OneDrive\Desktop\py\sample_csv.csv', 'w', newline='') as file:
    csv_writer = csv.writer(file)
    
    # Write rows
    csv_writer.writerows(data)

