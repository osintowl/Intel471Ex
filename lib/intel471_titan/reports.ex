defmodule Intel471Ex.Reports do
  @moduledoc """
  Functions for working with various report types from the Intel 471 Titan API.
  """
  
  alias Intel471Ex.Client
  
  @doc """
  Search information reports using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering reports
    - `:report` - Search text in reports, subjects, and entities
    - `:reportLocation` - Search reports by country or region
    - `:reportTag` - Search reports by tag
    - `:reportTitle` - Search reports by title
    - `:victim` - Search reports by purported victim
    - `:documentType` - Search reports by document type
    - `:gir` - Search by General Intel Requirements
    - `:from` - Search data starting from given creation time
    - `:until` - Search data ending before given creation time
  
  ## Examples
  
      iex> Intel471Ex.Reports.search(%{report: "ransomware"})
      {:ok, %{"reportTotalCount" => 28, "reports" => [...]}}
  """
  @spec search(map()) :: {:ok, map()} | {:error, any()}
  def search(params \\ %{}) do
    Client.request(:get, "/reports", params)
  end
  
  @doc """
  Get a single report by UID.
  
  ## Parameters
  
  - `uid`: The unique identifier of the report
  
  ## Examples
  
      iex> Intel471Ex.Reports.get("32537c9c6dce18ce6ea4d5106540f089")
      {:ok, %{...}}
  """
  @spec get(String.t()) :: {:ok, map()} | {:error, any()}
  def get(uid) do
    Client.request(:get, "/reports/#{uid}")
  end
  
  @doc """
  Search breach alerts using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering breach alerts
    - `:breachAlert` - Free text reports search
    - `:actor` - Search by actor or actor group names
    - `:victim` - Search by victim
    - `:confidence` - Search by confidence level
  
  ## Examples
  
      iex> Intel471Ex.Reports.breach_alerts(%{breachAlert: "Communications"})
      {:ok, %{"breach_alerts_total_count" => 2337, "breach_alerts" => [...]}}
  """
  @spec breach_alerts(map()) :: {:ok, map()} | {:error, any()}
  def breach_alerts(params \\ %{}) do
    Client.request(:get, "/breachAlerts", params)
  end
  
  @doc """
  Get a breach alert by UID.
  
  ## Parameters
  
  - `uid`: The unique identifier of the breach alert
  
  ## Examples
  
      iex> Intel471Ex.Reports.get_breach_alert("8c5e0e87e683c62bb0a50baeff732152")
      {:ok, %{...}}
  """
  @spec get_breach_alert(String.t()) :: {:ok, map()} | {:error, any()}
  def get_breach_alert(uid) do
    Client.request(:get, "/breachAlerts/#{uid}")
  end
  
  @doc """
  Search spot reports using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering spot reports
    - `:spotReport` - Free text reports search
    - `:victim` - Search by purported victim
    - `:gir` - Search by General Intel Requirements
  
  ## Examples
  
      iex> Intel471Ex.Reports.spot_reports(%{spotReport: "malware"})
      {:ok, %{"spotReportsTotalCount" => 123, "spotReports" => [...]}}
  """
  @spec spot_reports(map()) :: {:ok, map()} | {:error, any()}
  def spot_reports(params \\ %{}) do
    Client.request(:get, "/spotReports", params)
  end
  
  @doc """
  Search situation reports using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering situation reports
    - `:situationReport` - Free text reports search
    - `:victim` - Search by purported victim
    - `:gir` - Search by General Intel Requirements
  
  ## Examples
  
      iex> Intel471Ex.Reports.situation_reports(%{situationReport: "malware"})
      {:ok, %{"situationReportsTotalCount" => 11, "situationReports" => [...]}}
  """
  @spec situation_reports(map()) :: {:ok, map()} | {:error, any()}
  def situation_reports(params \\ %{}) do
    Client.request(:get, "/situationReports", params)
  end

  @doc """
  Search malware intelligence reports.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering malware reports
    - `:malwareReport` - Free text malware reports search
    - `:threatType` - Search by threat type
    - `:malwareFamily` - Search by malware family
  
  ## Examples
  
      iex> Intel471Ex.Reports.malware_reports(%{malwareFamily: "lokibot"})
      {:ok, %{"malwareReportTotalCount" => 52, "malwareReports" => [...]}}
  """
  @spec malware_reports(map()) :: {:ok, map()} | {:error, any()}
  def malware_reports(params \\ %{}) do
    Client.request(:get, "/malwareReports", params)
  end
end

