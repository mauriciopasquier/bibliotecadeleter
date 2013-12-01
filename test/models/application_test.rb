# encoding: utf-8
require './test/test_helper'

describe BibliotecaDelEter::Application do
  subject { BibliotecaDelEter::Application.config }

  describe 'session_store' do
    it 'usa memcached' do
      subject.session_store.must_equal ActionDispatch::Session::LibmemcachedStore
    end
  end

  describe 'cache' do
    it 'usa memcached' do
      Rails.cache.class.must_equal ActiveSupport::Cache::LibmemcachedStore
    end
  end
end
