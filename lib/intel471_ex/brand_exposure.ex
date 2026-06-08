defmodule Intel471Ex.BrandExposure do
  @moduledoc """
  Functions for working with the Intel 471 Verity Brand Exposure API.

  Service path: `integrations/brand-exposure/v1`

  Provides monitor CRUD, scan data endpoints, and configuration management.
  """

  alias Intel471Ex.Client

  @service_path "integrations/brand-exposure/v1"

  # --- Monitors ---

  @doc """
  List Brand Exposure monitors.

  ## Parameters

  - `params`: A map of query parameters
    - `:last_run_after` / `:last_run_before` — Filter by last run time

  ## Examples

      {:ok, monitors} = Intel471Ex.BrandExposure.list_monitors()
  """
  @spec list_monitors(map()) :: {:ok, map()} | {:error, any()}
  def list_monitors(params \\ %{}) do
    Client.get("#{@service_path}/monitor", params)
  end

  @doc """
  Create a Brand Exposure monitor.

  ## Parameters

  - `body`: Monitor creation request body
    - `:name` — Monitor name
    - `:targets` — List of target domains
    - `:labels` — List of labels
    - `:frequency` — Scan frequency
    - `:impact` — Impact level
    - Additional optional fields

  ## Examples

      {:ok, monitor} = Intel471Ex.BrandExposure.create_monitor(%{
        name: "example.com",
        targets: ["example.com"],
        labels: ["brand-monitor"],
        frequency: "daily",
        impact: "major"
      })
  """
  @spec create_monitor(map()) :: {:ok, map()} | {:error, any()}
  def create_monitor(body) do
    Client.post("#{@service_path}/monitor", body)
  end

  @doc """
  Get a Brand Exposure monitor by ID.

  ## Examples

      {:ok, monitor} = Intel471Ex.BrandExposure.get_monitor("monitor-id")
  """
  @spec get_monitor(String.t()) :: {:ok, map()} | {:error, any()}
  def get_monitor(id) do
    Client.get("#{@service_path}/monitor/#{id}")
  end

  @doc """
  Delete a Brand Exposure monitor by ID.

  ## Examples

      {:ok, _} = Intel471Ex.BrandExposure.delete_monitor("monitor-id")
  """
  @spec delete_monitor(String.t()) :: {:ok, map()} | {:error, any()}
  def delete_monitor(id) do
    Client.delete("#{@service_path}/monitor/#{id}")
  end

  @doc """
  Edit a Brand Exposure monitor.

  ## Parameters

  - `id`: Monitor ID
  - `body`: Updated monitor fields

  ## Examples

      {:ok, _} = Intel471Ex.BrandExposure.edit_monitor("monitor-id", %{name: "updated-name"})
  """
  @spec edit_monitor(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def edit_monitor(id, body) do
    Client.patch("#{@service_path}/monitor/#{id}", body)
  end

  @doc """
  Get monitor logs.

  ## Parameters

  - `id`: Monitor ID
  - `params`: Query parameters (`:limit`, `:log_type`, `:search_text`, `:cursor`, `:backward`)

  ## Examples

      {:ok, logs} = Intel471Ex.BrandExposure.get_monitor_logs("monitor-id")
      {:ok, logs} = Intel471Ex.BrandExposure.get_monitor_logs("monitor-id", %{limit: 50, log_type: "scan"})
  """
  @spec get_monitor_logs(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def get_monitor_logs(id, params \\ %{}) do
    Client.get("#{@service_path}/monitor/#{id}/logs", params)
  end

  @doc """
  Run a Brand Exposure monitor.

  ## Parameters

  - `id`: Monitor ID
  - `body`: Optional body with `:at` timestamp

  ## Examples

      {:ok, _} = Intel471Ex.BrandExposure.run_monitor("monitor-id")
      {:ok, _} = Intel471Ex.BrandExposure.run_monitor("monitor-id", %{at: "2026-01-01T00:00:00Z"})
  """
  @spec run_monitor(String.t(), map() | nil) :: {:ok, map()} | {:error, any()}
  def run_monitor(id, body \\ nil) do
    if body do
      Client.post("#{@service_path}/monitor/#{id}/run", body)
    else
      Client.post("#{@service_path}/monitor/#{id}/run", %{})
    end
  end

  @doc """
  Get scans for a Brand Exposure monitor.

  ## Parameters

  - `id`: Monitor ID
  - `params`: Query parameters (`:status` filter)

  ## Examples

      {:ok, scans} = Intel471Ex.BrandExposure.get_monitor_scans("monitor-id")
      {:ok, scans} = Intel471Ex.BrandExposure.get_monitor_scans("monitor-id", %{status: "completed"})
  """
  @spec get_monitor_scans(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def get_monitor_scans(id, params \\ %{}) do
    Client.get("#{@service_path}/monitor/#{id}/scans", params)
  end

  # --- Scan Data ---

  @doc """
  Get scan data for a Brand Exposure scan.

  ## Parameters

  - `scan_id`: Scan ID
  - `params`: Query parameters (`:category`, `:type`, `:source`, `:annotated`,
    `:starred`, `:text`, `:sort`, `:descending`, `:limit`, `:cursor`, `:backward`)

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, data} = Intel471Ex.BrandExposure.get_scan_data("scan-id")
      {:ok, data} = Intel471Ex.BrandExposure.get_scan_data("scan-id", %{category: "domain", limit: 50})
  """
  @spec get_scan_data(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def get_scan_data(scan_id, params \\ %{}) do
    Client.get("#{@service_path}/scan/#{scan_id}/data", params)
  end

  @doc """
  Get scan data graph for a Brand Exposure scan.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, graph} = Intel471Ex.BrandExposure.get_scan_data_graph("scan-id")
  """
  @spec get_scan_data_graph(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def get_scan_data_graph(scan_id, params \\ %{}) do
    Client.get("#{@service_path}/scan/#{scan_id}/data-graph", params)
  end

  @doc """
  Get scan data tree for a Brand Exposure scan.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, tree} = Intel471Ex.BrandExposure.get_scan_data_tree("scan-id")
  """
  @spec get_scan_data_tree(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def get_scan_data_tree(scan_id, params \\ %{}) do
    Client.get("#{@service_path}/scan/#{scan_id}/data-tree", params)
  end

  @doc """
  Get a specific scan data element.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, element} = Intel471Ex.BrandExposure.get_scan_data_element("scan-id", "element-id")
  """
  @spec get_scan_data_element(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get_scan_data_element(scan_id, element_id) do
    Client.get("#{@service_path}/scan/#{scan_id}/data/#{element_id}")
  end

  @doc """
  Patch a scan data element.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, _} = Intel471Ex.BrandExposure.patch_scan_data_element("scan-id", "element-id", %{starred: true})
  """
  @spec patch_scan_data_element(String.t(), String.t(), map()) :: {:ok, map()} | {:error, any()}
  def patch_scan_data_element(scan_id, element_id, body) do
    Client.patch("#{@service_path}/scan/#{scan_id}/data/#{element_id}", body)
  end

  @doc """
  Get children of a scan data element.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, children} = Intel471Ex.BrandExposure.get_scan_data_element_children("scan-id", "element-id")
  """
  @spec get_scan_data_element_children(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get_scan_data_element_children(scan_id, element_id) do
    Client.get("#{@service_path}/scan/#{scan_id}/data/#{element_id}/children")
  end

  @doc """
  Get discovery data for a scan data element.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, discovery} = Intel471Ex.BrandExposure.get_scan_data_element_discovery("scan-id", "element-id")
  """
  @spec get_scan_data_element_discovery(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get_scan_data_element_discovery(scan_id, element_id) do
    Client.get("#{@service_path}/scan/#{scan_id}/data/#{element_id}/discovery")
  end

  @doc """
  Get events for a scan data element.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, events} = Intel471Ex.BrandExposure.get_scan_data_element_events("scan-id", "element-id")
  """
  @spec get_scan_data_element_events(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get_scan_data_element_events(scan_id, element_id) do
    Client.get("#{@service_path}/scan/#{scan_id}/data/#{element_id}/events")
  end

  @doc """
  Get relationships for a scan data element.

  **Deprecated in the Brand Exposure API.**

  ## Examples

      {:ok, rels} = Intel471Ex.BrandExposure.get_scan_data_element_relationships("scan-id", "element-id")
  """
  @spec get_scan_data_element_relationships(String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get_scan_data_element_relationships(scan_id, element_id) do
    Client.get("#{@service_path}/scan/#{scan_id}/data/#{element_id}/relationships")
  end

  # --- Configuration ---

  @doc """
  Get the current configuration for a section.

  ## Examples

      {:ok, config} = Intel471Ex.BrandExposure.get_config_current("general")
  """
  @spec get_config_current(String.t()) :: {:ok, map()} | {:error, any()}
  def get_config_current(section) do
    Client.get("#{@service_path}/config/current/#{section}")
  end

  @doc """
  Get the default configuration for a section.

  ## Examples

      {:ok, defaults} = Intel471Ex.BrandExposure.get_config_defaults("general")
  """
  @spec get_config_defaults(String.t()) :: {:ok, map()} | {:error, any()}
  def get_config_defaults(section) do
    Client.get("#{@service_path}/config/defaults/#{section}")
  end

  @doc """
  Get the configuration schema.

  ## Examples

      {:ok, schema} = Intel471Ex.BrandExposure.get_config_schema()
  """
  @spec get_config_schema() :: {:ok, map()} | {:error, any()}
  def get_config_schema do
    Client.get("#{@service_path}/config/schema")
  end

  @doc """
  Get the user configuration for a section.

  ## Examples

      {:ok, user_config} = Intel471Ex.BrandExposure.get_config_user("general")
  """
  @spec get_config_user(String.t()) :: {:ok, map()} | {:error, any()}
  def get_config_user(section) do
    Client.get("#{@service_path}/config/user/#{section}")
  end

  @doc """
  Update the user configuration for a section.

  ## Examples

      {:ok, _} = Intel471Ex.BrandExposure.put_config_user("general", %{key: "value"})
  """
  @spec put_config_user(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def put_config_user(section, config) do
    Client.put("#{@service_path}/config/user/#{section}", config)
  end
end