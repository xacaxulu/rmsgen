require 'rmsgen'
require 'net/imap'
require 'forwardable'

module Rmsgen
  class IMAPClient
    INBOX = 'INBOX'
    RMS_EMAIL = 'rms@gnu.org'
    RFC822 = 'RFC822'

    extend Forwardable

    def initialize(options)
      @server = options['imap_server']
      @login = options['imap_login']
      @password = options['imap_password']
      @imap_client = Net::IMAP.new(@server)
    end

    def_delegators :@imap_client, :select, :search, :fetch, :copy, :store, :expunge
  
    def authenticate
      @imap_client.authenticate('LOGIN', @login, @password)
    end

    def fetch_polnote_messages_from_inbox(&block)
      authenticate
      select INBOX
      find_all_from_rms(&block)
    end

    def find_by_id(id)
      select INBOX
      fetch_message_body(id)
    end

    private

    def find_all_from_rms
      search_for_notes.map do |id|
        if block_given?
          yield(fetch_message_body(id), id)
        else
          fetch_message_body(id)
        end
      end
    end

    def search_for_notes(&block)
      search(["FROM", RMS_EMAIL], &block)
    end

    def fetch_message_body(id)
      fetch_result = fetch id, RFC822
      if fetch_result && fetch_result.any?
        fetch_result[0].attr[RFC822]
      end
    end
  end
end
