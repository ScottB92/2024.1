def main():

    time = input("What time is it? ")

    decTime = convert(time)

    if 7 <= decTime <= 8:
        print("breakfast time")
    elif 12 <= decTime <= 13:
        print("lunch time")
    elif 18 <= decTime <= 19:
        print("dinner time")


def convert(time):
    hours, minutes = time.split(":")
    num_hours = int(hours)
    num_minutes = int(minutes)
    num_minutes = num_minutes / 60
    decimal_time = num_hours + num_minutes
    return decimal_time


if __name__ == "__main__":
    main()
