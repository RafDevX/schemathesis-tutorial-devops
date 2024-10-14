const express = require("express");
const app = express();
app.use(express.json());

const port = 3025;

const history = [];

app.use((err, req, res, next) => {
  if (err instanceof SyntaxError && err.status === 400 && "body" in err) {
    res.status(400).json({ error: "Invalid JSON" });
    return;
  }

  res.status(500).json({ error: "Unknown error" });
});

const send405 = (req, res) => res.status(405).json({ error: "Invalid method"});

app.post("/sum", (req, res) => {
  const numbers = req.body;
  if (!Array.isArray(numbers) || numbers.some(x => typeof x !== "number")) {
    res.status(400).json({ error: "Body must comprise list of numbers" });
    return;
  }

  const sum = numbers.reduce((a, b) => a + b);
  history.push({ operation: "sum", numbers, sum });

  res.json({ sum  });
});
app.all("/sum", send405);

app.post("/divide", (req, res) => {
  if (typeof req.body !== "object") {
    res.status(400).json({ error: "Body must be an object "});
    return;
  }

  const { dividend, divisor } = req.body;
  if (typeof dividend !== "number" || typeof divisor !== "number") {
    res.status(400).json({ error: "Body must include dividend and divisor" });
    return;
  }

  if (divisor == 0) {
    res.status(400).json({ error: "Division by zero "});
    return;
  }

  const quotient = dividend / divisor;
  history.push({ operation: "division", dividend, divisor, quotient });

  res.json({ quotient });
});
app.all("/divide", send405);

app.post("/power", (req, res) => {
  if (typeof req.body !== "object") {
    res.status(400).json({ error: "Body must be an object "});
    return;
  }

  const { base, exponent } = req.body;
  if (typeof base !== "number" || typeof exponent !== "number") {
    res.status(400).json({ error: "Body must include base and exponent" });
    return;
  }

  const power = base ** exponent;
  history.push({ operation: "exponentiation", base, exponent, power });

  res.json({ power  });
});
app.all("/power", send405);

app.get("/history", (req, res) => {
  res.json(history);
});
app.all("/history", send405);

app.get("/very-secret", (req, res) => {
  res.redirect("https://youtu.be/dQw4w9WgXcQ");
});
app.all("/very-secret", send405);

app.listen(port, () => {
  console.log(`Calculator listening on port ${port}`)
});
