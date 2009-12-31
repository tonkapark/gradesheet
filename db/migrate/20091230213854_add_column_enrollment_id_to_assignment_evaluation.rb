class AddColumnEnrollmentIdToAssignmentEvaluation < ActiveRecord::Migration
  def self.up
    add_column :assignment_evaluations, :enrollment_id, :integer
    add_index :assignment_evaluations, :enrollment_id
  end

  def self.down
    remove_column :assignment_evaluations, :enrollment_id
  end
end
