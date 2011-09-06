require 'yaml'
require 'erb'

module Rmsgen
  %w{ part_group
      polnote
      titleizer
      compresser
      script
      inquirer
      runtime
      link
      imap_polnote_group
      fs_polnote_group
  }.each do |fname|
    require File.join(File.dirname(__FILE__), 'rmsgen', fname)
  end
end



