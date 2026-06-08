defmodule Intel471Ex.Sources do
  @moduledoc """
  Functions for working with the Intel 471 Verity Sources API.

  Service path: `integrations/sources/v1`

  Covers: data leak site posts, forum posts, forum private messages,
  chat/messaging service messages, and image retrieval.
  """

  alias Intel471Ex.Client

  @service_path "integrations/sources/v1"

  # --- Data Leak Sites ---

  @doc """
  Stream data leak site posts matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:website_id` — Filter by website ID
    - `:thread_id` — Filter by thread ID
    - `:text_filter` — Free text search
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Sources.data_leak_site_posts_stream(%{text_filter: "ransomware", size: 10})
  """
  @spec data_leak_site_posts_stream(map()) :: {:ok, map()} | {:error, any()}
  def data_leak_site_posts_stream(params \\ %{}) do
    Client.get("#{@service_path}/data-leak-sites/posts/stream", params)
  end

  @doc """
  Get a data leak site file listing (raw binary).

  ## Examples

      {:ok, %{body: data}} = Intel471Ex.Sources.get_data_leak_site_file_listing("listing-id")
  """
  @spec get_data_leak_site_file_listing(String.t()) :: {:ok, map()} | {:error, any()}
  def get_data_leak_site_file_listing(id) do
    Client.get_raw("#{@service_path}/data-leak-sites/file-listings/#{id}")
  end

  # --- Forum Posts ---

  @doc """
  Stream forum posts matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:thread_id` / `:author` / `:author_id` / `:forum_title`
    - `:text_filter` — Free text search
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Sources.forums_posts_stream(%{author: "username", size: 10})
  """
  @spec forums_posts_stream(map()) :: {:ok, map()} | {:error, any()}
  def forums_posts_stream(params \\ %{}) do
    Client.get("#{@service_path}/forums/posts/stream", params)
  end

  @doc """
  Get a forum post by ID.

  ## Examples

      {:ok, post} = Intel471Ex.Sources.get_forum_post("post-id")
  """
  @spec get_forum_post(String.t()) :: {:ok, map()} | {:error, any()}
  def get_forum_post(post_id) do
    Client.get("#{@service_path}/forums/posts/#{post_id}")
  end

  # --- Forum Private Messages ---

  @doc """
  Stream forum private messages matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:text_filter` / `:author` / `:author_id` / `:forum_title`
    - `:subject` / `:recipient` / `:recipient_id` / `:forum_id`
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Sources.forums_private_messages_stream(%{author: "username", size: 10})
  """
  @spec forums_private_messages_stream(map()) :: {:ok, map()} | {:error, any()}
  def forums_private_messages_stream(params \\ %{}) do
    Client.get("#{@service_path}/forums/private-messages/stream", params)
  end

  @doc """
  Get a forum private message by ID.

  ## Examples

      {:ok, pm} = Intel471Ex.Sources.get_forum_private_message("pm-id")
  """
  @spec get_forum_private_message(String.t()) :: {:ok, map()} | {:error, any()}
  def get_forum_private_message(private_message_id) do
    Client.get("#{@service_path}/forums/private-messages/#{private_message_id}")
  end

  # --- Chat / Messaging Services ---

  @doc """
  Stream chat messages matching filter criteria (cursor-paginated).

  ## Parameters

  - `params`: A map of query parameters
    - `:text_filter` / `:author` / `:author_id`
    - `:server_type` — Messaging service type (e.g., "telegram", "discord")
    - `:server_id` / `:room_id`
    - `:from` / `:until` / `:size` / `:cursor`

  ## Examples

      {:ok, result} = Intel471Ex.Sources.chat_messages_stream(%{server_type: "telegram", size: 10})
  """
  @spec chat_messages_stream(map()) :: {:ok, map()} | {:error, any()}
  def chat_messages_stream(params \\ %{}) do
    Client.get("#{@service_path}/messaging-services/messages/stream", params)
  end

  @doc """
  Get a chat message by ID.

  ## Examples

      {:ok, msg} = Intel471Ex.Sources.get_chat_message("message-id")
  """
  @spec get_chat_message(String.t()) :: {:ok, map()} | {:error, any()}
  def get_chat_message(message_id) do
    Client.get("#{@service_path}/messaging-services/messages/#{message_id}")
  end

  # --- Images ---

  @doc """
  Get an image from a source (raw binary).

  ## Parameters

  - `type`: Image type (e.g., "forum", "chat")
  - `hash`: Image hash
  - `name`: Image filename

  ## Examples

      {:ok, %{body: img}} = Intel471Ex.Sources.get_image("forum", "abc123", "screenshot.png")
  """
  @spec get_image(String.t(), String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get_image(type, hash, name) do
    Client.get_raw("#{@service_path}/images/#{type}/#{hash}/#{name}")
  end
end