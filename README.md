```bash
curl -s -H "Content-Type: application/json" \
   -XPOST http://localhost:5100/api/v1/booksn \
   --data '{"title":"2061: Odyssey Three", "author":"Arthur C. Clarke", "isbn":"0345358791"}'
```
`201 Created`

Run RSpec tests to see what all verbs are workring.
