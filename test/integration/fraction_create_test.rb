require 'test_helper'

class FractionCreateTest < ActionDispatch::IntegrationTest
  test "found fraction as character" do
    fraction_name = 'Pristina'
    act_as characters(:haakon_vii)
    visit root_path

    click_link @current_character.name

    click_button '+'
    fill_in 'fraction[name]', with: fraction_name
    click_button 'Submit'

    within '#founded-fractions-list' do
      assert_text fraction_name

      click_link fraction_name
    end
    assert_text "founded by #{ @current_character.name }"
  end

  test "found fraction as fraction" do
    fraction_name = 'Liberia'
    parent_name = fractions(:united_states).name
    act_as characters(:james_monroe)
    visit root_path

    click_link @current_character.name

    within '#fractions-list' do
      click_link parent_name
    end

    click_link 'Children'

    click_button '+'
    fill_in 'fraction[name]', with: fraction_name
    click_button 'Submit'

    within '.list' do
      assert_text fraction_name

      click_link fraction_name
    end
    assert_text "founded by #{ parent_name }"
  end
end