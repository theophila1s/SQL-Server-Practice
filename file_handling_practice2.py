import json
with open(r'C:\Users\theop\OneDrive\Desktop\py\data.json', 'r') as file:
    data = json.load(file) 
print(data)


import json
json_string = '{"name": "John", "age": 30, "city": "New York"}'
# Parse JSON string into a Python dictionary
data = json.loads(json_string)
print(data)


import json
data = {
    "name": "Alice",
    "age": 25,
    "city": "Boston",
    "skills": ["Python", "SQL", "Machine Learning"]
}
# Write JSON data to a file
with open(r'C:\Users\theop\OneDrive\Desktop\py\output.json', 'w') as file:
      json.dump(data, file, indent=4)  




import json
# Python data to convert into a JSON string
data = {
    "name": "Bob",
    "age": 40,
    "city": "Chicago"
}
# Convert Python data to a JSON string
json_string = json.dumps(data, indent=2)
print(json_string)
