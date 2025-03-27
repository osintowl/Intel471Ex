# Intel471Ex

An Elixir client library for Intel 471's Titan API providing access to cyber threat intelligence.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Basic Usage](#basic-usage)
- [API Examples](#api-examples)
  - [Actors](#actors)
  - [Alerts](#alerts)
  - [Reports](#reports)
  - [Credentials](#credentials)
  - [Vulnerabilities](#vulnerabilities)
  - [IOCs](#iocs)
  - [Search](#search)
  - [Watchers](#watchers)
  - [Malware Intelligence](#malware-intelligence)
- [Working with Streams](#working-with-streams)
- [Error Handling](#error-handling)

## Installation

Add `intel471_titan` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:intel471_titan, "~> 0.1.0"}
  ]
end
```

## Configuration

This library uses system environment variables for authentication and configuration:

```
# Required
INTEL471_USERNAME=your-email@example.com
INTEL471_API_KEY=your-api-key

# Optional
INTEL471_API_URL=https://api.intel471.com/v1  # Default API URL
INTEL471_API_VERSION=1.20.0                   # Optional API version
```

You can set these environment variables in your system or within your application:

```elixir
# Set in your application
System.put_env("INTEL471_USERNAME", "your-email@example.com")
System.put_env("INTEL471_API_KEY", "your-api-key")
```

## Basic Usage

```elixir
# Fetch actors matching "threat_actor"
{:ok, result} = Intel471Ex.Actors.search(%{actor: "threat_actor"})
IO.puts("Found #{result["actorTotalCount"]} actors")

# Get a specific report
{:ok, report} = Intel471Ex.Reports.get("32537c9c6dce18ce6ea4d5106540f089")
IO.puts("Report title: #{report["subject"]}")
```

## API Examples

### Actors

```elixir
# Search for actors
{:ok, result} = Intel471Ex.Actors.search(%{actor: "synthx"})
IO.inspect(result["actorTotalCount"])

# Search actors active on a specific forum
{:ok, result} = Intel471Ex.Actors.search(%{forum: "0day"})

# Get a specific actor by UID
{:ok, actor} = Intel471Ex.Actors.get("e7fafbb8f44a6ded005c154976627da4")
IO.inspect(actor["handles"])
```

### Alerts

```elixir
# Get recent alerts (last 24 hours)
{:ok, result} = Intel471Ex.Alerts.list(%{from: "24hours", count: 10})
IO.puts("Found #{result["alertTotalCount"]} alerts")

# Get alerts from a specific watcher group
{:ok, result} = Intel471Ex.Alerts.list(%{watcherGroup: "10dce938-3db9-463b-9c2f-b485ab398805"})

# Continue pagination using the last alert's UID
last_alert_uid = List.last(result["alerts"])["uid"]
{:ok, next_page} = Intel471Ex.Alerts.list(%{count: 10, offset: last_alert_uid})
```

### Reports

```elixir
# Search for reports about ransomware
{:ok, result} = Intel471Ex.Reports.search(%{report: "ransomware"})
IO.puts("Found #{result["reportTotalCount"]} reports")

# Search reports by location
{:ok, result} = Intel471Ex.Reports.search(%{reportLocation: "Germany"})

# Get a specific report
{:ok, report} = Intel471Ex.Reports.get("32537c9c6dce18ce6ea4d5106540f089")

# Search breach alerts
{:ok, alerts} = Intel471Ex.Reports.breach_alerts(%{breachAlert: "Communications"})

# Get a specific breach alert
{:ok, alert} = Intel471Ex.Reports.get_breach_alert("8c5e0e87e683c62bb0a50baeff732152")

# Search spot reports
{:ok, reports} = Intel471Ex.Reports.spot_reports(%{spotReport: "malware"})

# Search situation reports
{:ok, reports} = Intel471Ex.Reports.situation_reports(%{situationReport: "ransomware"})

# Search malware intelligence reports
{:ok, reports} = Intel471Ex.Reports.malware_reports(%{malwareFamily: "lokibot"})
```

### Credentials

```elixir
# Search credential sets
{:ok, result} = Intel471Ex.Credentials.search_credential_sets(%{text: "breach"})

# Stream credential sets
{:ok, result} = Intel471Ex.Credentials.stream_credential_sets(%{lastUpdatedFrom: 1656809200000})

# With cursor for pagination
cursor = result.cursor_next
{:ok, next_page} = Intel471Ex.Credentials.stream_credential_sets(%{
  lastUpdatedFrom: 1656809200000,
  cursor: cursor
})

# Search credentials
{:ok, creds} = Intel471Ex.Credentials.search_credentials(%{
  credentialDomain: "example.com",
  passwordStrength: "weak"
})

# Search credential occurrences
{:ok, occurrences} = Intel471Ex.Credentials.search_credential_occurrences(%{
  accessedUrl: "login.example.com"
})

# Search accessed URLs
{:ok, urls} = Intel471Ex.Credentials.search_credential_accessed_urls(%{
  domain: "example.com"
})
```

### Vulnerabilities

```elixir
# Search for CVEs
{:ok, vulns} = Intel471Ex.Vulnerabilities.cve_reports(%{
  productName: "Chrome",
  riskLevel: "high"
})

# Get a specific CVE
{:ok, cve} = Intel471Ex.Vulnerabilities.get_cve_report("d6ec93bf8fdf355f7b35a3bc2c15566b")

# Filter by patch status
{:ok, unpatchedCVEs} = Intel471Ex.Vulnerabilities.cve_reports(%{
  patchStatus: "unavailable",
  riskLevel: "high"
})
```

### IOCs

```elixir
# Search for Indicators of Compromise
{:ok, result} = Intel471Ex.IOCs.search(%{ioc: ".com"})

# Search by IOC type
{:ok, result} = Intel471Ex.IOCs.search(%{
  ioc: "192.168",
  iocType: "IPAddress"
})
```

### Search

```elixir
# Perform a global search across all data types
{:ok, result} = Intel471Ex.Search.search(%{text: "ransomware"})

# Search for specific entity types
{:ok, result} = Intel471Ex.Search.search(%{
  entityType: "EmailAddress",
  text: "admin@"
})

# Search by IP address
{:ok, result} = Intel471Ex.Search.search(%{ipAddress: "192.168.1.1"})

# Search by URL
{:ok, result} = Intel471Ex.Search.search(%{url: "malicious-site.com"})

# Combined search
{:ok, result} = Intel471Ex.Search.search(%{
  text: "ransomware",
  reportLocation: "United States",
  from: 1627776000000,
  until: 1627948800000
})
```

### Watchers

```elixir
# List watcher groups
{:ok, groups} = Intel471Ex.Watchers.list_groups()

# Create a new watcher group
{:ok, group} = Intel471Ex.Watchers.create_group(%{
  name: "Ransomware Monitoring",
  description: "Monitor for new ransomware threats"
})

# Get a specific watcher group
{:ok, group} = Intel471Ex.Watchers.list_groups("0bd66b73-c445-4b35-b3d4-742ed1e5a092")

# Create a free text search watcher
{:ok, watcher} = Intel471Ex.Watchers.create_watcher(
  "0bd66b73-c445-4b35-b3d4-742ed1e5a092",
  %{
    type: "search",
    description: "Monitor for ransomware mentions",
    patterns: [%{types: "FreeText", pattern: "ransomware"}],
    notificationChannel: "website",
    notificationFrequency: "immediately"
  }
)

# Create a specific search watcher
{:ok, watcher} = Intel471Ex.Watchers.create_watcher(
  "0bd66b73-c445-4b35-b3d4-742ed1e5a092",
  %{
    type: "search",
    description: "Monitor for actor mentions",
    patterns: [%{types: "Actor", pattern: "swisman"}],
    notificationChannel: "website",
    notificationFrequency: "immediately"
  }
)

# Delete a watcher
{:ok, _} = Intel471Ex.Watchers.delete_watcher(
  "0bd66b73-c445-4b35-b3d4-742ed1e5a092",
  "e1ada07bf9d0a14884844bcd85cd785a"
)
```

### Malware Intelligence

```elixir
# Search for events
{:ok, events} = Intel471Ex.Events.search(%{
  malwareFamily: "lokibot"
})

# Stream events
{:ok, stream} = Intel471Ex.Events.stream(%{
  lastUpdatedFrom: 1655809200000
})

# Get next page using cursor
cursor = stream.cursorNext
{:ok, next_page} = Intel471Ex.Events.stream(%{
  lastUpdatedFrom: 1655809200000,
  cursor: cursor
})

# Search for indicators
{:ok, indicators} = Intel471Ex.Indicators.search(%{
  indicatorType: "url",
  confidence: "high"
})

# Stream indicators
{:ok, stream} = Intel471Ex.Indicators.stream(%{
  lastUpdatedFrom: 1655809200000
})

# Search for YARA rules
{:ok, yara} = Intel471Ex.YARA.search(%{
  malwareFamily: "trickbot"
})
```

## Working with Streams

Many endpoints offer stream variants that use cursors for efficient pagination of large datasets:

```elixir
# Stream credential sets
{:ok, result} = Intel471Ex.Credentials.stream_credential_sets(%{
  lastUpdatedFrom: 1656809200000
})

# Process all pages
process_all_pages = fn fetch_fn, params ->
  # Initial request
  {:ok, response} = fetch_fn.(params)
  
  # Process first page
  process_items(response.credential_sets)
  
  # Continue with pagination using cursor
  fetch_next_page = fn
    nil, _acc -> :done
    cursor, acc ->
      case fetch_fn.(Map.put(params, :cursor, cursor)) do
        {:ok, %{credential_sets: [], cursor_next: _}} -> 
          acc
        {:ok, %{credential_sets: items, cursor_next: next_cursor}} ->
          process_items(items)
          fetch_next_page.(next_cursor, acc ++ items)
        _ -> 
          acc
      end
  end
  
  fetch_next_page.(response.cursor_next, response.credential_sets)
end

# Usage example
all_items = process_all_pages.(&Intel471Ex.Credentials.stream_credential_sets/1, %{
  lastUpdatedFrom: 1656809200000
})
```

## Error Handling

The API returns standard Elixir result tuples:

```elixir
case Intel471Ex.Actors.search(%{actor: "threat_actor"}) do
  {:ok, result} ->
    # Process successful result
    IO.puts("Found #{result["actorTotalCount"]} actors")
    
  {:error, %{status: status, message: message}} ->
    # Handle API error
    IO.puts("Error #{status}: #{message}")
    
  {:error, exception} ->
    # Handle other errors (network issues, etc.)
    IO.puts("Exception: #{inspect(exception)}")
end
```

## Advanced Examples

### Combining Multiple Search Parameters

```elixir
# Search for high-risk vulnerabilities affecting Chrome with no patch available
{:ok, vulns} = Intel471Ex.Vulnerabilities.cve_reports(%{
  productName: "Chrome",
  riskLevel: "high",
  patchStatus: "unavailable"
})

# Search for credential leaks from a specific domain in the last 30 days
{:ok, creds} = Intel471Ex.Credentials.search_credentials(%{
  credentialDomain: "example.com",
  from: "30days"
})

# Search for ransomware-related reports in a specific region
{:ok, reports} = Intel471Ex.Reports.search(%{
  report: "ransomware",
  reportLocation: "Germany"
})
```

### Working with Dates and Time Ranges

```elixir
# Using explicit timestamps (milliseconds since epoch)
{:ok, actors} = Intel471Ex.Actors.search(%{
  from: 1627776000000,  # July 31, 2021
  until: 1630454400000  # September 1, 2021
})

# Using relative time strings
{:ok, reports} = Intel471Ex.Reports.search(%{
  report: "vulnerability",
  from: "7days"  # Last 7 days
})

# Using both approaches in different parameters
{:ok, alerts} = Intel471Ex.Alerts.list(%{
  from: "24hours",
  lastUpdatedFrom: 1655809200000
})
```

### Filtering by GIR (General Intel Requirements)

```elixir
# Search for reports matching a specific GIR
{:ok, reports} = Intel471Ex.Reports.search(%{
  report: "malware",
  gir: "1.1.3"
})

# Filter by company PIRs (Prioritized Intel Requirements)
{:ok, reports} = Intel471Ex.Reports.search(%{
  report: "ransomware",
  filterByGirSet: "company_pirs"
})
```
