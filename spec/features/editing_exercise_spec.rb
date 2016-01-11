require "rails_helper"

RSpec.feature "Creating Exercise" do
  before do
    @owner = User.create(email:"john@example.com", password:"password")
    login_as(@owner)

    @owner_exer = @owner.exercises.create!( duration_in_min: 45,
                                            workout: "Cardio activity",
                                            workout_date: Date.today)

  end
  scenario "with valid inputs succeeds" do
    visit "/"

    click_link "My Lounge"
    link= "a[href='/users/#{@owner.id}/exercises/#{@owner_exer.id}/edit']"
    find(link).click
    fill_in "Duration", with: 50

    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(50)
    expect(page).not_to have_content(45)
  end
end