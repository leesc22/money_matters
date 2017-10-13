class CreateInvestments < ActiveRecord::Migration[5.1]
  def change
    create_table :investments do |t|
    	t.belongs_to :user, optional: true, index: true, foreign_key: true
    	t.decimal :initial_amount, default: 0
    	t.integer :interest_rate, default: 0
    	t.string :interest_rate_period, default: 'yearly'
    	t.integer :period, null: false
    	t.string :period_type, default: 'years'
    	t.decimal :regular_amount, default: 0
    	t.string :regular_period, default: 'monthly'
    	t.string :compounding_period, default: 'yearly'
      t.decimal :total_investment
      t.decimal :total_interest
      t.decimal :future_value
      t.timestamps
    end
  end
end
