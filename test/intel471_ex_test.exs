defmodule Intel471ExTest do
  use ExUnit.Case, async: true

  doctest Intel471Ex

  setup_all do
    for mod <- [
      Intel471Ex.Actors,
      Intel471Ex.Reports,
      Intel471Ex.Credentials,
      Intel471Ex.Watchers,
      Intel471Ex.Entities,
      Intel471Ex.Indicators,
      Intel471Ex.Malware,
      Intel471Ex.Observables,
      Intel471Ex.Girs,
      Intel471Ex.Sources,
      Intel471Ex.Ase,
      Intel471Ex.BrandExposure,
      Intel471Ex.Tprm,
      Intel471Ex.Downloader,
      Intel471Ex.Client
    ], do: Code.ensure_loaded(mod)

    :ok
  end

  # --- API Module Path Tests ---

  describe "API module service paths" do
    test "Actors module has stream/1 function" do
      assert function_exported?(Intel471Ex.Actors, :stream, 1)
    end

    test "Reports module has all stream functions" do
      assert function_exported?(Intel471Ex.Reports, :stream, 1)
      assert function_exported?(Intel471Ex.Reports, :fintel_stream, 1)
      assert function_exported?(Intel471Ex.Reports, :fintel_detail, 1)
      assert function_exported?(Intel471Ex.Reports, :fintel_attachment, 2)
      assert function_exported?(Intel471Ex.Reports, :breach_alert_stream, 1)
      assert function_exported?(Intel471Ex.Reports, :breach_alert_detail, 1)
      assert function_exported?(Intel471Ex.Reports, :geopol_stream, 1)
      assert function_exported?(Intel471Ex.Reports, :geopol_detail, 1)
      assert function_exported?(Intel471Ex.Reports, :geopol_attachment, 2)
      assert function_exported?(Intel471Ex.Reports, :info_stream, 1)
      assert function_exported?(Intel471Ex.Reports, :info_detail, 1)
      assert function_exported?(Intel471Ex.Reports, :info_attachment, 2)
      assert function_exported?(Intel471Ex.Reports, :malware_stream, 1)
      assert function_exported?(Intel471Ex.Reports, :malware_detail, 1)
      assert function_exported?(Intel471Ex.Reports, :malware_attachment, 2)
      assert function_exported?(Intel471Ex.Reports, :spot_stream, 1)
      assert function_exported?(Intel471Ex.Reports, :spot_detail, 1)
      assert function_exported?(Intel471Ex.Reports, :vulnerability_stream, 1)
      assert function_exported?(Intel471Ex.Reports, :vulnerability_detail, 1)
      assert function_exported?(Intel471Ex.Reports, :vulnerability_download_pdf, 1)
      assert function_exported?(Intel471Ex.Reports, :download_pdf, 1)
    end

    test "Credentials module has all stream and get functions" do
      assert function_exported?(Intel471Ex.Credentials, :credential_stream, 1)
      assert function_exported?(Intel471Ex.Credentials, :get_credential, 1)
      assert function_exported?(Intel471Ex.Credentials, :credential_occurrence_stream, 1)
      assert function_exported?(Intel471Ex.Credentials, :get_credential_occurrence, 1)
      assert function_exported?(Intel471Ex.Credentials, :credential_set_stream, 1)
      assert function_exported?(Intel471Ex.Credentials, :get_credential_set, 1)
      assert function_exported?(Intel471Ex.Credentials, :credential_set_accessed_url_stream, 1)
    end

    test "Watchers module has alert and watcher functions" do
      assert function_exported?(Intel471Ex.Watchers, :alerts_stream, 1)
      assert function_exported?(Intel471Ex.Watchers, :update_alert_status, 2)
      assert function_exported?(Intel471Ex.Watchers, :watcher_groups, 1)
      assert function_exported?(Intel471Ex.Watchers, :watchers, 1)
    end

    test "Entities module has stream function" do
      assert function_exported?(Intel471Ex.Entities, :stream, 1)
    end

    test "Indicators module has stream and get_by_id functions" do
      assert function_exported?(Intel471Ex.Indicators, :stream, 1)
      assert function_exported?(Intel471Ex.Indicators, :get_by_id, 1)
    end

    test "Malware module has all functions" do
      assert function_exported?(Intel471Ex.Malware, :events_stream, 1)
      assert function_exported?(Intel471Ex.Malware, :get_event, 1)
      assert function_exported?(Intel471Ex.Malware, :list_malware, 1)
      assert function_exported?(Intel471Ex.Malware, :get_malware_family, 1)
      assert function_exported?(Intel471Ex.Malware, :download_file, 1)
    end

    test "Observables module has stream function" do
      assert function_exported?(Intel471Ex.Observables, :stream, 1)
    end

    test "Girs module has tree function" do
      assert function_exported?(Intel471Ex.Girs, :tree, 0)
    end

    test "Sources module has all stream and get functions" do
      assert function_exported?(Intel471Ex.Sources, :data_leak_site_posts_stream, 1)
      assert function_exported?(Intel471Ex.Sources, :get_data_leak_site_file_listing, 1)
      assert function_exported?(Intel471Ex.Sources, :forums_posts_stream, 1)
      assert function_exported?(Intel471Ex.Sources, :get_forum_post, 1)
      assert function_exported?(Intel471Ex.Sources, :forums_private_messages_stream, 1)
      assert function_exported?(Intel471Ex.Sources, :get_forum_private_message, 1)
      assert function_exported?(Intel471Ex.Sources, :chat_messages_stream, 1)
      assert function_exported?(Intel471Ex.Sources, :get_chat_message, 1)
      assert function_exported?(Intel471Ex.Sources, :get_image, 3)
    end

    test "Ase module has list_monitors function" do
      assert function_exported?(Intel471Ex.Ase, :list_monitors, 1)
    end

    test "BrandExposure module has monitor CRUD and config functions" do
      assert function_exported?(Intel471Ex.BrandExposure, :list_monitors, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :create_monitor, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :get_monitor, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :delete_monitor, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :edit_monitor, 2)
      assert function_exported?(Intel471Ex.BrandExposure, :get_monitor_logs, 2)
      assert function_exported?(Intel471Ex.BrandExposure, :run_monitor, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :run_monitor, 2)
      assert function_exported?(Intel471Ex.BrandExposure, :get_monitor_scans, 2)
      assert function_exported?(Intel471Ex.BrandExposure, :get_scan_data, 2)
      assert function_exported?(Intel471Ex.BrandExposure, :get_config_current, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :get_config_defaults, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :get_config_schema, 0)
      assert function_exported?(Intel471Ex.BrandExposure, :get_config_user, 1)
      assert function_exported?(Intel471Ex.BrandExposure, :put_config_user, 2)
    end

    test "Tprm module has monitor CRUD and config functions" do
      assert function_exported?(Intel471Ex.Tprm, :list_monitors, 1)
      assert function_exported?(Intel471Ex.Tprm, :create_monitor, 1)
      assert function_exported?(Intel471Ex.Tprm, :get_monitor, 1)
      assert function_exported?(Intel471Ex.Tprm, :delete_monitor, 1)
      assert function_exported?(Intel471Ex.Tprm, :edit_monitor, 2)
      assert function_exported?(Intel471Ex.Tprm, :get_monitor_logs, 2)
      assert function_exported?(Intel471Ex.Tprm, :run_monitor, 1)
      assert function_exported?(Intel471Ex.Tprm, :run_monitor, 2)
      assert function_exported?(Intel471Ex.Tprm, :get_monitor_scans, 2)
      assert function_exported?(Intel471Ex.Tprm, :get_scan_data, 2)
      assert function_exported?(Intel471Ex.Tprm, :get_config_current, 1)
      assert function_exported?(Intel471Ex.Tprm, :get_config_defaults, 1)
      assert function_exported?(Intel471Ex.Tprm, :get_config_schema, 0)
      assert function_exported?(Intel471Ex.Tprm, :get_config_user, 1)
      assert function_exported?(Intel471Ex.Tprm, :put_config_user, 3)
    end

    test "Downloader module has download functions" do
      assert function_exported?(Intel471Ex.Downloader, :download_file, 3)
      assert function_exported?(Intel471Ex.Downloader, :download_file_auto, 3)
    end
  end

  # --- Client Helper Function Tests ---

  describe "Intel471Ex.Client helper functions" do
    test "get/1, get/2, get/3 exist" do
      assert function_exported?(Intel471Ex.Client, :get, 1)
      assert function_exported?(Intel471Ex.Client, :get, 2)
      assert function_exported?(Intel471Ex.Client, :get, 3)
    end

    test "post/2, post/3 exist" do
      assert function_exported?(Intel471Ex.Client, :post, 2)
      assert function_exported?(Intel471Ex.Client, :post, 3)
    end

    test "put/2, put/3 exist" do
      assert function_exported?(Intel471Ex.Client, :put, 2)
      assert function_exported?(Intel471Ex.Client, :put, 3)
    end

    test "patch/2, patch/3 exist" do
      assert function_exported?(Intel471Ex.Client, :patch, 2)
      assert function_exported?(Intel471Ex.Client, :patch, 3)
    end

    test "delete/1, delete/2 exist" do
      assert function_exported?(Intel471Ex.Client, :delete, 1)
      assert function_exported?(Intel471Ex.Client, :delete, 2)
    end

    test "get_raw/1, get_raw/2 exist" do
      assert function_exported?(Intel471Ex.Client, :get_raw, 1)
      assert function_exported?(Intel471Ex.Client, :get_raw, 2)
    end

    test "request/3, request/4, request/5 exist" do
      assert function_exported?(Intel471Ex.Client, :request, 3)
      assert function_exported?(Intel471Ex.Client, :request, 4)
      assert function_exported?(Intel471Ex.Client, :request, 5)
    end

    test "extract_error_message/1 handles map with string key" do
      assert Intel471Ex.Client.extract_error_message(%{"message" => "Not found"}) == "Not found"
    end

    test "extract_error_message/1 handles map with atom key" do
      assert Intel471Ex.Client.extract_error_message(%{message: "Unauthorized"}) == "Unauthorized"
    end

    test "extract_error_message/1 returns nil for unknown format" do
      assert Intel471Ex.Client.extract_error_message(%{"error" => "something"}) == nil
      assert Intel471Ex.Client.extract_error_message(nil) == nil
    end
  end

  # --- Old modules no longer exist ---

  describe "removed modules" do
    test "Vulnerabilities module no longer exists" do
      refute Code.ensure_loaded?(Intel471Ex.Vulnerabilities)
    end

    test "Alerts module no longer exists" do
      refute Code.ensure_loaded?(Intel471Ex.Alerts)
    end

    test "Search module no longer exists" do
      refute Code.ensure_loaded?(Intel471Ex.Search)
    end
  end
end