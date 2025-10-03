def main():

    while True:
        user_fuel = (input("Fraction: ")).split("/")
        try:
            n = int(user_fuel[0])
            d = int(user_fuel[1])
            percent = int(round((n / d) * 100))

            if percent > 100:
                continue

            if percent >= 99:
                print("F")
            elif 99 > percent > 1:
                print(f"{percent}%")
            else:
                print("E")
            break
        except ValueError:
            pass
        except ZeroDivisionError:
            pass




main()
