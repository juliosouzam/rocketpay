defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Accounts.Deposit, as: AccountDeposit
  alias Rocketpay.Accounts.Withdraw, as: AccountWithdraw

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: AccountDeposit, as: :call

  defdelegate withdraw(params), to: AccountWithdraw, as: :call
end
