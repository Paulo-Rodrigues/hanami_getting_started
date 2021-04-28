RSpec.describe Web::Controllers::Books::Create, type: :action do
  let(:interactor) { instance_double('AddBook', call: nil) }
  let(:action) { described_class.new(interactor: interactor) }
  let(:params) { Hash[book: { title: 'Title', author: 'Self' }] }
  # let(:repository) { BookRepository.new }

  # before do
  #   repository.clear
  # end

  it 'calls interactor' do
    expect(interactor).to receive(:call)
    action.call(params)
  end

  # it 'creates a new book' do
  #   action.call(params)
  #   book = repository.last
  #
  #   expect(book.id).to_not be_nil
  # end

  it 'redirects the user to the books listing' do
    response = action.call(params)

    expect(response[0]).to eq(302)
    expect(response[1]['Location']).to eq('/books')
  end

  context 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it 'does not call interactor' do
      expect(interactor).to_not receive(:call)
      action.call(params)
    end

    it 're-renders the books#new view'do
      response = action.call(params)
      expect(response[0]).to eq(422)
    end

    it 'sets errors attribute accordingly' do
      action.call(params)
      errors = action.params.errors

      expect(errors.dig(:book, :title)).to eq(['is missing'])
      expect(errors.dig(:book, :author)).to eq(['is missing'])
    end
  end
end
