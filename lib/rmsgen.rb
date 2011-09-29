require 'yaml'
require 'erb'

module Rmsgen
  %w{ header
      footer
      plain_text
      url
      polnote_url_request
      indented_line
      duration
  }.each do |fname|
    require File.join(File.dirname(__FILE__), 'rmsgen', 'parts', fname)
  end

  %w{ part_group
      polnote
      titleizer
      compresser
      script
      inquirer
      runtime
      part
      link
      imap_client
      imap_polnote_group
      fs_polnote_group
      polnote_group

  }.each do |fname|
    require File.join(File.dirname(__FILE__), 'rmsgen', fname)
  end
end
