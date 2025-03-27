defmodule Intel471Ex.Alerts do
  @moduledoc """
  Functions for working with the Intel 471 Titan Alerts API.
  """
  
  alias Intel471Ex.Client
  
  @doc """
  Get alerts triggered by user-defined watchers.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering alerts
    - `:from` - Search data starting from given creation time
    - `:until` - Search data ending before given creation time
    - `:count` - Returns given number of records
    - `:offset` - UID of the latest already acquired alert
    - `:watcherGroup` - Show alerts from specified watcher group only
    - `:showRead` - Show read alerts (default: true)
    - `:displayWatchers` - Show watcher groups info (default: false)
    - `:markAsRead` - Mark displayed alerts as read (default: false)
    - `:sort` - Sort results (earliest, latest)
  
  ## Examples
  
      iex> Intel471Ex.Alerts.list(%{count: 10})
      {:ok, %{"alertTotalCount" => 613, "alerts" => [...]}}
  """
  @spec list(map()) :: {:ok, map()} | {:error, any()}
  def list(params \\ %{}) do
    Client.request(:get, "/alerts", params)
  end
end

