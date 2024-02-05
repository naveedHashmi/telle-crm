# frozen_string_literal: true

module ActivitiesHelper
  def activity_assignee_path(activity)
    activity.assignee_type == 'Client' ? client_path(activity.assignee_id) : lead_path(activity.assignee_id)
  end

  def status_action_path(activity)
    if activity.status == 'Complete'
      uncomplete_activity_path(activity,
                               format: :js)
    else
      complete_activity_path(activity,
                             format: :js)
    end
  end

  def status_action_text(activity)
    activity.status == 'Complete' ? 'Uncomplete' : 'Complete'
  end

  def status_action_class(activity)
    activity.status == 'Uncomplete' ? 'btn btn-success' : 'btn btn-danger'
  end
end
