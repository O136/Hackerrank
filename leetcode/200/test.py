def myMin(amount, coins, acc):
    if amount == 0:
        return acc

    elif amount < 0:
        return []

    local = []

    for coin in coins:
        acc.append(coin)
        return myMin(amount - coin, coins, acc)
    
    return local

print(myMin(10, [5, 10, 1], []))
