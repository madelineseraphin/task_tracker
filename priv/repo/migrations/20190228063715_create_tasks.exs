defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :hours, :float
      add :complete, :boolean, default: false, null: false
      add :user_id, references(:users)

      timestamps()
    end

  end
end
