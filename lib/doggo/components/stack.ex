defmodule Doggo.Components.Stack do
  @moduledoc false

  @behaviour Doggo.Component

  use Phoenix.Component

  @impl true
  def doc do
    """
    Applies a vertical margin between the child elements.
    """
  end

  @impl true
  def usage do
    """
    ```heex
    <.stack>
      <div>some block</div>
      <div>some other block</div>
    </.stack>
    ```

    To apply a vertical margin on nested elements as well, set `recursive` to
    `true`.

    ```heex
    <.stack recursive={true}>
      <div>
        <div>some nested block</div>
        <div>another nested block</div>
      </div>
      <div>some other block</div>
    </.stack>
    ```
    """
  end

  @impl true
  def config do
    [
      type: :layout,
      since: "0.6.0",
      maturity: :refining,
      modifiers: [],
      extra: [recursive_class: "is-recursive"]
    ]
  end

  @impl true
  def attrs_and_slots do
    quote do
      attr :recursive, :boolean,
        default: false,
        doc:
          "If `true`, the stack margins will be applied to nested elements as well."

      attr :rest, :global, doc: "Any additional HTML attributes."

      slot :inner_block, required: true
    end
  end

  @impl true
  def init_block(_opts, extra) do
    recursive_class = Keyword.fetch!(extra, :recursive_class)

    quote do
      var!(assigns) =
        if var!(assigns)[:recursive] do
          Map.update!(
            var!(assigns),
            :class,
            &(&1 ++ [unquote(recursive_class)])
          )
        else
          var!(assigns)
        end
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end