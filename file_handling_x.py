from bs4 import BeautifulSoup
xml_data = """ 
    <books>
        <book id="1">
            <title>The Great Gatsby</title>
            <author>Harper</author>
""" 
soup = BeautifulSoup(xml_data, 'xml')
with open(r"C:\Users\theop\OneDrive\Desktop\py\sample_x.xml","w") as file:
    file.write(soup.prettify())
with open(r"C:\Users\theop\OneDrive\Desktop\py\sample_x.xml","r") as file:
    soup = BeautifulSoup(file,'xml')
    author = soup.find('author').text
    print(author)
