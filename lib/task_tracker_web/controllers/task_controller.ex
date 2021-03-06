defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users

  plug TaskTrackerWeb.Plugs.RequireAdmin when action in [:delete]

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    users = Users.list_users()
    render(conn, "index.html", tasks: tasks, users: users)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    users = Users.list_users()
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    users = Users.list_users()
    user = if (task && task.user_id), do: Users.get_user(task.user_id).email, else: "Unassigned"
    render(conn, "show.html", task: task, users: users, user: user)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    users = Users.list_users()
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, users: Users.list_users())
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
