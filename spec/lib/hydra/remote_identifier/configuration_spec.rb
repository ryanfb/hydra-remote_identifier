require File.expand_path('../../../../../lib/hydra/remote_identifier/configuration', __FILE__)

module Hydra::RemoteIdentifier

  describe Configuration do
    around do |example|
      module RemoteServices
        class MyRemoteService
          class << self
            attr_reader :options
            def configure(*args, &block)
              @options = [args, block]
            end
          end
        end
      end
      example.run
      RemoteServices.send(:remove_const, :MyRemoteService)
    end

    subject { Configuration.new }

    context 'with a missing service' do
      specify do
        expect { subject.register_remote_service(:obviously_missing_service) }.to raise_error(NotImplementedError)
      end
      specify do
        expect {
          subject.remote_service(:obviously_missing_service)
        }.to raise_error(NotImplementedError)
      end
    end

    context 'with an existing service' do
      let(:block) { lambda {} }
      specify do
        expect {
          subject.register_remote_service(:my_remote_service, :arg, &block)
        }.to change(RemoteServices::MyRemoteService, :options).from(nil).to([[:arg], block])
      end
      specify do
        expect(subject.remote_service(:my_remote_service)).to be_an_instance_of(RemoteServices::MyRemoteService)
      end
    end

  end

end