Now that we have fixed what was reported by Schemathesis, we can just run it
again to check that it does not find anything else wrong with our implementation
or, more specifically, with its compliance with our OpenAPI YAML document.

Go back to your terminal on the right ("Tab 1") and execute the same command as
before:

```sh
st run --checks all openapi.yaml --base-url http://localhost:3025
```

This time, the output will be shown directly on your terminal screen, and likely
all tests will have passed. Woohoo!

Evidently, this should not be construed as meaning that the Calculator program
implementation is perfect and completely bug-free, since there are still many
problems that Schemathesis might not have caught. Nevertheless, it does give
you some confidence that nothing is obviously wrong, even if only because in
this case it did guide you to fix behavior that you now know has been patched.

When used in tandem with more traditional forms of testing, such as unit and
integration testing, API fuzzing is a great way to support your DevOps pipeline!

Let's wrap up what we've learned today.
