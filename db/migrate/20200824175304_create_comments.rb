class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.re
      t.text :message

      t.timestamps
    end
  end
end
