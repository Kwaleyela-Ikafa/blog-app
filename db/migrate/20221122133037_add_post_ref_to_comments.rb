class AddPostRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :posts, foreign_key: { to_table: :posts }, index: true
  end
end
