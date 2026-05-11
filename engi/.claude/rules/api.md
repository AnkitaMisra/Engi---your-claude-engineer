---
globs: ["**/routes/**/*.py", "**/api/**/*.py", "**/endpoints/**/*.py"]
description: API route conventions — activates only for route/endpoint files
---

# API route rules

- Every endpoint has a response_model defined — no untyped responses
- HTTP status codes must be explicit — no implicit 200s
- Input validation via Pydantic schemas — never manual validation
- All endpoints are async — no synchronous route handlers
- Error responses use consistent shape: {detail: str, code: str}
- Authentication checked via dependency injection — not inline
- No business logic in route handlers — delegate to services
- Document every endpoint: summary, description, response codes
