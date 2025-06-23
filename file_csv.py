import csv
data = [['Name','Age'],
        ['John', 25],
        ['Anna', 30]]
with open(r"C:\Users\theop\OneDrive\Desktop\py\sample_csv","w",newline='') as file:
    writer = csv.writer(file)
    writer.writerows(data)
with open(r"C:\Users\theop\OneDrive\Desktop\py\sample_csv","r") as file:
    reader = csv.reader(file)
    for row in reader:
        print(row)