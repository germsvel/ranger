defmodule Ranger.Repo do
  use Ecto.Repo,
    otp_app: :ranger,
    adapter: Ecto.Adapters.Postgres
end
