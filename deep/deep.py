a = input("What is the Answer to the Great Question of Life, the Universe, and Everything? ")

a = a.strip().title()

if a == "42":
    print("Yes")
elif a == "Forty-Two":
    print("Yes")
elif a == "Forty Two":
    print("Yes")
else:
    print("No")
