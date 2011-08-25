require 'rmsgen'

describe Rmsgen::IMAPPolnoteGroup do
  context 'fetching notes' do
    let(:imap) { double('imap') }
    let(:options) do { 
        :imap_login  => 'login',
        :imap_password => 'password'} 
    end

    let(:do_fetch) do
      Rmsgen::IMAPPolnoteGroup.new(imap, options).fetch_notes
    end

    it 'authenticates with imap server' do
      imap.stub(:search)
      imap.stub(:select)
      imap.should_receive(:authenticate).with('LOGIN', 'login', 'password')
      do_fetch
    end

    it 'selects the inbox folder' do
      imap.stub(:authenticate)
      imap.stub(:search)
      imap.should_receive(:select).with('INBOX')
      do_fetch
    end

    it 'searches for messages from rms' do
      imap.stub(:authenticate)
      imap.stub(:select)
      imap.should_receive(:search).with(["FROM", 'rms@gnu.org'])
      do_fetch
    end

    it 'fetches each message' do
      message_id = double('message_id')
      search_result = [message_id] 

      imap.stub(:search) { search_result }
      imap.stub(:authenticate)
      imap.stub(:select)

      imap.should_receive(:fetch).with(message_id, 'BODY[TEXT]')
      do_fetch
    end

    it 'asks for the message body' do
      imap.stub(:authenticate)
      imap.stub(:select)
      imap.stub(:search)

      struct = double('mock')
      struct.stub(:attr) { {"BODY[TEXT]"=>"hello world"}}
      fetch_result = double('fetch_result')
      fetch_result.stub(:[]) { struct }

      imap.stub(:fetch) { fetch_result }

      do_fetch
    end
  end
end
