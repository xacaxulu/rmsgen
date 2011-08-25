module Rmsgen
  class IMAPPolnoteGroup
    require 'net/imap'

    def initialize(imap, options={})
      @imap = imap
      @server = options[:imap_server]
      @login  = options[:imap_login]
      @password = options[:imap_password]
    end

    def fetch_notes
      authenticate
      follow_inbox
      find_all_from_rms
    end

    private

    def authenticate
      @imap.authenticate('LOGIN', @login, @password)
    end

    def follow_inbox
      @imap.select 'INBOX' 
    end

    def find_all_from_rms
      message_ids = @imap.search ["FROM", 'rms@gnu.org']
      if message_ids && message_ids.any?
        message_ids.map { |id| fetch_message_body(id) }
      end
    end

    def fetch_message_body(id)
      fetch_result = @imap.fetch(id, 'BODY[TEXT]')
      if fetch_result && fetch_result.any?
        fetch_result[0].attr['BODY[TEXT]']
      end
    end
  end
end
