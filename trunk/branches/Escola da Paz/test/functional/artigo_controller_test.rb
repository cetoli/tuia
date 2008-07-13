require File.dirname(__FILE__) + '/../test_helper'
require 'artigo_controller'

# Re-raise errors caught by the controller.
class ArtigoController; def rescue_action(e) raise e end; end

class ArtigoControllerTest < Test::Unit::TestCase
  def setup
    @controller = ArtigoController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
