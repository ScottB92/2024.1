def main():

    amount = 50

    print(f"Amount Due: {amount}")

    while amount > 0:
        coin = int(input("Insert Coin: "))
        if coin == 25 or coin == 10 or coin == 5:
            amount -= coin
            if amount > 0:
             print(f"Amount Due: {amount}")
        else:
            print(f"Amount Due: {amount}")
            continue


    change = abs(amount)
    print(f"Change Owed: {change}")


main()
