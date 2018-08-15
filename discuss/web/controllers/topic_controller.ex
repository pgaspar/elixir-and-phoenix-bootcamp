defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  def new(conn, _params) do
    struct = %Discuss.Topic{}
    params = %{}
    changeset = Discuss.Topic.changeset(struct, params)

    render conn, "new.html"
  end

  def create(conn, _params) do
    # render conn, "new.html"
    # redirect_to :new
  end
end
