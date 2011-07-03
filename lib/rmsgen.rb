module Rmsgen
  require 'yaml'
  require 'erb'

  def self.root
    File.dirname(__FILE__)
  end

  def self.template_path
    root + '/templates'
  end

  require 'rmsgen/runtime'

  require 'rmsgen/polnote'
  require 'rmsgen/part_group'

  require 'rmsgen/compresser'
  require 'rmsgen/script'
  require 'rmsgen/inquirer'
  require 'rmsgen/titleizer'
  require 'rmsgen/url_merger'
end
