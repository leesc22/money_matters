class CreateInvestments < ActiveRecord::Migration[5.1]
  def change
    create_table :investments do |t|
    	t.belongs_to :user, index: true, foreign_key: true
    	t.integer :initial_amount, default: 0
    	t.integer :interest_rate, default: 0
    	t.string :interest_rate_period, default: 'yearly'
    	t.integer :period, null: false
    	t.integer :period_type, default: 'years'
    	t.integer :regular_amount, default: 0
    	t.string :regular_period, default: 'monthly'
    	t.string :compounding_period, default: 'yearly'
      t.timestamps
    end
  end
end
