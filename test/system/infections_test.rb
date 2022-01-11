require "application_system_test_case"

class InfectionsTest < ApplicationSystemTestCase
  setup do
    @infection = infections(:one)
  end

  test "visiting the index" do
    visit infections_url
    assert_selector "h1", text: "Infections"
  end

  test "creating a Infection" do
    visit infections_url
    click_on "New Infection"

    click_on "Create Infection"

    assert_text "Infection was successfully created"
    click_on "Back"
  end

  test "updating a Infection" do
    visit infections_url
    click_on "Edit", match: :first

    click_on "Update Infection"

    assert_text "Infection was successfully updated"
    click_on "Back"
  end

  test "destroying a Infection" do
    visit infections_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Infection was successfully destroyed"
  end
end
