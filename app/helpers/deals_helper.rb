# frozen_string_literal: true

module DealsHelper
  def deal_statuses
    Deal.statuses.keys.map { |key| [key.to_s.humanize, key] }
  end

  def deal_statuses
    Deal.statuses.keys
  end

  def board_colors
    {
      'agreement_start': { bg_color: 'bg-surf-blue', text_color: 'text-white' },
      'agreement_signed': { bg_color: 'bg-storm-grays', text_color: 'text-dark' },
      'initiated': { bg_color: 'bg-purple', text_color: 'text-white' },
      'checklist_sent': { bg_color: 'bg-turquoise', text_color: 'text-dark' },
      'waiting_on_docs': { bg_color: 'bg-warning', text_color: 'text-white' },
      'submitted': { bg_color: 'bg-info', text_color: 'text-white' },
      'approved': { bg_color: 'bg-flamingo', text_color: 'text-white' },
      'sent': { bg_color: 'bg-ocean-blue', text_color: 'text-white' },
      'paid': { bg_color: 'bg-mint', text_color: 'text-dark' },
      'closed': { bg_color: 'bg-red', text_color: 'text-white' }
    }.with_indifferent_access
  end
end
