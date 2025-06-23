import pandas as pd
data = {'Name': ['Tom', 'nick', 'krish', 'jack'],'Age':[23, 45, 56, 78]}
df = pd.DataFrame(data)
print(df)
df.to_excel(r"C:\Users\theop\OneDrive\Desktop\py\Book1.xlsx",index = False)
df = pd.read_excel(r"C:\Users\theop\OneDrive\Desktop\py\Book1.xlsx")
print(df)