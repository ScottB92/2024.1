import emoji

alias = input("Input: ")
alias = emoji.emojize((alias), language='alias')


print(f"Output: {emoji.emojize(alias)}")

