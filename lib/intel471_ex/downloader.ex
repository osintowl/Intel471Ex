defmodule Intel471Ex.Downloader do
  @moduledoc """
  File downloader for Intel 471 Verity API using Req.
  """

  alias Intel471Ex.Client

  @doc """
  Downloads a file from Intel 471 Verity API.

  ## Parameters

  - `url`: Full URL to the file
  - `destination`: Local path where the file should be saved
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, path}` — Successful download with path to saved file
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, path} = Intel471Ex.Downloader.download_file(
        "https://api.intel471.cloud/integrations/intel-report/v1/reports/report-id/download-as-pdf",
        "/tmp/report.pdf"
      )
  """
  @spec download_file(String.t(), String.t(), map() | nil) ::
          {:ok, String.t()} | {:error, any()}
  def download_file(url, destination, config \\ nil) do
    config = config || Intel471Ex.config()

    req =
      Req.new(
        method: :get,
        url: url,
        auth: {:basic, "#{config.client_id}:#{config.client_secret}"},
        decode_body: false
      )

    case Req.request(req) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 300 ->
        destination |> Path.dirname() |> File.mkdir_p!()

        case File.write(destination, body) do
          :ok -> {:ok, destination}
          {:error, reason} -> {:error, %{message: "Failed to write file", reason: reason}}
        end

      {:ok, %{status: status, body: body}} ->
        error_message = Client.extract_error_message(body) || "Download failed with status code #{status}"
        {:error, %{status: status, message: error_message}}

      {:error, exception} ->
        {:error, exception}
    end
  end

  @doc """
  Downloads a file from Intel 471 Verity API and automatically extracts the
  filename from the URL.

  ## Parameters

  - `url`: Full URL to the file
  - `destination_dir`: Directory where the file should be saved (default: "downloads")
  - `config`: Optional configuration override

  ## Returns

  - `{:ok, path}` — Successful download with path to saved file
  - `{:error, reason}` — Error with reason

  ## Examples

      {:ok, path} = Intel471Ex.Downloader.download_file_auto(
        "https://api.intel471.cloud/integrations/intel-report/v1/reports/report-id/download-as-pdf"
      )
      {:ok, path} = Intel471Ex.Downloader.download_file_auto(
        "https://api.intel471.cloud/integrations/intel-report/v1/reports/report-id/download-as-pdf",
        "output/pdfs"
      )
  """
  @spec download_file_auto(String.t(), String.t(), map() | nil) ::
          {:ok, String.t()} | {:error, any()}
  def download_file_auto(url, destination_dir \\ "downloads", config \\ nil) do
    filename = url |> URI.parse() |> Map.get(:path) |> Path.basename()
    destination = Path.join(destination_dir, filename)

    download_file(url, destination, config)
  end
end