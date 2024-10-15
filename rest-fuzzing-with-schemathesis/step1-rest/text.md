Web-based solutions are usually divided into server-side components (backend)
and client-side components (frontend). These separate parts operate
independently, but need some way of communicating between them. In some cases,
one part *C* might depend on a service provided by *S* to perform some operation
*S* is specialized in.

In order to allow information to be sent between these programs, a specific
"language" needs to be established and agreed upon, so that everyone involved
knows what messages can be sent to whom and with what parameters, as well as
what the response will look like and how it can be parsed.

These sets of definitions and protocols exposed by one part and used by others
is called an **Application Programming Interface (API)**, and a common paradigm
for defining one is called **REST** (for *REpresentational State Transfer*),
since some representation of relevant objects is sent back and forth. Nowadays,
it is usual for **RESTful APIs** to be based on **HTTP** and use representations
in **JSON** (*JavaScript Object Notation*), meaning that a lot of components
have a common language they speak and so can easily be interoperable with each
other.

![REST API](./rest_api.jpg)\
(Image source: _https://blog.postman.com/rest-api-examples/_)

Servers accept *requests* at some *API endpoint*, defined by a **verb** (such
as `GET`{{}}{{}}/`POST`{{}}/`DELETE`{{}}/...) and a **URL**. They process such
requests and then reply with a *response* that the client applications can
parse.

For example, a pet store server might accept HTTP `GET`{{}} requests at
`/pets`{{}} and respond with a brief list of all the pets it has available:

```json
[
    {"id": 34, "name": "Karen", "kind": "cat"},
    {"id": 178, "name": "Bob", "kind": "turtle"}
]
```

It might also similarly accept `POST`{{}} requests at the same URL to register a
new pet, with the client having to submit some pieces of information, such as:

```json
{
    "name": "Francis",
    "kind": "dog",
    "cute": true,
    "sofas_destroyed": 17
}
```

# Next Up

You should now have some sense of what an API is, and what an HTTP-based REST
API looks like. Let's now move onto the next key concept of this tutorial.
