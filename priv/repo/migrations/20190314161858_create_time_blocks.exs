defmodule TaskTracker.Repo.Migrations.CreateTimeBlocks do
  use Ecto.Migration

  def change do
    create table(:time_blocks) do
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :in_progress, :boolean, default: false, null: false
      add :task_id, references(:tasks, on_delete: :nothing)

      timestamps()
    end

    create index(:time_blocks, [:task_id])
  end
end
