module Rmsgen
  class IMAPPolnoteGroup

    def initialize(imap_client)
      @imap_client = imap_client
    end

    def all
      @imap_client.fetch_polnote_messages_from_inbox do |body, id|
        Polnote.new :body => body, :id => id
      end
    end

    def find(id)
      follow_inbox
      fetch_message_body(id)
    end

    def archive_polnote(id)
      @imap_client.authenticate 
      follow_inbox
      move_to_archives(id)
    end

    private
    
    def move_to_archives(id)
      @imap_client.copy id.to_i, 'INBOX.old-messages' 
      @imap_client.store(id.to_i, "+FLAGS", [:Deleted])
      @imap_client.expunge
    end

    def follow_inbox
      @imap_client.select 'INBOX' 
    end
  end
end
