RSpec.describe AddBook do
  let(:interactor) { AddBook.new }
  let(:attributes) { Hash[author: 'James Baldwin', title: 'The fire next time'] }

  context 'good input' do
    let(:result) { interactor.call(attributes) }

    it 'succeeds' do
      expect(result.successful?).to be_truthy
    end

    it 'creates a book with correct title and author' do
      expect(result.book.title).to eq('The fire next time')
      expect(result.book.author).to eq('James Baldwin')
    end

    context 'persistence' do
      let(:repository) { instance_double('BookRepository') }

      it 'persists the book' do
        expect(repository).to receive(:create)
        AddBook.new(repository: repository).call(attributes)
      end
    end

    context 'send email' do
      let(:mailer) { instance_double('Mailers::BookAddedNotification') }

      it 'send :deliver to the mailer' do
        expect(mailer).to receive(:deliver)
        AddBook.new(mailer: mailer).call(attributes)
      end
    end
  end
end
