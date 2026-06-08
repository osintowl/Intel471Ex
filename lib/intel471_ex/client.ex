defmodule Intel471Ex.Client do
  @moduledoc """
  HTTP Client for Intel 471 Verity API using Req.

  All API requests use HTTP Basic Auth with Verity application credentials
  (client ID as username, client secret as password).
  """

  alias Intel471Ex.Client

  @doc """
  Makes a GET request to the Verity API.

  ## Parameters

  - `path`: Full API path (e.g., `"integrations/actors/v1/actors/stream"`)
  - `params`: Query parameters (optional)
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, body}` — Successful response with parsed JSON
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, result} = Intel471Ex.Client.get("integrations/actors/v1/actors/stream", %{actor: "conti", size: 10})
  """
  @spec get(String.t(), map(), map() | nil) :: {:ok, map()} | {:error, any()}
  def get(path, params \\ %{}, config \\ nil) do
    request(:get, path, params, nil, config)
  end

  @doc """
  Makes a POST request to the Verity API with a JSON body.

  ## Parameters

  - `path`: Full API path
  - `body`: Request body (will be JSON-encoded)
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, body}` — Successful response with parsed JSON
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, monitor} = Intel471Ex.Client.post("integrations/brand-exposure/v1/monitor", %{name: "example.com", targets: ["example.com"]})
  """
  @spec post(String.t(), map(), map() | nil) :: {:ok, map()} | {:error, any()}
  def post(path, body, config \\ nil) do
    request(:post, path, %{}, body, config)
  end

  @doc """
  Makes a PUT request to the Verity API with a JSON body.

  ## Parameters

  - `path`: Full API path
  - `body`: Request body (will be JSON-encoded)
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, body}` — Successful response with parsed JSON
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, _} = Intel471Ex.Client.put("integrations/watchers/v1/alerts/12345/read", %{})
  """
  @spec put(String.t(), map(), map() | nil) :: {:ok, map()} | {:error, any()}
  def put(path, body, config \\ nil) do
    request(:put, path, %{}, body, config)
  end

  @doc """
  Makes a PATCH request to the Verity API with a JSON body.

  ## Parameters

  - `path`: Full API path
  - `body`: Request body (will be JSON-encoded)
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, body}` — Successful response with parsed JSON
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, _} = Intel471Ex.Client.patch("integrations/brand-exposure/v1/monitor/monitor-id", %{name: "updated-name"})
  """
  @spec patch(String.t(), map(), map() | nil) :: {:ok, map()} | {:error, any()}
  def patch(path, body, config \\ nil) do
    request(:patch, path, %{}, body, config)
  end

  @doc """
  Makes a DELETE request to the Verity API.

  ## Parameters

  - `path`: Full API path
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, body}` — Successful response with parsed JSON
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, _} = Intel471Ex.Client.delete("integrations/brand-exposure/v1/monitor/monitor-id")
  """
  @spec delete(String.t(), map() | nil) :: {:ok, map()} | {:error, any()}
  def delete(path, config \\ nil) do
    request(:delete, path, %{}, nil, config)
  end

  @doc """
  Makes a raw GET request returning binary response (for file downloads).

  ## Parameters

  - `path`: Full API path
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, %{body: binary}}` — Successful response with raw body
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, %{body: pdf}} = Intel471Ex.Client.get_raw("integrations/intel-report/v1/reports/report-id/download-as-pdf")
  """
  @spec get_raw(String.t(), map() | nil) :: {:ok, map()} | {:error, any()}
  def get_raw(path, config \\ nil) do
    config = config || Intel471Ex.config()
    url = build_url(config.api_url, path)

    req =
      Req.new(
        method: :get,
        url: url,
        auth: {:basic, "#{config.client_id}:#{config.client_secret}"},
        decode_body: false
      )

    case Req.request(req) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 300 ->
        {:ok, %{body: body}}

      {:ok, %{status: status, body: body}} ->
        error_message = Client.extract_error_message(body) || "Request failed with status code #{status}"
        {:error, %{status: status, message: error_message}}

      {:error, exception} ->
        {:error, exception}
    end
  end

  @doc """
  Makes an API request to Intel 471 Verity API.

  ## Parameters

  - `method`: HTTP method (:get, :post, :put, :patch, :delete)
  - `path`: API endpoint path
  - `params`: Query parameters (optional)
  - `body`: Request body for POST/PUT/PATCH requests (optional)
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, body}` — Successful response with parsed JSON
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, result} = Intel471Ex.Client.request(:get, "integrations/actors/v1/actors/stream", %{size: 10})
      {:ok, monitor} = Intel471Ex.Client.request(:post, "integrations/brand-exposure/v1/monitor", %{}, %{name: "test"})
  """
  @spec request(atom(), String.t(), map(), map() | nil, map() | nil) ::
          {:ok, map()} | {:error, map() | any()}
  def request(method, path, params \\ %{}, body \\ nil, config \\ nil) do
    config = config || Intel471Ex.config()
    url = build_url(config.api_url, path)

    req_opts =
      [
        method: method,
        url: url,
        auth: {:basic, "#{config.client_id}:#{config.client_secret}"},
        params: params
      ]
      |> then(fn opts ->
        if body, do: Keyword.put(opts, :json, body), else: opts
      end)

    req = Req.new(req_opts)

    case Req.request(req) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 300 ->
        {:ok, body}

      {:ok, %{status: status, body: body}} ->
        error_message = Client.extract_error_message(body) || "Request failed with status code #{status}"
        {:error, %{status: status, message: error_message}}

      {:error, exception} ->
        {:error, exception}
    end
  end

  @doc """
  Extracts an error message from an API response body.

  Looks for a `"message"` key in a map response body.

  ## Examples

      iex> Intel471Ex.Client.extract_error_message(%{"message" => "Not found"})
      "Not found"

      iex> Intel471Ex.Client.extract_error_message(%{message: "Unauthorized"})
      "Unauthorized"

      iex> Intel471Ex.Client.extract_error_message("something else")
      nil
  """
  @spec extract_error_message(any()) :: String.t() | nil
  def extract_error_message(%{"message" => message}) when is_binary(message), do: message
  def extract_error_message(%{message: message}) when is_binary(message), do: message
  def extract_error_message(_), do: nil

  defp build_url(base_url, path) do
    base_url = String.trim_trailing(base_url, "/")
    "#{base_url}/#{path}"
  end
end