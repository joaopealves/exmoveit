defmodule Exmoveit.Users.Create do
  @moduledoc """
    Inserts a user into the database.
  """

  alias Exmoveit.{Error, Repo, User}

  @spec call(%{email: String.t()}) ::
          {:error, %{status: :bad_request, result: Ecto.Changeset.t()}}
          | {:ok, %User{}}
  @doc """
  Inserts a user into the database.

  ## Examples

        iex> user_params = %{email: "mike@gmail.com"}

        iex> {:ok, %Exmoveit.User{}} = Exmoveit.Users.Create.call(user_params)

  """
  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def call(_anything), do: {:error, "Enter the data in a map format"}

  defp handle_insert(
         {:error,
          error = %{
            errors: [
              email: {
                "has already been taken",
                [constraint: :unique, constraint_name: "users_email_index"]
              }
            ]
          }}
       ) do
    {:error, Error.build(:ok, error)}
  end

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}

  defp handle_insert({:ok, %User{}} = user),
    do: tap(user, fn params -> create_profile_data(params) end)

  defp create_profile_data({:ok, map}), do: Exmoveit.create_profile_data(%{user_id: map.id})
end
