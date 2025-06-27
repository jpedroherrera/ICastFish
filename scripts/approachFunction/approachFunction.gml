function approach(val, target, amount)
{
    return (val < target) ? min(val + amount, target) : max(val - amount, target);
}