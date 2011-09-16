require 'rmsgen'

describe Rmsgen::IMAPPolnoteGroup do
  context 'fetching notes' do
    let(:imap) { double('foo') }
    let(:options) do { 
        'imap_server' => 'foo.bar.com',
        'imap_login'  => 'login',
        'imap_password' => 'password'} 
    end

    let(:do_fetch) do
      imap.should_receive(:search).any_number_of_times
      imap.should_receive(:authenticate).any_number_of_times
      Net::IMAP.should_receive(:new).any_number_of_times.and_return(imap)
      imap.should_receive(:select).any_number_of_times
      Rmsgen::IMAPPolnoteGroup.new(options).fetch_notes
    end

    it 'authenticates with imap server' do
      imap.should_receive(:authenticate).any_number_of_times.with('LOGIN', 'login', 'password')
      do_fetch
    end

    it 'selects the inbox folder' do
      imap.should_receive(:select).any_number_of_times.with('INBOX')
      do_fetch
    end

    it 'searches for messages from rms' do
      imap.should_receive(:search).once.with(["FROM", 'rms@gnu.org'])
      do_fetch
    end

    it 'fetches each message' do
      message_id = double('message_id')
      search_result = [message_id] 

      imap.stub(:search) { search_result }

      imap.should_receive(:fetch).with(message_id, 'BODY[TEXT]')
      do_fetch
    end
  end
end
