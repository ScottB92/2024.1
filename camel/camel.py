camel_name = input("Name? ")

string_name = ""

for char in camel_name:
    if char.islower():
        string_name += char
    elif char.upper():
        string_name += "_" + char.lower()

print(string_name)
