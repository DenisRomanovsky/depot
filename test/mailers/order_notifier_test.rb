require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test 'received' do
    order = orders(:one)
    mail = OrderNotifier.received(order)
    assert_equal 'Depot Order Confirmation.', mail.subject
    assert_equal orders(:one).email, mail.to.first
    assert_equal ['denis@romanovsky.com'], mail.from
    assert_match '1 x Programming Ruby 1.9', mail.body.encoded
  end

  test 'shipped' do
    order = orders(:email_order)
    order.line_items.first.price = 99.99
    mail = OrderNotifier.shipped(order)
    assert_equal 'Depot Order Shipment.', mail.subject
    assert_equal orders(:email_order).email , mail.to.first
    assert_equal ['denis@romanovsky.com'], mail.from
    assert_match 'Programming Ruby 1.9', mail.body.encoded
  end

end
