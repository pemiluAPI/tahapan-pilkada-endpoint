class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
    	t.string :name
	    t.string :start
	    t.string :finish
	    t.string :parent_id
	    t.string :category
      t.timestamps
    end
  end
end
