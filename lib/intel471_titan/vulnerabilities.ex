# lib/intel471_titan/vulnerabilities.ex
defmodule Intel471Ex.Vulnerabilities do
  @moduledoc """
  Functions for working with the Vulnerabilities API endpoints.
  """
  
  alias Intel471Ex.Client
  
  @doc """
  Search vulnerability reports (CVEs) using filter criteria.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering CVE reports
    - `:cveReport` - Free text CVE reports search
    - `:cveType` - Search CVE reports by type
    - `:cveStatus` - Search CVE reports by status
    - `:cveName` - Search CVE reports by name
    - `:riskLevel` - Search CVE reports by risk level (high, medium, low)
    - `:patchStatus` - Search CVE reports by patch status
    - `:vendorName` - Search CVE reports by vendor name
    - `:productName` - Search CVE reports by product name
  """
  @spec cve_reports( map()) :: {:ok, map()} | {:error, any()}
  def cve_reports(params) do
    Client.request(:get, "/cve/reports", params)
  end
  
  @doc """
  Get a CVE report by UID.
  
  ## Parameters
  
  - `config`: A Intel471Ex.Config struct with authentication details
  - `uid`: The unique identifier of the CVE report
  """
  @spec get_cve_report(String.t()) :: {:ok, map()} | {:error, any()}
  def get_cve_report(uid) do
    Client.request(:get, "/cve/reports/#{uid}")
  end
end
