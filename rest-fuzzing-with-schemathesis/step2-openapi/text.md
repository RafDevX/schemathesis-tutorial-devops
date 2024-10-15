But how can the client know what API endpoints the server supports, and what
information format it should expect? Usually this is done by means of manual
documentation, with programmers designing documents and websites that clarify
the underlying API. Nevertheless, there is a more powerful way of accomplishing
this: if APIs can be defined in one unified way, generic tools could be used to
parse those descriptions and automatically infer the information needed to
automate important tasks.

**OpenAPI** is a (standardized) specification for a machine-readable interface
definition language that provides a formal standard for describing HTTP-based
APIs. With OpenAPI, an API's specification can be encoded in a YAML document (or
JSON), allowing it to be clearly understood by humans and tools alike, even if
they don't know the specifics of the application. Using OpenAPI, a **contract**
can be established between the API provider and its consumers.

# Calculator API

For the purposes of this tutorial, we have created a simple Node program
(written in JavaScript) that provides a calculator service. The API it exposes
is described in OpenAPI format (version 3.0), with a YAML document specifying
three `POST`{{}} endpoints for different mathematical functions, as well as one
`GET`{{}} endpoint to access the calculator history.

You can take a look at this document by running the command

```sh
cat openapi.yaml
```

in the terminal on the right. Feel free to skim through the file using the arrow
keys and press `Q`{{}} to quit when you're done.

## A Closer Look

This YAML file is relatively long, given that we have several endpoints, so it
can be a bit overwhelming at first. Let's then focus just on the first endpoint
described, `POST /sum`{{}}, which refers to the sum function. The specification
includes an operation ID (which might be referenced in the code), a summary
description of what operation is performed, and a description of what possible
request bodies and responses are valid:

```yaml
/sum: # <--- this is the path to which requests can be sent
    post: # <--- the verb for this operation
        operationId: sum
        summary: Sum multiple numbers
        requestBody:
            ... # when making a request, what does the client need to send?
        responses:
            ... # what do server replies look like?
```

First, let's take a look at the request body specification:

```yaml
requestBody:
    description: The list of numbers to sum
    content:
        application/json:
            schema:
                type: array
                items:
                    type: number
            examples:
                list-of-three:
                    value: [23, 27, 2]
```

We can see that the request body is expected to contain an array of numbers,
which (from the description) clearly correspond to the numbers that the server
will add together. The schema is enough for a machine to understand everything,
but an example is also provided to help humans better visualize this.

Next, we can look at what responses the server might reply with (and which the
client should be ready to parse):

```yaml
responses:
    "200":
        description: OK
        content:
            application/json:
                schema:
                    type: object
                    properties:
                        sum:
                            type: number
                    required:
                        - sum
                examples:
                    result:
                        value:
                            sum: 52
    "400":
        $ref: "#/components/responses/BadRequestResponse"
```

From this snippet, we can easily infer that there are two possible responses. If
everything is correct, a JSON object such as
```json
{"sum": 52}
```
will be sent with HTTP status code `200 OK`{{}}; otherwise, we'll receive a
`400 Bad Request`{{}} response indicating some problem with our request.

The `$ref`{{}} here shows how we can reuse certain snippets in multiple places,
to promote consistency and readability. It just points the reader to go look at
the description in `#/components/responses/BadRequestResponse`{{}} further down
in the YAML file. If we scroll all the way down (or press `Shift + G`{{}}), we
see:

```yaml
components:
    responses:
        BadRequestResponse:
            description: Bad Request
            content:
                application/json:
                    schema:
                        type: object
                        properties:
                            error:
                                type: string
                        required:
                            - error
```

which is, similarly, quite easy to understand: the server might reply with
something like
```json
{"error": "Body must comprise list of numbers"}
```

# Next Up

Now that you know how to read OpenAPI files, let's take a closer look at our
Calculator application.
