# frozen_string_literal: true

require 'test_helper'

module Users
  class SurvivorControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get users_survivor_index_url
      assert_response :success
    end
  end
end
