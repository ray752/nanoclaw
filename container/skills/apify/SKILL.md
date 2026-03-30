---
name: apify
description: Run Apify actors (web scrapers, automations) and retrieve their results. Requires APIFY_API_TOKEN.
---

# Apify Integration

Two MCP tools are available for running Apify actors and fetching results.

## Tools

### `apify_run_actor`

Runs an actor and returns its dataset items.

**Parameters:**
- `actor_id` (required) — e.g. `apify/web-scraper`, `apify/google-search-scraper`
- `input` — Actor-specific input object (JSON)
- `max_items` — Max items to return (default 50)
- `wait_secs` — Max wait time in seconds (default 120)

### `apify_get_dataset_items`

Fetches items from a dataset by ID. Use for pagination or retrieving results from a prior run.

**Parameters:**
- `dataset_id` (required) — Dataset ID from a previous run
- `limit` — Max items (default 50)
- `offset` — Skip N items (default 0)

## Common Actors

| Actor ID | Purpose |
|----------|---------|
| `apify/web-scraper` | Generic scraper with custom page function |
| `apify/cheerio-scraper` | Fast HTML-only scraper (no browser) |
| `apify/playwright-scraper` | Full browser scraper |
| `apify/google-search-scraper` | Google search results |

Browse more at https://apify.com/store — each actor's page documents its input schema.

## Examples

Scrape a single page:
```json
{
  "actor_id": "apify/web-scraper",
  "input": {
    "startUrls": [{ "url": "https://example.com" }],
    "pageFunction": "async function pageFunction(context) { return { title: document.title, text: document.body.innerText.slice(0, 5000) }; }"
  },
  "max_items": 10
}
```

Google search:
```json
{
  "actor_id": "apify/google-search-scraper",
  "input": {
    "queries": "site:example.com topic",
    "maxPagesPerQuery": 1
  }
}
```
