require "middleman-core"
require "middleman-gemoji/version"

::Middleman::Extensions.register(:gemoji) do
  require "middleman-gemoji/extension"
  ::Middleman::Gemoji::Extension
end
