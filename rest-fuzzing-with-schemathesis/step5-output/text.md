Let's take a look at the report that Schemathesis generated for us. Run

```sh
cat st.out
```

in your terminal to see the result from the previous command. Remember that you
can scroll up and down using your arrow keys, and quit at any time by pressing
`Q`{{}}.

From top to bottom, we first see a summary of the entire test run, including a
list of endpoints that were tested. Following that, we see a list of failures
grouped by endpoint, corresponding to the problems automatically detected by
Schemathesis based on the fuzzing it performed on our Calculator API.

The first one concerns our addition functionality, and Schemathesis's very
readable output makes it easy to understand at a glance that the server
"crashed" with our input (Internal Server Error). Schemathesis shows us the
server output and specifies how we can reproduce this test, i.e., tells us what
inputs it generated for this test. In this case, we can see that it tried to
send `[]`{{}} (an empty array) as the list of numbers to sum, and the server
was unable to cope with that. This is obviously a bug, but easy to miss if
you're just looking at the code.

The second failing test case is also about `POST /sum`{{}}, but in this case the
input is `[8.988465674311579e+307, 8.98846567431158e+307]`{{}}. Obviously, these
are two extremely large numbers that the fuzzer is requesting the server to add
together, and since their sum overflows (it's a larger number than what can be
represented in JavaScript), the result will be `Infinity`{{}}. Since JSON cannot
natively encode that value, the server responds with a computed quotient of
`null`{{}}, which Schemathesis flags because the contract YAML file specifies
that a number should be expected (and `null`{{}} is not a number).

Thirdly, and this time with respect to `POST /divide`{{}}, the tool has
attempted to request the division of 4 by 2.2250738585072014e-308. Since the
divisor is such a small number (almost zero), the resulting quotient will too be
a number that is larger than what JavaScript can represent, so `Infinity`{{}}
(and thus `null`{{}}, in JSON) is what is responds with.

Next, for exponentiation, Schemathesis has detected that trying to calculate
0 to the power of -1 yields null, instead of a number (which it expected
based on our OpenAPI contract document). This is because 0 to the power of -1 is
equivalent to the fraction 1 over 0, and division by zero is usually not
mathematically defined. In JavaScript, calculating `0 ** (-1)`{{}} also returns
`Infinity`{{}}, which is why `null`{{}} is sent, just like the case above.

Finally, a failure is also reported for `GET /history`, since the response sent
by the client does not adhere to the acceptable formats specified in the
contract for that endpoint. We see that one of the operations returned is

```json
{
    "operation": "exponentiation",
    "base": 0,
    "exponent": -1,
    "power": null
}
```

which corresponds to the test case we've just looked at. The problem is that the
result `null`{{}} is not a number, so Schemathesis reports that the response did
not conform to its expectations. However, as we've seen, this is a problem with
the exponentiation functionality and not necessarily with the history endpoint
itself, so in a way this is a kind of "false positive". An error elsewhere in
the program has propagated here and so detected twice, but this test case does
not give evidence of any problem with `GET /history`{{}}, so we can safely
ignore it in this concrete situation.

At the very end of the output, we see some more statistics: in this run, the
fuzzer conducted 434 tests (each with different inputs), checking 7 different
response aspects for each of them.

# Next Up

Having now a sense of what might be wrong with our Calculator application, in
the next step we will try to quickly patch these bugs.
