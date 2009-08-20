require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'EC2.associate_address' do
  describe 'success' do

    before(:each) do
      @instance_id = ec2.run_instances('ami-5ee70037', 1, 1).body['instancesSet'].first['instanceId']
      @public_ip = ec2.allocate_address.body['publicIp']
    end

    after(:each) do
      ec2.release_address(@public_ip)
      ec2.terminate_instances([@instance_id])
    end

    it "should return proper attributes" do
      actual = ec2.associate_address(@instance_id, @public_ip)
      actual.body['requestId'].should be_a(String)
      [false, true].should include(actual.body['return'])
    end

  end
end