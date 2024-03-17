class GmailService
  attr_accessor :gclient, :current_user, :current_client

  def initialize(current_user, current_client)
    @current_user = current_user
    @current_client = current_client
  end

  def get_messages
    list = []
    client = Signet::OAuth2::Client.new(access_token: current_user.gmail_credentials['access_token'])
    service = Google::Apis::GmailV1::GmailService.new
    service.authorization = client
    messages_list = service.list_user_messages('me', max_results: 20, label_ids: ['INBOX'],
                                                     q: "from:#{current_client.email || ''} is:unread")
    messages_list.messages.each do |message|
      user_message = service.get_user_message('me', message.id)
      payload = user_message.payload
      headers = payload.headers

      date = headers.any? { |h| h.name == 'Date' } ? headers.find { |h| h.name == 'Date' }.value : ''
      from = headers.any? { |h| h.name == 'From' } ? headers.find { |h| h.name == 'From' }.value : ''
      to = headers.any? { |h| h.name == 'To' } ? headers.find { |h| h.name == 'To' }.value : ''
      subject = headers.any? { |h| h.name == 'Subject' } ? headers.find { |h| h.name == 'Subject' }.value : ''

      list << { date:, from:, to:, subject: }.with_indifferent_access
    end

    list
  end
end
