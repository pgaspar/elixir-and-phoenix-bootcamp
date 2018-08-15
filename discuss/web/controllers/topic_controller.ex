defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Topic.changeset(struct, params)

    render conn, "new.html"
  end

  def create(conn, _params) do
    # render conn, "new.html"
    # redirect_to :new
  end
end
