class AddPaperRefToAuthors < ActiveRecord::Migration
  def change
    add_reference :authors, :papers, index: true, foreign_key: true
  end
end
