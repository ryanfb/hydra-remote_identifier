require File.expand_path('../../../../../lib/hydra/remote_identifier/minting_coordinator', __FILE__)

module Hydra::RemoteIdentifier
  describe MintingCoordinator do
    let(:remote_service) { Class.new { def self.valid_attribute?(*); true; end } }
    let(:mapper_builder) { double(new: double(call: :wrapped_target)) }
    let(:target) { double }
    let(:map) { lambda {|*|} }
    subject { MintingCoordinator.new(remote_service, mapper_builder, &map) }
    it 'forward delegates call to the minter' do
      minter = double
      minter.should_receive(:call).with(remote_service, :wrapped_target)
      subject.call(target, minter)
    end
  end
end