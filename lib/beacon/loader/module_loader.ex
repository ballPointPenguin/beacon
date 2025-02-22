defmodule Beacon.Loader.ModuleLoader do
  def load(module, code_string) do
    :code.delete(module)
    :code.purge(module)

    Code.compile_string(code_string)
    {:module, ^module} = Code.ensure_loaded(module)
    :ok
  end

  def import_my_component(component_module, functions) do
    if Enum.any?(functions, &String.match?(&1, ~r/my_component/)) do
      "import #{component_module}, only: [my_component: 2]"
    else
      ""
    end
  end
end
