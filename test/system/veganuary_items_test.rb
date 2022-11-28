require "application_system_test_case"

class VeganuaryItemsTest < ApplicationSystemTestCase
  setup do
    @veganuary_item = veganuary_items(:one)
  end

  test "visiting the index" do
    visit veganuary_items_url
    assert_selector "h1", text: "Veganuary items"
  end

  test "should create veganuary item" do
    visit veganuary_items_url
    click_on "New veganuary item"

    fill_in "Addresses", with: @veganuary_item.addresses
    fill_in "Company description", with: @veganuary_item.company_description
    fill_in "Company name", with: @veganuary_item.company_name
    fill_in "Offer", with: @veganuary_item.offer
    fill_in "Url", with: @veganuary_item.url
    click_on "Create Veganuary item"

    assert_text "Veganuary item was successfully created"
    click_on "Back"
  end

  test "should update Veganuary item" do
    visit veganuary_item_url(@veganuary_item)
    click_on "Edit this veganuary item", match: :first

    fill_in "Addresses", with: @veganuary_item.addresses
    fill_in "Company description", with: @veganuary_item.company_description
    fill_in "Company name", with: @veganuary_item.company_name
    fill_in "Offer", with: @veganuary_item.offer
    fill_in "Url", with: @veganuary_item.url
    click_on "Update Veganuary item"

    assert_text "Veganuary item was successfully updated"
    click_on "Back"
  end

  test "should destroy Veganuary item" do
    visit veganuary_item_url(@veganuary_item)
    click_on "Destroy this veganuary item", match: :first

    assert_text "Veganuary item was successfully destroyed"
  end
end
