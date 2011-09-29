require 'rmsgen'

describe Rmsgen::IMAPPolnoteGroup do
  context 'fetching notes from an imap server' do
    let(:imap) { double('imap client') }

    let(:set_imap_expectations_and_get_all) do
      imap.should_receive(:fetch_polnote_messages_from_inbox).any_number_of_times
      imap.should_receive(:authenticate).any_number_of_times
      imap.should_receive(:search).any_number_of_times
      Net::IMAP.should_receive(:new).any_number_of_times.and_return(imap)
      imap.should_receive(:select).any_number_of_times
      Rmsgen::IMAPPolnoteGroup.new(imap).all
    end

    after(:each) do
      set_imap_expectations_and_get_all
    end

    it 'selects the inbox folder' do
      imap.should_receive(:select).any_number_of_times.with('INBOX')
    end

    it 'fetches each message' do

    #  message_id = double('message_id')
    #  search_result = [message_id] 

    #  imap.stub(:search) { search_result }

    #  imap.should_receive(:fetch).with(message_id, 'RFC822')
    end
  end
end
