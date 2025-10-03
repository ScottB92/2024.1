import requests
import sys
import json

def main():
    if len(sys.argv) != 2:
        sys.exit("Missing command-line argument")
    try:
        num = float(sys.argv[1])
    except(ValueError, IndexError):
        sys.exit("Command-line argument is not a number")

    bitcoin_api = requests.get("https://api.coindesk.com/v1/bpi/currentprice.json")
    data = bitcoin_api.json()
    usd_rate_float = data["bpi"]["USD"]["rate_float"]

    output = float(sys.argv[1]) * usd_rate_float

    print(f"${output:,.4f}")

main()
