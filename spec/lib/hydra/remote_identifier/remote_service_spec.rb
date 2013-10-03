require File.expand_path('../../../../../lib/hydra/remote_identifier/remote_service', __FILE__)

module Hydra::RemoteIdentifier

  describe RemoteService do

    describe 'instance methods' do
      let(:payload) { 'abc' }
      subject { RemoteService.new }
      it { expect { subject.call(payload) }.to raise_error NotImplementedError }
      it { expect { subject.valid_attribute?(:attribute_name) }.to raise_error NotImplementedError }
    end
  end

end