require 'test_helper'

class HelpfulLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @helpful_link = helpful_links(:one)
  end

  test "should get index" do
    get helpful_links_url
    assert_response :success
  end

  test "should get new" do
    get new_helpful_link_url
    assert_response :success
  end

  test "should create helpful_link" do
    assert_difference('HelpfulLink.count') do
      post helpful_links_url, params: { helpful_link: { url: @helpful_link.url } }
    end

    assert_redirected_to helpful_link_url(HelpfulLink.last)
  end

  test "should show helpful_link" do
    get helpful_link_url(@helpful_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_helpful_link_url(@helpful_link)
    assert_response :success
  end

  test "should update helpful_link" do
    patch helpful_link_url(@helpful_link), params: { helpful_link: { url: @helpful_link.url } }
    assert_redirected_to helpful_link_url(@helpful_link)
  end

  test "should destroy helpful_link" do
    assert_difference('HelpfulLink.count', -1) do
      delete helpful_link_url(@helpful_link)
    end

    assert_redirected_to helpful_links_url
  end
end
