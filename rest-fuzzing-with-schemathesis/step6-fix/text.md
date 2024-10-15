fix javascript to prevent the problems found

"this is how you use vim"

# Empty array passed to sum
Let's first start by fixing the crashing issue when an empty array is passed as
input to the sum function. We can solve the problem by checking if the array is
empty before we compute the sum. This can be done by adding the following
`else if`{{}} statement on `line 26`{{}}:
```js
else if (!numbers.length) {
  res.status(400).json({ error: "Body must contains an empty array" });
  return;
}
```

# Infinite numbers
We will now take a look at how we can resolve the problem with the return values
being infinite. One simple way to solve this is to, for all the mathematical
functions, check if the return value, i.e., the `sum`{{}}, `quotient`{{}}, or
`power`{{}}, is finite. This can be done by adding the following code before the return value is added to the history:
```js
if (Number.isFinite(returnValue)) {
  res.status(400).json({ error: "Number overflow"});
  return;
}
```
It is important that this code is added before the return value is added to the
history in order to ensure that the history doesn't contain any infinite values,
since this would break the contract.
