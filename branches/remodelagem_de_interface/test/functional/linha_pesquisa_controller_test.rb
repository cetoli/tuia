require File.dirname(__FILE__) + '/../test_helper'
require 'linha_pesquisa_controller'

# Re-raise errors caught by the controller.
class LinhaPesquisaController; def rescue_action(e) raise e end; end

class LinhaPesquisaControllerTest < Test::Unit::TestCase
  def setup
    @controller = LinhaPesquisaController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
