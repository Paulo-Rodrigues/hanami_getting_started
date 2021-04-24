RSpec.describe Book, type: :entity do
  it 'can be initialized with attributes' do
    book = described_class.new(title: 'Refactoring')
    expect(book.title).to eq('Refactoring')
  end
end
