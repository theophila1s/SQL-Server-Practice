import json
data = {
    "person":{
        "name": "John",
        "age": 30
    },
    "student" : {
        "name": "Alice",
        "age": 25
    }
}
with open(r"C:\Users\theop\OneDrive\Desktop\py\sample_json_file.json","w") as file:
    json.dump(data, file, indent=2)
with open(r"C:\Users\theop\OneDrive\Desktop\py\sample_json_file.json","r") as file:
    data = json.load(file)
print(data["student"]["name"])
print(data["person"])