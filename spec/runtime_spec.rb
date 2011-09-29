require 'rmsgen'
require 'fake_gets'

describe Rmsgen::Runtime do
  context 'configured for imap server' do

    let(:config) do
      { 'imap_server' => 'mail.test.org',
        'imap_login'  => 'login',
        'imap_password' => 'password' }
    end

    context 'when and there is a note' do
      let(:runtime) { Rmsgen::Runtime }
      let(:imap) { stub(:imap) }

      it 'fetches the note' do
        $stdout = StringIO.new
        $stdin = FakeGet.new('hello')
        Rmsgen::IMAPClient.should_receive(:new).and_return(imap)
        imap.should_receive(:fetch_polnote_messages_from_inbox).and_return([])
        expect { runtime.new(config).run! }.to_not raise_error
      end
    end

    context 'when there are no notes' do
      let(:imap) { mock(:imap) }
      let(:runtime) { Rmsgen::Runtime }

      it 'reports that no messages were found' do
        Net::IMAP.should_receive(:new).with('mail.test.org') { imap }
        imap.stub(:authenticate)
        imap.stub(:select)
        $stdout = StringIO.new

        imap.stub(:search) { [] }
        runtime.new(config).run!
        $stdout.string.should include 'no polnotes in queue'
      end
    end
  end
end
