defmodule Intel471Ex do
  @moduledoc """
  Client library for Intel 471's Verity API.

  This library provides functions to interact with the Verity API for gathering
  cyber threat intelligence. Configuration is handled via system environment
  variables.

  ## Environment Variables

  - `VERITY_CLIENT_ID` (required): Your Verity application client ID
  - `VERITY_CLIENT_SECRET` (required): Your Verity application client secret
  - `VERITY_API_URL` (optional): Custom API URL (default: `https://api.intel471.cloud`)
  """

  @default_api_url "https://api.intel471.cloud"

  @doc """
  Retrieves the configuration from environment variables.

  ## Returns

  A map containing the configuration values:

  - `:client_id` — Verity application client ID (from `VERITY_CLIENT_ID`)
  - `:client_secret` — Verity application client secret (from `VERITY_CLIENT_SECRET`)
  - `:api_url` — API base URL (from `VERITY_API_URL`, defaults to `https://api.intel471.cloud`)

  ## Raises

  Raises if `VERITY_CLIENT_ID` or `VERITY_CLIENT_SECRET` are not set.

  ## Examples

      iex> System.put_env("VERITY_CLIENT_ID", "my-client-id")
      iex> System.put_env("VERITY_CLIENT_SECRET", "my-client-secret")
      iex> config = Intel471Ex.config()
      iex> config.client_id
      "my-client-id"
  """
  @spec config() :: %{client_id: String.t(), client_secret: String.t(), api_url: String.t()}
  def config do
    %{
      client_id: get_env("VERITY_CLIENT_ID"),
      client_secret: get_env("VERITY_CLIENT_SECRET"),
      api_url: System.get_env("VERITY_API_URL", @default_api_url)
    }
  end

  defp get_env(name) do
    case System.get_env(name) do
      nil -> raise "Environment variable #{name} is not set"
      value -> value
    end
  end
end