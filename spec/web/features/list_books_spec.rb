require 'features_helper'

RSpec.describe 'List books' do
  let(:repository) { BookRepository.new }

  before do
    repository.clear

    repository.create(title: 'OOD', author: 'Sandi Metz')
    repository.create(title: 'TDD', author: 'Kent Beck')
  end
  it 'displays each book' do
    visit '/books'

    within '#books' do
      expect(page).to have_selector('.book', count: 2), 'Expected to find 2 books'
    end
  end
end
