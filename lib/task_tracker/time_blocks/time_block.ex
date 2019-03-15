defmodule TaskTracker.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "time_blocks" do
    field :end_time, :utc_datetime
    field :in_progress, :boolean, default: false
    field :start_time, :utc_datetime
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :end_time, :in_progress, :task_id])
    |> validate_required([:start_time, :end_time, :in_progress, :task_id])
  end
end
