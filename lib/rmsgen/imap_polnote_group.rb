module Rmsgen
  class IMAPPolnoteGroup
    require 'net/imap'

    attr_reader :note_ids

    def initialize(options={})
      @imap_options = options
      @login  = options['imap_login']
      @password = options['imap_password']
      @note_ids = init_note_ids || []
    end

    def fetch_notes
      authenticate
      follow_inbox
      find_all_from_rms
    end

    def init_note_ids
      authenticate
      follow_inbox
      search_for_notes
    end

    def find(id)
      follow_inbox
      fetch_message_body(id)
    end

    def archive_polnote(id)
      follow_inbox
      move_to_archives(id)
    end

    private

    def move_to_archives(id)
      imap.copy id.to_i, 'INBOX.old-messages' 
      imap.store(id.to_i, "+FLAGS", [:Deleted])
      imap.expunge
    end

    def search_for_notes(&block)
      imap.search(["FROM", 'rms@gnu.org'],&block)
    end

    def imap
      @imap ||= Net::IMAP.new(@imap_options['imap_server'])
    end

    def authenticate
      imap.authenticate 'LOGIN', @login, @password 
    end

    def follow_inbox
      imap.select 'INBOX' 
    end

    def find_all_from_rms
      @note_ids.map { |id| fetch_message_body(id) }
    end

    def fetch_message_body(id)
      fetch_result = imap.fetch id, 'RFC822' 
      if fetch_result && fetch_result.any?
        fetch_result[0].attr['RFC822']
      end
    end
  end
end
