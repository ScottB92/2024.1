n = input("Expression: ").strip()

n = n.split(" ")

x = float(n[0])
y = n[1]
z = float(n[2])

if y == "+":
    result = x + z
elif y == "-":
    result = x - z
elif y == "*":
    result = x * z
elif y == "/":
    result = x / z
else:
    result = "Invalid operator"

print(result)
