require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'SimpleDB.put_attributes' do
  describe 'success' do

    before(:each) do
      @domain_name = "fog_domain_#{Time.now.to_i}"
      sdb.create_domain(@domain_name)
    end

    after(:each) do
      sdb.delete_domain(@domain_name)
    end

    it 'should return proper attributes from put_attributes' do
      actual = sdb.put_attributes(@domain_name, 'foo', { 'bar' => 'baz' })
      actual.body['RequestId'].should be_a(String)
      actual.body['BoxUsage'].should be_a(Float)
    end

  end
end
