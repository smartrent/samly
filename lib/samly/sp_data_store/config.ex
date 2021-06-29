defmodule Samly.SpDataStore.Config do
  @moduledoc """
  Reads service provider data from Application environment (config files).

  This is the default behaviour. To change it, set the following config:

    config :samly, Samly.Provider,
      sp_data_store: MyApp.SpStore

  This implementation only provides `init/2` and `get/1`.any()
  `delete/1` and `put/2` will return `:unsupported`.
  """

  @behaviour Samly.SpDataStore.Store

  @impl true
  def init(opts) do
    service_providers = Samly.SpData.load_providers(opts || [])

    Application.put_env(:samly, :service_providers, service_providers)
  end

  @impl true
  def get(idp_id) do
    sps = Application.get_env(:samly, :service_providers, %{})
    Map.get(sps, idp_id)
  end

  @impl true
  def put(_idp_id, _idp_data), do: :unsupported

  @impl true
  def delete(_idp_id), do: :unsupported
end
