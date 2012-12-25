# encoding: utf-8
require "./test/minitest_helper"

<% module_namespacing do -%>
class <%= class_name %>Test < MiniTest::Rails::ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
<% end -%>
