require 'rmsgen'

describe Rmsgen::IMAPClient do
  let(:imap_options) do
    { 
      'imap_server' => 'mail.example.com',
      'imap_login' => 'login',
      'imap_password' => 'password'
    }
  end

  it 'authenticates with the server' do
    net_imap_instance = mock
    Net::IMAP.should_receive(:new).with('mail.example.com').and_return(net_imap_instance)
    net_imap_instance.should_receive(:authenticate).with('LOGIN', 'login', 'password').and_return(nil)
    imap_client = Rmsgen::IMAPClient.new(imap_options)
    imap_client.authenticate
  end

  context 'fetches messages from the inbox' do
    before do
      @net_imap_instance = mock(:search => [], :select => [])
      @message_collection = mock(:message_collection)
      Net::IMAP.should_receive(:new).with('mail.example.com').and_return(@net_imap_instance)
      @client = Rmsgen::IMAPClient.new(imap_options)
      @client.should_receive(:authenticate).once
    end

    after do
      @client.fetch_polnote_messages_from_inbox
    end

    it 'delegates select to the imap client' do
      @net_imap_instance.should_receive(:select).once.with('INBOX')
    end

    it 'delegates search to ' do
      @net_imap_instance.should_receive(:search).once.with(["FROM", 'rms@gnu.org'])
    end

    it 'delegates fetch to imap client and uses RFC822' do
      @net_imap_instance.should_receive(:search).and_return([1])
      fetch_result = [mock(:notes, :attr => { "RFC822" => 'Hello World'} )]
      @net_imap_instance.should_receive(:fetch).once.with(1, 'RFC822').and_return(fetch_result)
    end
  end

  context 'finding a single message body' do
    let(:net_imap_instance) { mock(:net_imap, :select => nil, :fetch => []) }
    let(:client) do
      Rmsgen::IMAPClient.new(imap_options)
    end

    before do
      Net::IMAP.should_receive(:new).with('mail.example.com').and_return(net_imap_instance)
    end

    after do
      client.find_by_id(1)
    end

    it 'delegates select to imap client' do
      net_imap_instance.should_receive(:select).once.with('INBOX')
    end

    it 'calls fetch for the id' do
      net_imap_instance.should_receive(:fetch).with(1, 'RFC822').once
    end
  end
end
