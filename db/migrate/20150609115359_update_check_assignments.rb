class UpdateCheckAssignments < ActiveRecord::Migration
  def up
    say_with_time "creating check history" do
      ProjectCheck.find_each do |pc|
        create_assignment pc
      end
    end
  end

  def down
    say_with_time "reverting check history" do
      ProjectCheck.find_each do |pc|
        update_project_check pc
      end
      CheckAssignment.delete_all
    end
  end

  private

  def create_assignment(pc)
    return if pc.last_check_user_id.nil? || pc.last_check_date.nil?
    CheckAssignment.create(
      project_check_id: pc.id,
      user_id: pc.last_check_user_id,
      completion_date: pc.last_check_date
    )
  end

  def update_project_check(pc)
    assignment = pc.check_assignments.first
    return if assignment.nil?
    pc.update_attributes(
      last_check_user_id: assignment.user_id,
      last_check_date: assignment.completion_date
    )
  end
end
