with open("C:\\Users\\theop\\OneDrive\\Desktop\\py\\sample.txt","w") as file:
    file.write("file handling")

with open("C:\\Users\\theop\\OneDrive\\Desktop\\py\\sample.txt","r") as file:
    content = file.read()
    print(content)

with open("C:\\Users\\theop\\OneDrive\\Desktop\\py\\sample.txt","a") as file:
    file.write("\nThis is an addition to the file")