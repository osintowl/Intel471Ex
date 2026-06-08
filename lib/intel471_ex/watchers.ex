defmodule Intel471Ex.Watchers do
  @moduledoc """
  Functions for working with the Intel 471 Verity Watchers API.

  Service path: `integrations/watchers/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/watchers/v1"

  # --- Alerts ---

  @doc """
  Stream alerts triggered by watchers (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:cursor` / `:size` — Pagination
    - `:from` / `:until` — Time range
    - `:watcher_group_ids` — Filter by watcher group IDs
    - `:watcher_ids` — Filter by watcher IDs
    - `:statuses` — Filter by alert statuses
    - `:is_trashed_included` — Include trashed alerts

  ## Examples

      {:ok, result} = Intel471Ex.Watchers.alerts_stream(%{size: 10})
  """
  @spec alerts_stream(map()) :: {:ok, map()} | {:error, any()}
  def alerts_stream(params \\ %{}) do
    Client.get("#{@service_path}/alerts/stream", params)
  end

  @doc """
  Update the status of an alert.

  ## Parameters

  - `id`: The alert ID
  - `status`: New status (e.g., "read", "unread")

  ## Examples

      {:ok, _} = Intel471Ex.Watchers.update_alert_status(12345, "read")
  """
  @spec update_alert_status(integer(), String.t()) :: {:ok, map()} | {:error, any()}
  def update_alert_status(id, status) do
    Client.put("#{@service_path}/alerts/#{id}/#{status}", %{})
  end

  # --- Watcher Groups ---

  @doc """
  List or search watcher groups.

  ## Parameters

  - `params`: A map of query parameters
    - `:watcher_group_id` — Filter by group ID
    - `:watcher_group_type` — Filter by group type
    - `:name` — Filter by name

  ## Examples

      {:ok, result} = Intel471Ex.Watchers.watcher_groups()
      {:ok, result} = Intel471Ex.Watchers.watcher_groups(%{name: "Ransomware"})
  """
  @spec watcher_groups(map()) :: {:ok, map()} | {:error, any()}
  def watcher_groups(params \\ %{}) do
    Client.get("#{@service_path}/watcher-groups", params)
  end

  # --- Watchers ---

  @doc """
  List or search watchers.

  ## Parameters

  - `params`: A map of query parameters
    - `:watcher_id` — Filter by watcher ID
    - `:watcher_group_id` — Filter by watcher group ID
    - `:dsl_query` — Filter by DSL query
    - `:watcher_group_type` — Filter by watcher group type
    - `:name` — Filter by name

  ## Examples

      {:ok, result} = Intel471Ex.Watchers.watchers(%{watcher_group_id: "group-id"})
  """
  @spec watchers(map()) :: {:ok, map()} | {:error, any()}
  def watchers(params \\ %{}) do
    Client.get("#{@service_path}/watchers", params)
  end
end