require 'spec_helper'


describe "Viewing todo items" do

	let!(:todo_list) { TodoList.create(title: "Grocery List", description: "Groceries")}
	

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end


	it "displays a title of todo list" do
		visit_todo_list(todo_list)
		within("h1") do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays no items when a todo list is empty" do
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)

	end

	it "displays content when todo list has items" do

		todo_list.todo_items.create(content: "Milk")
		todo_list.todo_items.create(content: "Fruit")

		visit_todo_list(todo_list)

		expect(page.all("ul.todo_items li").size).to eq(2)

		within "ul.todo_items" do
			expect(page).to have_content("Milk")
			expect(page).to have_content("Fruit")
		end

	end

end