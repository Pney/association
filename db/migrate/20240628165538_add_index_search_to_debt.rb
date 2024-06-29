class AddIndexSearchToDebt < ActiveRecord::Migration[7.1]
  def change
    add_index :debts, :amount, where: "amount > 100000", name: 'index_amount_gt_100000'
  end
end
