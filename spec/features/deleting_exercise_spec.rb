require "rails_helper"

RSpec.feature "Deleting Exercise" do
  before do
    @owner = User.create(email:"john@example.com", password:"password",first_name: "John", last_name:"Doe")
    login_as(@owner)

    @owner_exer = @owner.exercises.create!( duration_in_min: 45,
                                            workout: "Cardio activity",
                                            workout_date: Date.today)

  end

  scenario do

    visit "/"

    click_link "My Lounge"
    link= "//a[contains(@href,'/users/#{@owner.id}/exercises/#{@owner_exer.id}') and .//text()='Delete']"
    find(:xpath, link).click



    expect(page).to have_content("Exercise has been deleted")

    click_link "My Lounge"

    expect(page).not_to have_content(@owner_exer.workout)

  end

end