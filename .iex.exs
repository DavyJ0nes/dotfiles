# ~/.iex.exs
# IEx configuration for productive Elixir development

# ==============================================================================
# IMPORTS & ALIASES
# ==============================================================================

# Only import what you actually use frequently
# Importing entire modules can cause naming conflicts
import Enum, only: [map: 2, filter: 2, reduce: 3, each: 2, sum: 1]
import String, only: [upcase: 1, downcase: 1, trim: 1, split: 1]

# Useful for development
import IEx.Helpers

# ==============================================================================
# HELPER FUNCTIONS
# ==============================================================================

defmodule IExHelpers do
  @moduledoc """
  Custom helper functions for IEx productivity.
  """

  @doc "Reload the current project (stops, recompiles, starts)"
  def reload! do
    app = Mix.Project.config()[:app]

    if app do
      Mix.Task.reenable("compile.elixir")
      Application.stop(app)
      Mix.Task.run("compile.elixir")
      Application.start(app)
      IO.puts("✓ Reloaded #{app}")
    else
      IO.puts("Not in a Mix project")
    end
  end

  @doc "List all modules in an application"
  def list_app_modules(app) do
    case :application.get_key(app, :modules) do
      {:ok, modules} ->
        modules
        |> Enum.sort()
        |> IO.inspect(label: "Modules in #{app}", pretty: true)

      :undefined ->
        IO.puts("Application #{app} not found or has no modules")
    end
  end

  @doc "Clear the screen (like clear/cls in terminal)"
  def clear do
    IO.write([IO.ANSI.clear(), IO.ANSI.home()])
  end

  @doc "Quick performance timer for expressions"
  def time(func) when is_function(func) do
    {time_us, result} = :timer.tc(func)
    time_ms = time_us / 1000
    IO.puts("Executed in #{time_ms}ms")
    result
  end

  @doc "Inspect with nice formatting"
  def pp(data) do
    IO.inspect(data, pretty: true, limit: :infinity, width: 120)
  end

  @doc "Get source code of a function"
  def source(module, function, arity) do
    case Code.fetch_docs(module) do
      {:docs_v1, _, _, _, _, _, docs} ->
        docs
        |> Enum.find(fn {{type, name, ar}, _, _, _, _} ->
          type == :function and name == function and ar == arity
        end)
        |> case do
          {_, _, _, doc, _} when is_map(doc) ->
            IO.puts(doc["en"] || "No documentation")

          _ ->
            IO.puts("Function not found")
        end

      _ ->
        IO.puts("No docs available")
    end
  end

  @doc "Copy value to clipboard (macOS)"
  def copy(value) do
    text = inspect(value, pretty: true)
    System.cmd("pbcopy", [], input: text)
    IO.puts("Copied to clipboard!")
    value
  end

  @doc "Read a file and return its contents"
  def read(path) do
    case File.read(path) do
      {:ok, content} -> content
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end

  @doc "Parse a CSV string quickly"
  def parse_csv(csv_string) do
    csv_string
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
  end

  @doc "Quick way to add pry to any function"
  def add_pry(module, function, arity) do
    # This is advanced - usually just add IEx.pry() manually
    IO.puts("Add: require IEx; IEx.pry() in #{module}.#{function}/#{arity}")
  end

  @doc """
  Trace a function with Erlang's :dbg.

  Examples:
    trace(MyMod, :handle, 2)                 # trace calls+returns+exceptions (default :cx)
    trace(MyMod, :handle, 2, procs: :all)    # trace across all processes (noisy!)
    trace(MyMod, :handle, 2, match: :x)      # calls + return values
    trace(MyMod, :handle, 2, procs: self())  # only this IEx process
  """
  def trace(module, function, arity \\ :_, opts \\ []) do
    procs = Keyword.get(opts, :procs, self())

    # :cx is a great default: call + exception tracing with caller info (and returns in many cases)
    match = Keyword.get(opts, :match, :cx)

    # Start tracer (ok to call multiple times)
    :dbg.tracer()

    # Enable call tracing for selected process(es)
    # Use :c (call) — short for :call in docs
    :dbg.p(procs, :c)

    # Trace pattern:
    # tpl = local tracing (works for local + exported), good default in Elixir
    :dbg.tpl(module, function, arity, match)

    IO.puts(
      "Tracing #{inspect(module)}.#{function}/#{arity} for #{inspect(procs)} (match: #{inspect(match)})"
    )

    :ok
  end

  @doc "Stop tracing and clear all patterns/flags."
  def untrace do
    :dbg.stop()
    IO.puts("Stopped :dbg tracing and cleared patterns.")
    :ok
  end

  @doc "Clear only trace patterns (functions), keep tracer running."
  def clear_patterns do
    :dbg.ctp()
    IO.puts("Cleared all trace patterns.")
    :ok
  end

  @doc "Clear tracing flags for all processes (useful if you traced :all)."
  def clear_procs do
    :dbg.p(:all, :clear)
    IO.puts("Cleared tracing flags for all processes.")
    :ok
  end
end

defmodule Timer do
  def start do
    spawn(fn -> loop(Time.utc_now()) end)
  end

  defp loop(start_time) do
    receive do
      :stop ->
        elapsed = Time.diff(Time.utc_now(), start_time, :millisecond)
        IO.puts("Elapsed: #{elapsed}ms (#{Float.round(elapsed / 1000, 2)}s)")
    end
  end
end

# Import helpers into IEx scope
import IExHelpers
import Timer

# ==============================================================================
# TIMESTAMP FUNCTION (for prompt)
# ==============================================================================

timestamp = fn ->
  {_date, {hour, minute, _second}} = :calendar.local_time()

  [hour, minute]
  |> Enum.map(&String.pad_leading(Integer.to_string(&1), 2, "0"))
  |> Enum.join(":")
end

# ==============================================================================
# IEX CONFIGURATION
# ==============================================================================

Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  # History
  # Increased from 100
  history_size: 1000,

  # Display width
  # Wider for modern screens
  width: 120,

  # Inspection settings
  inspect: [
    # Show more items
    limit: 10_000,
    pretty: true,
    width: 120,
    # Show charlists as lists, not strings
    charlists: :as_lists
  ],

  # Color scheme
  colors: [
    syntax_colors: [
      number: :yellow,
      atom: :cyan,
      string: :green,
      boolean: :magenta,
      nil: [:red, :bright]
    ],
    ls_directory: :cyan,
    ls_device: :yellow,
    eval_result: [:green, :bright],
    # Error on new line
    eval_error: [[:red, :bright], "\n"],
    eval_info: [:blue, :bright],
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:cyan, :underline],
    doc_title: [:cyan, :bright, :underline]
  ],

  # Prompt configuration
  default_prompt:
    "#{IO.ANSI.green()}iex#{IO.ANSI.reset()} " <>
      "[#{IO.ANSI.magenta()}#{timestamp.()}#{IO.ANSI.reset()} " <>
      "#{IO.ANSI.cyan()}%counter#{IO.ANSI.reset()}] > ",
  alive_prompt:
    "#{IO.ANSI.green()}iex#{IO.ANSI.reset()} " <>
      "(#{IO.ANSI.yellow()}%node#{IO.ANSI.reset()}) " <>
      "[#{IO.ANSI.magenta()}#{timestamp.()}#{IO.ANSI.reset()} " <>
      "#{IO.ANSI.cyan()}%counter#{IO.ANSI.reset()}] > "
)

# ==============================================================================
# SAMPLE DATA FOR PRACTICE
# ==============================================================================

# Sample cycling data for exercises
sample_rides = [
  %{name: "Morning Climb", distance: 45.5, duration: 120, elevation: 650, date: ~D[2024-01-10]},
  %{name: "Evening Spin", distance: 30.0, duration: 60, elevation: 200, date: ~D[2024-01-11]},
  %{name: "Weekend Long", distance: 80.0, duration: 200, elevation: 1200, date: ~D[2024-01-13]},
  %{name: "Recovery Ride", distance: 25.0, duration: 45, elevation: 100, date: ~D[2024-01-14]}
]

# Sample list data for enumerable practice
numbers = 1..100 |> Enum.to_list()

# Sample map data
cyclist = %{
  name: "Davy",
  ftp: 230,
  weight: 95,
  weekly_hours: 4
}

# ==============================================================================
# WELCOME MESSAGE
# ==============================================================================

IO.puts("""
#{IO.ANSI.cyan()}
╔═══════════════════════════════════════════════════════════╗
║                   Welcome to Elixir IEx                   ║
╚═══════════════════════════════════════════════════════════╝
#{IO.ANSI.reset()}
#{IO.ANSI.green()}Available helpers:#{IO.ANSI.reset()}
  • reload!()              - Reload current Mix project
  • clear()                - Clear screen
  • time(fn -> ... end)    - Time execution
  • pp(data)               - Pretty print with no limits
  • copy(value)            - Copy to clipboard (macOS)
  • read("path")           - Read file contents
  • parse_csv(string)      - Quick CSV parsing

#{IO.ANSI.green()}Sample data available:#{IO.ANSI.reset()}
  • sample_rides           - List of cycling ride maps
  • numbers                - Range 1..100 as list
  • cyclist                - Sample cyclist map

#{IO.ANSI.green()}Standard helpers:#{IO.ANSI.reset()}
  • h Module               - Module help
  • h Module.function      - Function help
  • i value                - Inspect value info
  • v(n)                   - Recall previous result (e.g., v(1))
  • c "file.ex"            - Compile and load file
  • r Module               - Recompile module

#{IO.ANSI.yellow()}Tip: Use Tab for autocomplete!#{IO.ANSI.reset()}
""")
