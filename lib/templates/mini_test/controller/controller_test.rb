# encoding: utf-8
require "./test/minitest_helper"

<% module_namespacing do -%>
class <%= class_name %>ControllerTest < MiniTest::Rails::ActionController::TestCase
<% if actions.empty? -%>
  # test "the truth" do
  #   assert true
  # end
<% else -%>
<% actions.each do |action| -%>
  test "should get <%= action %>" do
    get :<%= action %>
    assert_response :success
  end

<% end -%>
<% end -%>
end
<% end -%>
