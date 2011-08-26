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
      let(:imap) { mock(:imap) }
      let(:search_result) { mock(:search_result) }

      it 'fetches the note' do
        $stdout = StringIO.new
        $stdin = FakeGet.new('hello')
        Net::IMAP.should_receive(:new).with('mail.test.org') { imap }
        runtime.any_instance.stub(:system)
        imap_note = mock(:note)
        notes = [imap_note] 

        imap_note.stub(:attr) { {"BODY[TEXT]"=>"hello world"} }
        imap.stub(:authenticate)
        imap.stub(:select)

        imap.stub(:search) { [search_result] }
        imap.stub(:fetch) { notes }
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
