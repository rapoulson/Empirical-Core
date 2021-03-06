class ProgressReports::ActivitySessionSerializer  < ActiveModel::Serializer
  attributes :id,
             :activity_classification_name,
             :activity_classification_id,
             :activity_name,
             :completed_at,
             :time_spent,
             :percentage,
             :display_score,
             :display_completed_at,
             :display_time_spent,
             :classroom_id,
             :unit_id,
             :student_name,
             :student_id,
             :standard

  def activity_classification_name
    object.activity.classification.name
  end

  def activity_classification_id
    object.activity.classification.id
  end

  def activity_name
    object.activity.name
  end

  def completed_at
    object.completed_at.try(:to_i)
  end

  def time_spent
    object.time_spent
  end

  def display_score
    object.percentage_as_percent
  end

  def display_completed_at
    object.completed_at.try(:to_formatted_s, :quill_default)
  end

  def display_time_spent
    time_spent_in_sec = time_spent
    (time_spent_in_sec / 60).to_i.to_s + ' minutes' if time_spent_in_sec.present?
  end

  # Following fields are used by the filters

  def classroom_id
    object.classroom_activity.try(:classroom_id)
  end

  def classroom_name
    object.classroom_activity.try(:classroom).try(:name)
  end

  def unit_id
    object.classroom_activity.try(:unit).try(:id)
  end

  def unit_name
    object.classroom_activity.try(:unit).try(:name)
  end

  def student_name
    object.user.name
  end

  def student_id
    object.user_id
  end

  def standard
    if object.activity.topic.present?
      object.activity.topic.name.split(' ').first
    end
  end
end