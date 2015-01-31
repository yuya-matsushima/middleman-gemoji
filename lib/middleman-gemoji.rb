require 'middleman-core'
require 'middleman-gemoji/version'
require 'middleman-gemoji/command'

::Middleman::Extensions.register(:gemoji) do
  require 'middleman-gemoji/extension'
  ::Middleman::Gemoji::Extension
end
