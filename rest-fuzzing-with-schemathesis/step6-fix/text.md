Now that Schemathesis has helpfully identified some problems with our
Calculator implementation, we can turn our attention toward the JavaScript
script that is actually performing the calculations. We need to change it to add
more sanitization so that the application can be more robust, especially against
what the fuzzer detected.

We can start by opening the `calculator.js`{{}} file using Vim, our favorite
text editor. In your terminal, run:

```sh
vim calculator.js
```

You can use your arrow keys to move around, and if you've never used Vim before
you should probably press `I`{{}} to enter "insert mode" so it works like a
normal editor.

Let's look at the two main problems that Schemathesis reported, one at a time.

# Summing an Empty Array

If you remember, the first problem we identified was that telling the server to
add together the numbers in an empty array did not work, since there was nothing
there to sum. We can solve this in multiple ways, but the easiest and most
explicit might be to just send an error response whenever an empty list is
provided as input. This can be done by adding a new `else if`{{}} clause to the
`if`{{}} statement on line 22 in the sum endpoint handler. For example:

```js
else if (numbers.length === 0) {
  res.status(400).json({ error: "Array cannot be empty" });
  return;
}
```

This means that the server will reject any empty arrays and the client can
easily understand what they did wrong based on the error message they receive.

# Dealing with Infinity

The other major problem detected by Schemathesis was the application's inability
to deal with very large numbers, since they resulted in `Infinity`{{}} and that
is not representable in JSON, so the server just sent `null`{{}} back.

Again, there are multiple ways of solving this, but since JavaScript doesn't
actually have any problem with performing the calculations (e.g., it doesn't
crash or error) it might be easier to look at the output rather than trying to
sanitize the input to prevent nonsensical results. We can thus just look at the
return value before sending it (and before adding it to the `history`{{}}
array), replying instead with an error if it is not a finite number.

We need to do this for each of the mathematical operations (sum, division, and
exponentiation), but the code is virtually identical. You should edit each of
the three respective API handlers and add something similar to the snippet
below (where `<returnValue>`{{}} is the relevant variable name, so `sum`{{}}/
`quotient`{{}}/`power`{{}}):

```js
if (!Number.isFinite(<returnValue>)) {
  res.status(400).json({ error: "Result out of bounds"});
  return;
}
```

It's important to perform this check before the result is pushed onto the
history array (i.e., before `history.push(...)`{{}}), since otherwise the
`GET /history`{{}} endpoint will return invalid values that don't conform to the
contract schema. Conversely, if we do fix this properly, the "false positive"
Schemathesis detected for our history endpoint will automatically be "fixed"
without us even having to change the handler, since there was nothing inherently
wrong with it.

# Exiting Vim

You're stuck. "Help.", you might think.

Well, lucky you, here's a hint: one of the actions below will help you save the
file and successfully exit Vim. Can you guess which one?

- do a cartwheel, toward the general direction of New York City;
- play rock-paper-scissors with your estranged sister, and lose on purpose;
- press `Esc`{{}} to leave "insert mode", then type `:wq`{{}}, and finally
  press `Enter`{{}};
- wonder if life would be better as a shepherd tending sheep in Nepal;
- turn off your computer.

# Next Up

If you picked the correct option from the list above, you will hopefully have
successfully finished fixing all the problems detected by Schemathesis. Let's
now double-check that in the next step.
