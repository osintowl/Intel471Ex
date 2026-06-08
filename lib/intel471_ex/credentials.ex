defmodule Intel471Ex.Credentials do
  @moduledoc """
  Functions for working with the Intel 471 Verity Credentials API.

  Service path: `integrations/creds/v1`
  """

  alias Intel471Ex.Client

  @service_path "integrations/creds/v1"

  # --- Credentials ---

  @doc """
  Stream credentials matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:credential_set_name` — Filter by credential set name
    - `:credential_set_id` — Filter by credential set ID
    - `:domain` — Filter by domain
    - `:affiliation_group` — Filter by affiliation group
    - `:password_strength` — Filter by password strength
    - `:password_length_gte` — Minimum password length
    - `:password_plain` — Filter by plain text password
    - `:credential_login` — Filter by credential login
    - `:detected_malware` — Filter by detected malware
    - `:girs` — Filter by GIRs
    - `:from` / `:until` — Time range
    - `:last_updated_from` / `:last_updated_until` — Last updated range
    - `:size` / `:cursor` — Pagination

  ## Examples

      {:ok, result} = Intel471Ex.Credentials.credential_stream(%{domain: "example.com", size: 10})
  """
  @spec credential_stream(map()) :: {:ok, map()} | {:error, any()}
  def credential_stream(params \\ %{}) do
    Client.get("#{@service_path}/credentials/stream", params)
  end

  @doc """
  Get a credential by ID.

  ## Examples

      {:ok, credential} = Intel471Ex.Credentials.get_credential("credential-id")
  """
  @spec get_credential(String.t()) :: {:ok, map()} | {:error, any()}
  def get_credential(id) do
    Client.get("#{@service_path}/credentials/#{id}")
  end

  # --- Credential Occurrences ---

  @doc """
  Stream credential occurrences matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters (same filters as `credential_stream/1`,
    plus `:credential_id`)

  ## Examples

      {:ok, result} = Intel471Ex.Credentials.credential_occurrence_stream(%{credential_id: "id", size: 10})
  """
  @spec credential_occurrence_stream(map()) :: {:ok, map()} | {:error, any()}
  def credential_occurrence_stream(params \\ %{}) do
    Client.get("#{@service_path}/credentials/occurrences/stream", params)
  end

  @doc """
  Get a credential occurrence by ID.

  ## Examples

      {:ok, occurrence} = Intel471Ex.Credentials.get_credential_occurrence("occurrence-id")
  """
  @spec get_credential_occurrence(String.t()) :: {:ok, map()} | {:error, any()}
  def get_credential_occurrence(id) do
    Client.get("#{@service_path}/credentials/occurrences/#{id}")
  end

  # --- Credential Sets ---

  @doc """
  Stream credential sets matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:credential_set_name` — Filter by credential set name
    - `:girs` — Filter by GIRs
    - `:victim` — Filter by purported victim
    - `:from` / `:until` / `:last_updated_from` / `:last_updated_until`
    - `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Credentials.credential_set_stream(%{victim: "example.com", size: 10})
  """
  @spec credential_set_stream(map()) :: {:ok, map()} | {:error, any()}
  def credential_set_stream(params \\ %{}) do
    Client.get("#{@service_path}/credential-sets/stream", params)
  end

  @doc """
  Get a credential set by ID.

  ## Examples

      {:ok, set} = Intel471Ex.Credentials.get_credential_set("set-id")
  """
  @spec get_credential_set(String.t()) :: {:ok, map()} | {:error, any()}
  def get_credential_set(id) do
    Client.get("#{@service_path}/credential-sets/#{id}")
  end

  # --- Credential Set Accessed URLs ---

  @doc """
  Stream credential set accessed URLs matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:credential_set_id` — Filter by credential set ID
    - `:credential_set_name` — Filter by credential set name
    - `:accessed_url` — Filter by accessed URL
    - `:girs` / `:victim` / `:from` / `:until`
    - `:last_updated_from` / `:last_updated_until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Credentials.credential_set_accessed_url_stream(%{credential_set_id: "id", size: 10})
  """
  @spec credential_set_accessed_url_stream(map()) :: {:ok, map()} | {:error, any()}
  def credential_set_accessed_url_stream(params \\ %{}) do
    Client.get("#{@service_path}/credential-sets/accessed-urls/stream", params)
  end
end