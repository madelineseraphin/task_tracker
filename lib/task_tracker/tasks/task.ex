defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    belongs_to :assignee, TaskTracker.Users.User
    field :complete, :boolean, default: false
    field :description, :string
    field :hours, :float
    field :reporter, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :reporter, :assignee, :hours, :complete])
    |> validate_required([:title, :description, :reporter, :assignee, :hours, :complete])
  end
end
