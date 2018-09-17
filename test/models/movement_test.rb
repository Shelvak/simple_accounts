require 'test_helper'

class MovementTest < ActiveSupport::TestCase
  def setup
    @movement = Fabricate(:movement)
  end

  test 'create' do
    assert_difference ['Movement.count', 'PaperTrail::Version.count'] do
      Movement.create! Fabricate.attributes_for(:movement)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Movement.count' do
        @movement.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @movement.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Movement.count', -1) { @movement.destroy }
    end
  end

  test 'validates blank attributes' do
    @movement.attr = ''

    assert @movement.invalid?
    assert_equal 1, @movement.errors.size
    assert_equal_messages @movement, :attr, :blank
  end

  test 'validates unique attributes' do
    new_movement = Fabricate(:movement)
    @movement.attr = new_movement.attr

    assert @movement.invalid?
    assert_equal 1, @movement.errors.size
    assert_equal_messages @movement, :attr, :taken
  end
end
