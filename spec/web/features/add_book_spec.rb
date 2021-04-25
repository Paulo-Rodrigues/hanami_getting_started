require 'features_helper'

RSpec.describe 'Add a Book' do
  after do
    BookRepository.new.clear
  end

  it 'can create a new book' do
    visit '/books/new'

    within 'form#book-form' do
      fill_in 'Title', with: 'Some Title'
      fill_in 'Author', with: 'Myself'

      click_button 'Create'
    end

    expect(page).to have_current_path('/books')
    expect(page).to have_content('Some Title')
  end
end
