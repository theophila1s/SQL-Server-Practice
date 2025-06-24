import pyodbc

server = r'theophilamurphy'  
database = 'CarDB'

conn = pyodbc.connect(
    rf'DRIVER={{ODBC Driver 17 for SQL Server}};'
    rf'SERVER={server};'
    rf'DATABASE={database};'
    r'Trusted_Connection=yes;'
)

cursor = conn.cursor()

cursor.execute("SELECT TOP 100 * FROM [CarDB].[CR].[Customertable]")
for row in cursor.fetchall():
    print(row)

cursor.execute("SELECT TOP 100 * FROM [CarDB].[CR].[Leasetb]")
for row in cursor.fetchall():
    print(row)

cursor.execute("SELECT TOP 100 * FROM [CarDB].[CR].[Paymentstable]")
for row in cursor.fetchall():
    print(row)

cursor.execute("SELECT TOP 100 * FROM [CarDB].[CR].[Vehicletable]")
for row in cursor.fetchall():
    print(row)




#CRUD OPERATION ON Customertable 
# INSERT
cursor.execute(
    "INSERT INTO CR.Customertable (customerID, firstName, lastName, email, phoneNumber) VALUES (?, ?, ?, ?, ?)",
    (11, 'Shruthi', 'Raj', 'shruthi@example.com', '5556443210')
)
conn.commit()

# READ
cursor.execute("SELECT * FROM CR.Customertable")
for row in cursor.fetchall():
    print(row)

# UPDATE
cursor.execute("UPDATE CR.Customertable SET phoneNumber = ? WHERE customerID = ?", ('9998887770', 11))
conn.commit()


# DELETE
cursor.execute("DELETE FROM CR.Customertable WHERE customerID = ?", (11,))
conn.commit()




#CRUD OPERATION ON Paymentstable
# INSERT
cursor.execute(
    "INSERT INTO CR.Paymentstable (paymentID, leaseID, paymentDate, amount) VALUES (?, ?, ?, ?)",
    (301, 10, '2025-06-24', 350.00)
)
conn.commit()

# READ
cursor.execute("SELECT * FROM CR.Paymentstable")
for row in cursor.fetchall():
    print(row)

# UPDATE
cursor.execute("UPDATE CR.Paymentstable SET amount = ? WHERE paymentID = ?", (400.00, 301))
conn.commit()

# DELETE
cursor.execute("DELETE FROM CR.Paymentstable WHERE paymentID = ?", (301,))
conn.commit()



cursor.close()
conn.close()