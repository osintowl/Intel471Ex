# Intel471Ex

An Elixir client library for Intel 471's Verity API providing access to cyber threat intelligence.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [API Coverage](#api-coverage)
- [API Examples](#api-examples)
  - [Actors](#actors)
  - [Reports](#reports)
  - [Credentials](#credentials)
  - [Watchers](#watchers)
  - [Entities](#entities)
  - [Indicators](#indicators)
  - [Malware Intel](#malware-intel)
  - [Observables](#observables)
  - [GIRS](#girs)
  - [Sources](#sources)
  - [ASE](#ase)
  - [Brand Exposure](#brand-exposure)
  - [TPRM](#tprm)
- [File Downloads](#file-downloads)
- [Error Handling](#error-handling)

## Installation

Add `intel471_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:intel471_ex, "~> 0.2.0"}
  ]
end
```

## Configuration

This library uses system environment variables for authentication. Create an application in the [Verity Developer Portal](https://verity.intel471.com) to obtain a client ID and client secret:

```
# Required
VERITY_CLIENT_ID=your-verity-client-id
VERITY_CLIENT_SECRET=your-verity-client-secret

# Optional
VERITY_API_URL=https://api.intel471.cloud  # Default API URL
```

Set them in your application:

```elixir
System.put_env("VERITY_CLIENT_ID", "your-client-id")
System.put_env("VERITY_CLIENT_SECRET", "your-client-secret")
```

## API Coverage

| Service | Module | Key Functions |
|---------|--------|--------------|
| Actors | `Intel471Ex.Actors` | `stream` |
| ASE | `Intel471Ex.Ase` | `list_monitors` |
| Brand Exposure | `Intel471Ex.BrandExposure` | Monitor CRUD, scan data, config |
| Credentials | `Intel471Ex.Credentials` | Credential/set/occurrence streams and lookups |
| Entities | `Intel471Ex.Entities` | `stream` |
| GIRS | `Intel471Ex.Girs` | `tree` |
| Indicators | `Intel471Ex.Indicators` | `stream`, `get_by_id` |
| Malware Intel | `Intel471Ex.Malware` | `events_stream`, `list_malware`, `get_malware_family`, `download_file` |
| Observables | `Intel471Ex.Observables` | `stream` |
| Reports | `Intel471Ex.Reports` | Stream/detail for FINTel, Breach Alert, Geopol, Info, Spot, Malware, Vulnerability |
| Sources | `Intel471Ex.Sources` | Stream/detail for data-leak-site posts, forum posts/messages, chat messages |
| TPRM | `Intel471Ex.Tprm` | Monitor CRUD, scan data, config |
| Watchers | `Intel471Ex.Watchers` | `alerts_stream`, `update_alert_status`, `watcher_groups`, `watchers` |

## API Examples

### Actors

```elixir
# Stream actors matching a search term
{:ok, result} = Intel471Ex.Actors.stream(%{actor: "lazarus", size: 10})
IO.puts("Found #{result["count"]} actors")

# Stream with pagination
{:ok, page1} = Intel471Ex.Actors.stream(%{actor: "conti", size: 5})
cursor = page1["cursor_next"]
{:ok, page2} = Intel471Ex.Actors.stream(%{actor: "conti", size: 5, cursor: cursor})

# Filter by server type
{:ok, result} = Intel471Ex.Actors.stream(%{actor: "conti", server_type: "telegram"})
```

### Reports

```elixir
# Stream all report types
{:ok, result} = Intel471Ex.Reports.stream(%{text_filter: "ransomware", size: 10})

# FINTel reports
{:ok, result} = Intel471Ex.Reports.fintel_stream(%{text_filter: "malware"})
{:ok, report} = Intel471Ex.Reports.fintel_detail("report-id")

# Breach alerts
{:ok, result} = Intel471Ex.Reports.breach_alert_stream(%{text_filter: "Communications"})
{:ok, alert} = Intel471Ex.Reports.breach_alert_detail("alert-id")

# Geopolitical reports
{:ok, result} = Intel471Ex.Reports.geopol_stream(%{country: "US"})
{:ok, report} = Intel471Ex.Reports.geopol_detail("report-id")

# Info reports
{:ok, result} = Intel471Ex.Reports.info_stream(%{text_filter: "vulnerability"})

# Malware reports
{:ok, result} = Intel471Ex.Reports.malware_stream(%{malware_family: "lokibot"})

# Spot reports
{:ok, result} = Intel471Ex.Reports.spot_stream(%{text_filter: "phishing"})

# Vulnerability reports
{:ok, result} = Intel471Ex.Reports.vulnerability_stream(%{cve_name: "CVE-2024-1234"})
{:ok, vuln} = Intel471Ex.Reports.vulnerability_detail("vuln-id")

# Download vulnerability report as PDF
{:ok, %{body: pdf_data}} = Intel471Ex.Reports.vulnerability_download_pdf("vuln-id")
```

### Credentials

```elixir
# Stream credentials
{:ok, result} = Intel471Ex.Credentials.credential_stream(%{domain: "example.com", size: 10})
{:ok, credential} = Intel471Ex.Credentials.get_credential("credential-id")

# Credential occurrences
{:ok, result} = Intel471Ex.Credentials.credential_occurrence_stream(%{credential_id: "id"})
{:ok, occurrence} = Intel471Ex.Credentials.get_credential_occurrence("occurrence-id")

# Credential sets
{:ok, result} = Intel471Ex.Credentials.credential_set_stream(%{victim: "example.com"})
{:ok, set} = Intel471Ex.Credentials.get_credential_set("set-id")

# Accessed URLs
{:ok, result} = Intel471Ex.Credentials.credential_set_accessed_url_stream(%{credential_set_id: "id"})
```

### Watchers

```elixir
# Stream alerts
{:ok, result} = Intel471Ex.Watchers.alerts_stream(%{size: 10})

# Update alert status
{:ok, _} = Intel471Ex.Watchers.update_alert_status(12345, "read")

# List watcher groups
{:ok, result} = Intel471Ex.Watchers.watcher_groups()

# List watchers
{:ok, result} = Intel471Ex.Watchers.watchers(%{watcher_group_id: "group-id"})
```

### Entities

```elixir
# Stream entities
{:ok, result} = Intel471Ex.Entities.stream(%{entity: "intel.com", size: 10})
```

### Indicators

```elixir
# Stream indicators
{:ok, result} = Intel471Ex.Indicators.stream(%{type: "domain", size: 10})

# Get indicator by ID
{:ok, indicator} = Intel471Ex.Indicators.get_by_id("indicator-id")
```

### Malware Intel

```elixir
# Stream malware events
{:ok, result} = Intel471Ex.Malware.events_stream(%{malware_family_name: "lokibot", size: 10})
{:ok, event} = Intel471Ex.Malware.get_event("event-id")

# List malware families
{:ok, result} = Intel471Ex.Malware.list_malware(%{text_filter: "trickbot"})

# Get malware family detail
{:ok, family} = Intel471Ex.Malware.get_malware_family("family-id")

# Download malware file
{:ok, %{body: file_data}} = Intel471Ex.Malware.download_file("filename.exe")
```

### Observables

```elixir
# Stream observables
{:ok, result} = Intel471Ex.Observables.stream(%{observable: "8.8.8.8", size: 10})
```

### GIRS

```elixir
# Get the GIRS tree
{:ok, tree} = Intel471Ex.Girs.tree()
IO.puts("Found #{tree["count"]} GIR entries")
```

### Sources

```elixir
# Data leak site posts
{:ok, result} = Intel471Ex.Sources.data_leak_site_posts_stream(%{text_filter: "ransomware"})

# Forum posts
{:ok, result} = Intel471Ex.Sources.forums_posts_stream(%{author: "username"})
{:ok, post} = Intel471Ex.Sources.get_forum_post("post-id")

# Forum private messages
{:ok, result} = Intel471Ex.Sources.forums_private_messages_stream(%{author: "username"})

# Chat messages
{:ok, result} = Intel471Ex.Sources.chat_messages_stream(%{server_type: "telegram"})

# Get an image
{:ok, %{body: image_data}} = Intel471Ex.Sources.get_image("forum", "hash", "image.png")
```

### ASE

```elixir
# List ASE monitors
{:ok, monitors} = Intel471Ex.Ase.list_monitors()
```

### Brand Exposure

```elixir
# Monitor CRUD
{:ok, monitors} = Intel471Ex.BrandExposure.list_monitors()
{:ok, monitor} = Intel471Ex.BrandExposure.create_monitor(%{
  name: "example.com",
  targets: ["example.com"],
  labels: ["brand-monitor"],
  frequency: "daily",
  impact: "major"
})
{:ok, monitor} = Intel471Ex.BrandExposure.get_monitor("monitor-id")
{:ok, _} = Intel471Ex.BrandExposure.delete_monitor("monitor-id")

# Configuration
{:ok, config} = Intel471Ex.BrandExposure.get_config_current("base")
{:ok, schema} = Intel471Ex.BrandExposure.get_config_schema()
```

### TPRM

```elixir
# Monitor CRUD
{:ok, monitors} = Intel471Ex.Tprm.list_monitors()
{:ok, monitor} = Intel471Ex.Tprm.create_monitor(%{
  name: "vendor.com",
  targets: ["vendor.com"],
  collection_method: "passive"
})

# Configuration (uses Bearer token for writes)
{:ok, config} = Intel471Ex.Tprm.get_config_current("base")
{:ok, _} = Intel471Ex.Tprm.put_config_user("base", %{"key" => "value"}, "bearer-token")
```

## File Downloads

```elixir
# Download a file to a specific path
{:ok, path} = Intel471Ex.Downloader.download_file(
  "https://api.intel471.cloud/integrations/malware-intel/v1/malware/files/sample/download",
  "/tmp/malware_sample.zip"
)

# Auto-extract filename from URL
{:ok, path} = Intel471Ex.Downloader.download_file_auto(
  "https://api.intel471.cloud/integrations/sources/v1/data-leak-sites/file-listings/123",
  "downloads"
)
```

## Error Handling

```elixir
case Intel471Ex.Actors.stream(%{actor: "test"}) do
  {:ok, result} ->
    IO.puts("Found #{result["count"]} actors")

  {:error, %{status: status, message: message}} ->
    IO.puts("API error #{status}: #{message}")

  {:error, exception} ->
    IO.puts("Network error: #{inspect(exception)}")
end
```

## Migration from v0.1.x (Titan API)

This version (0.2.0) is a breaking change. Key migration steps:

1. **Environment variables**: Replace `INTEL471_USERNAME`/`INTEL471_API_KEY` with `VERITY_CLIENT_ID`/`VERITY_CLIENT_SECRET`
2. **API URL**: Default changed from `https://api.intel471.com/v1` to `https://api.intel471.cloud`
3. **Removed modules**: `Intel471Ex.Alerts`, `Intel471Ex.Search`, `Intel471Ex.Vulnerabilities`
4. **New modules**: `Entities`, `Indicators`, `Malware`, `Observables`, `Girs`, `Sources`, `Ase`, `BrandExposure`, `Tprm`
5. **API style**: All endpoints now use cursor-based streaming instead of offset/count pagination
