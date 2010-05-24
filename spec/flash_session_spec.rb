require 'spec_helper'

describe Rack::FlashSession do
  def app(*args)
    Rack::Builder.new {
      use Rack::Lint
      use Rack::FlashSession, *args
      run lambda {|env| [200, {'Content-Type' => 'text/html'}, ['']] }
    }.to_app
  end

  def env_for(params = {}, options={})
    Rack::MockRequest.env_for('', options.merge(:params => params))
  end

  def do_call(params, options, *args)
    env = env_for(params, options)
    app(*args).call(env)
    Rack::Request.new(env)
  end

  context 'flash request' do
    def request(params, *args)
      options = {'HTTP_USER_AGENT' => 'Adobe Flash'}
      do_call(params, options, *args)
    end

    describe 'default _session_id' do
      subject {request({'_session_id' => '12345'})}
      its(:cookies){should == {'_session_id' => '12345'}}
    end

    describe 'custom session id' do
      subject {request({'my_session_id' => '12345'}, 'my_session_id')}
      its(:cookies){should == {'my_session_id' => '12345'}}
    end

    describe 'multiple cookies' do
      subject {request({'my_session_id' => '12345', 'my_other_session_id' => '54321'}, 'my_session_id', 'my_other_session_id')}
      its(:cookies){should include({'my_session_id' => '12345'})}
      its(:cookies){should include({'my_other_session_id' => '54321'})}
      its(:cookies){should have(2).items}
    end
  end

  context 'non flash request' do
    def request(params, *args)
      options = {'HTTP_USER_AGENT' => 'some browser'}
      do_call(params, options, *args)
    end

    subject {request({'_session_id' => '12345'})}
    its(:cookies){should be_empty}
  end
end
