class CreateFigureTitles < ActiveRecord::Migration
  def up
    create_table :figure_titles do |t|
      t.integer :figure_id
      t.integer :title_id
    end
  end
end
