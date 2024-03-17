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
      id = message.id
      user_message = service.get_user_message('me', id)
      payload = user_message.payload
      headers = payload.headers

      date = headers.any? { |h| h.name == 'Date' } ? headers.find { |h| h.name == 'Date' }.value : ''
      from = headers.any? { |h| h.name == 'From' } ? headers.find { |h| h.name == 'From' }.value : ''
      to = headers.any? { |h| h.name == 'To' } ? headers.find { |h| h.name == 'To' }.value : ''
      subject = headers.any? { |h| h.name == 'Subject' } ? headers.find { |h| h.name == 'Subject' }.value : ''
      data = if user_message.payload.parts
               get_html(user_message.payload.parts)
             else
               payload.body.data
             end

      list << { date:, from:, to:, subject:, id:, data: }.with_indifferent_access
    end

    list
  end

  def get_html(parts)
    x = 0
    while x <= parts.length

      return get_html(parts[x].parts) unless parts[x].parts.blank?

      return parts[x].body.data if parts[x].mime_type == 'text/html'

      x += 1
    end
    ''
  end
end
