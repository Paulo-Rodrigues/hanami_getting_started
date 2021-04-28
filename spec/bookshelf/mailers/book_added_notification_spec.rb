RSpec.describe Mailers::BookAddedNotification, type: :mailer do
  let(:mail) { Mailers::BookAddedNotification }

  before { Hanami::Mailer::deliveries.clear }

  it 'has correct `from` email address' do
    expect(mail.from).to eq('no-reply@example.com')
  end

  it 'has correct `to` email address' do
    expect(mail.to).to eq('admin@example.com')
  end

  it 'has correct `mail`' do
    expect(mail.subject).to eq('Book added!')
  end

  it 'delivers mail' do
    expect { mail.deliver }
      .to change { Hanami::Mailer.deliveries.length }.by(1)
  end
end
