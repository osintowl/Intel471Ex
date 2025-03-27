defmodule Intel471Ex.Watchers do
  @moduledoc """
  Functions for working with Watcher Groups API endpoints in the Intel 471 Titan API.
  """
  
  alias Intel471Ex.Client
  
  @doc """
  Get a list of watcher groups.
  
  ## Parameters
  
  - `params`: A map of query parameters for filtering watcher groups
    - `:section` - Shows watcher groups from defined section (myGroups, sharedWithMe, sharedByIntel471)
  
  ## Examples
  
      iex> Intel471Ex.Watchers.list_groups()
      {:ok, %{"watcherGroupTotalCount" => 3, "watcherGroups" => [...]}}
  """
  @spec list_groups(map()) :: {:ok, map()} | {:error, any()}
  def list_groups(params \\ %{}) do
    Client.request(:get, "/watcherGroups", params)
  end
  
  @doc """
  Create a new watcher group.
  
  ## Parameters
  
  - `body`: A map containing the watcher group details
    - `:name` - Name of the Watcher Group
    - `:description` - Description of the Watcher Group
  
  ## Examples
  
      iex> body = %{name: "Early Warning Watchers", description: "This watcher group consists mainly of..."}
      iex> Intel471Ex.Watchers.create_group(body)
      {:ok, %{"name" => "Early Warning Watchers", "uid" => "0bd66b73-c445-4b35-b3d4-742ed1e5a092", ...}}
  """
  @spec create_group(map()) :: {:ok, map()} | {:error, any()}
  def create_group(body) do
    Client.request(:post, "/watcherGroups", %{}, body)
  end
  
  @doc """
  Create a new watcher in a watcher group.
  
  ## Parameters
  
  - `group_uid`: The unique identifier of the watcher group
  - `body`: A map containing the watcher details
    - `:description` - Watcher description
    - `:type` - Watcher type (search or thread)
    - `:patterns` - Search patterns for search watcher
    - `:notificationChannel` - Notification channel
    - `:notificationFrequency` - Notification frequency
  
  ## Examples
  
      iex> body = %{
      ...>   type: "search", 
      ...>   description: "Searching for ransomware", 
      ...>   patterns: [%{types: "FreeText", pattern: "ransomware"}],
      ...>   notificationChannel: "website",
      ...>   notificationFrequency: "immediately"
      ...> }
      iex> Intel471Ex.Watchers.create_watcher("0bd66b73-c445-4b35-b3d4-742ed1e5a092", body)
      {:ok, %{"uid" => "e1ada07bf9d0a14884844bcd85cd785a", ...}}
  """
  @spec create_watcher(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def create_watcher(group_uid, body) do
    Client.request(:post, "/watcherGroups/#{group_uid}/watchers", %{}, body)
  end
  
  @doc """
  Delete a watcher.
  
  ## Parameters
  
  - `group_uid`: The unique identifier of the watcher group
  - `watcher_uid`: The unique identifier of the watcher
  
  ## Examples
  
      iex> Intel471Ex.Watchers.delete_watcher("0bd66b73-c445-4b35-b3d4-742ed1e5a092", "e1ada07bf9d0a14884844bcd85cd785a")
      {:ok, nil}
  """
  @spec delete_watcher(String.t(), String.t()) :: {:ok, nil} | {:error, any()}
  def delete_watcher(group_uid, watcher_uid) do
    Client.request(:delete, "/watcherGroups/#{group_uid}/watchers/#{watcher_uid}")
  end
end

