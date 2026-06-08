defmodule Intel471Ex.Reports do
  @moduledoc """
  Functions for working with the Intel 471 Verity Reports API.

  Service path: `integrations/intel-report/v1`

  Covers: general reports, FINTel, breach alerts, geopolitical reports,
  info reports, malware reports, spot reports, and vulnerability reports.
  """

  alias Intel471Ex.Client

  @service_path "integrations/intel-report/v1"

  # --- General Reports ---

  @doc """
  Stream reports matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:text_filter` — Free text search
    - `:girs` — Filter by General Intel Requirements
    - `:type` — Report type(s), comma-separated
    - `:sub_type` — Report sub-type(s), comma-separated
    - `:from` — Search data starting from given timestamp
    - `:until` — Search data ending before given timestamp
    - `:size` — Number of records per page
    - `:cursor` — Continue from cursor for pagination

  ## Examples

      {:ok, result} = Intel471Ex.Reports.stream(%{text_filter: "ransomware", size: 10})
  """
  @spec stream(map()) :: {:ok, map()} | {:error, any()}
  def stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/stream", params)
  end

  # --- FINTel Reports ---

  @doc """
  Stream FINTel reports matching filter criteria.

  ## Parameters

  - `params`: A map of query parameters
    - `:text_filter` — Free text search
    - `:girs` — Filter by GIRs
    - `:sub_type` — Report sub-type(s), comma-separated
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Reports.fintel_stream(%{text_filter: "malware", size: 10})
  """
  @spec fintel_stream(map()) :: {:ok, map()} | {:error, any()}
  def fintel_stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/fintel/stream", params)
  end

  @doc """
  Get a FINTel report by ID.

  ## Parameters

  - `id`: The report identifier
  - `params`: Optional params (e.g., `%{include_inline_images: true}`)

  ## Examples

      {:ok, report} = Intel471Ex.Reports.fintel_detail("report-id")
  """
  @spec fintel_detail(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def fintel_detail(id, params \\ %{}) do
    Client.get("#{@service_path}/reports/fintel/#{id}", params)
  end

  @doc """
  Download a FINTel report attachment (raw binary).

  ## Parameters

  - `report_id`: The report identifier
  - `attachment_id`: The attachment identifier

  ## Examples

      {:ok, %{body: data}} = Intel471Ex.Reports.fintel_attachment("report-id", "attachment-id")
  """
  @spec fintel_attachment(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def fintel_attachment(report_id, attachment_id) do
    Client.get_raw("#{@service_path}/reports/fintel/#{report_id}/attachments/#{attachment_id}")
  end

  # --- Breach Alerts ---

  @doc """
  Stream breach alert reports matching filter criteria.

  ## Parameters

  - `params`: A map of query parameters
    - `:text_filter` — Free text search
    - `:girs` — Filter by GIRs
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Reports.breach_alert_stream(%{size: 10})
  """
  @spec breach_alert_stream(map()) :: {:ok, map()} | {:error, any()}
  def breach_alert_stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/breach-alert/stream", params)
  end

  @doc """
  Get a breach alert report by ID.

  ## Parameters

  - `id`: The breach alert identifier
  - `params`: Optional params (e.g., `%{include_inline_images: true}`)

  ## Examples

      {:ok, report} = Intel471Ex.Reports.breach_alert_detail("report-id")
  """
  @spec breach_alert_detail(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def breach_alert_detail(id, params \\ %{}) do
    Client.get("#{@service_path}/reports/breach-alert/#{id}", params)
  end

  # --- Geopolitical Reports ---

  @doc """
  Stream geopolitical reports matching filter criteria.

  ## Parameters

  - `params`: A map of query parameters
    - `:country` — Filter by country
    - `:report_location_country` — Filter by report location country
    - `:text_filter` — Free text search
    - `:girs` — Filter by GIRs
    - `:sub_type` — Report sub-type(s), comma-separated
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Reports.geopol_stream(%{country: "US", size: 10})
  """
  @spec geopol_stream(map()) :: {:ok, map()} | {:error, any()}
  def geopol_stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/geopol/stream", params)
  end

  @doc """
  Get a geopolitical report by ID.

  ## Examples

      {:ok, report} = Intel471Ex.Reports.geopol_detail("report-id")
  """
  @spec geopol_detail(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def geopol_detail(id, params \\ %{}) do
    Client.get("#{@service_path}/reports/geopol/#{id}", params)
  end

  @doc """
  Download a geopolitical report attachment (raw binary).

  ## Examples

      {:ok, %{body: data}} = Intel471Ex.Reports.geopol_attachment("report-id", "attachment-id")
  """
  @spec geopol_attachment(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def geopol_attachment(report_id, attachment_id) do
    Client.get_raw("#{@service_path}/reports/geopol/#{report_id}/attachments/#{attachment_id}")
  end

  # --- Info Reports ---

  @doc """
  Stream info reports matching filter criteria.

  ## Parameters

  - `params`: A map of query parameters
    - `:text_filter` / `:girs` / `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Reports.info_stream(%{text_filter: "campaign", size: 10})
  """
  @spec info_stream(map()) :: {:ok, map()} | {:error, any()}
  def info_stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/info/stream", params)
  end

  @doc """
  Get an info report by ID.

  ## Examples

      {:ok, report} = Intel471Ex.Reports.info_detail("report-id")
  """
  @spec info_detail(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def info_detail(id, params \\ %{}) do
    Client.get("#{@service_path}/reports/info/#{id}", params)
  end

  @doc """
  Download an info report attachment (raw binary).

  ## Examples

      {:ok, %{body: data}} = Intel471Ex.Reports.info_attachment("report-id", "attachment-id")
  """
  @spec info_attachment(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def info_attachment(report_id, attachment_id) do
    Client.get_raw("#{@service_path}/reports/info/#{report_id}/attachments/#{attachment_id}")
  end

  # --- Malware Reports ---

  @doc """
  Stream malware reports matching filter criteria.

  ## Parameters

  - `params`: A map of query parameters
    - `:malware_family` — Filter by malware family
    - `:threat_id` — Filter by threat ID
    - `:threat_type` — Filter by threat type
    - `:text_filter` / `:girs` / `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Reports.malware_stream(%{malware_family: "conti", size: 10})
  """
  @spec malware_stream(map()) :: {:ok, map()} | {:error, any()}
  def malware_stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/malware/stream", params)
  end

  @doc """
  Get a malware report by ID.

  ## Examples

      {:ok, report} = Intel471Ex.Reports.malware_detail("report-id")
  """
  @spec malware_detail(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def malware_detail(id, params \\ %{}) do
    Client.get("#{@service_path}/reports/malware/#{id}", params)
  end

  @doc """
  Download a malware report attachment (raw binary).

  ## Examples

      {:ok, %{body: data}} = Intel471Ex.Reports.malware_attachment("report-id", "attachment-id")
  """
  @spec malware_attachment(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def malware_attachment(report_id, attachment_id) do
    Client.get_raw("#{@service_path}/reports/malware/#{report_id}/attachments/#{attachment_id}")
  end

  # --- Spot Reports ---

  @doc """
  Stream spot reports matching filter criteria.

  ## Parameters

  - `params`: A map of query parameters
    - `:text_filter` / `:girs` / `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Reports.spot_stream(%{text_filter: "incident", size: 10})
  """
  @spec spot_stream(map()) :: {:ok, map()} | {:error, any()}
  def spot_stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/spot/stream", params)
  end

  @doc """
  Get a spot report by ID.

  ## Examples

      {:ok, report} = Intel471Ex.Reports.spot_detail("report-id")
  """
  @spec spot_detail(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def spot_detail(id, params \\ %{}) do
    Client.get("#{@service_path}/reports/spot/#{id}", params)
  end

  # --- Vulnerability Reports ---

  @doc """
  Stream vulnerability reports matching filter criteria.

  ## Parameters

  - `params`: A map of query parameters
    - `:status` — Filter by status
    - `:text_filter` — Free text search
    - `:girs` — Filter by GIRs
    - `:cve_type` — Filter by CVE type
    - `:cve_name` — Filter by CVE name
    - `:vendor_name` — Filter by vendor name
    - `:product_name` — Filter by product name
    - `:risk_level` — Risk level(s), comma-separated
    - `:patch_status` — Patch status(es), comma-separated
    - `:interest_level` — Interest level(s), comma-separated
    - `:activity_location` — Activity location(s), comma-separated
    - `:exploit_status` — Exploit status(es), comma-separated
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Reports.vulnerability_stream(%{cve_name: "CVE-2026-1234", size: 10})
  """
  @spec vulnerability_stream(map()) :: {:ok, map()} | {:error, any()}
  def vulnerability_stream(params \\ %{}) do
    Client.get("#{@service_path}/reports/vulnerability/stream", params)
  end

  @doc """
  Get a vulnerability report by ID.

  ## Examples

      {:ok, report} = Intel471Ex.Reports.vulnerability_detail("report-id")
  """
  @spec vulnerability_detail(String.t()) :: {:ok, map()} | {:error, any()}
  def vulnerability_detail(id) do
    Client.get("#{@service_path}/reports/vulnerability/#{id}")
  end

  @doc """
  Download a vulnerability report as PDF (raw binary).

  ## Examples

      {:ok, %{body: pdf}} = Intel471Ex.Reports.vulnerability_download_pdf("report-id")
  """
  @spec vulnerability_download_pdf(String.t()) :: {:ok, map()} | {:error, any()}
  def vulnerability_download_pdf(id) do
    Client.get_raw("#{@service_path}/reports/vulnerability/#{id}/download-as-pdf")
  end

  @doc """
  Download any report as PDF (raw binary).

  ## Examples

      {:ok, %{body: pdf}} = Intel471Ex.Reports.download_pdf("report-id")
  """
  @spec download_pdf(String.t()) :: {:ok, map()} | {:error, any()}
  def download_pdf(id) do
    Client.get_raw("#{@service_path}/reports/#{id}/download-as-pdf")
  end
end