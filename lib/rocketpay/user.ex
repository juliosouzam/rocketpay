defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rocketpay.Account

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string
    # field :password, :string, virtual: true
    field :nickname, :string

    has_one :account, Account

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # IO.inspect(Bcrypt.add_hash(password))
    %{password_hash: password} = Bcrypt.add_hash(password)
    change(changeset, %{:password => password})
  end

  defp put_password_hash(changeset), do: changeset
end
