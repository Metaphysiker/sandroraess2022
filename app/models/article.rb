require 'tree'                 # Load the library


class Article < ApplicationRecord
  has_one_attached :featured_image
  extend FriendlyId
  friendly_id :title, use: :slugged

  before_save :modify_content


  def modify_content

    root = Tree::TreeNode.new('root', self.title)

    #h2 << Tree::TreeNode.new("CHILD2", "Child2 Content")

    #h1.print_tree

    puts "treenode"
    #puts h1


    doc = Nokogiri::HTML.fragment(self.content)
    table_of_content = ""

    current_heading_level = 1
    current_node = root
    last_node = root

    doc.css("h1, h2, h3, h4, h5, h6").each do |node|

      heading_level = node.name.delete("^0-9").to_i
      puts heading_level

      #if heading_level is the same as current_level add to children of last node
      if heading_level == current_heading_level
        new_node = Tree::TreeNode.new(node.content, node.content)
        last_node << new_node
        #current_node = new_node
        #last_node = new_node
        #current_heading_level = heading_level

      #
      elsif heading_level < current_heading_level
        new_node = Tree::TreeNode.new(node.content, node.content)

        last_node << new_node
        current_node = new_node

        current_heading_level = heading_level

      else
        new_node = Tree::TreeNode.new(node.content, node.content)

        current_node = root
        current_node << new_node
        current_heading_level = heading_level
      end


      times_of_space = node.name.delete("^0-9").to_i
      puts "node"
      #puts node.attributes
      #puts node.methods
      #puts node.name
      #puts node.children.count
      #puts node.children[0].content
      node['id'] = node.content.parameterize

      times_of_space_string = ""
      times_of_space.times do |time|
          times_of_space_string += "&nbsp;&nbsp;&nbsp;&nbsp;"
      end
link = <<~EOF
      <a href="##{node.content.parameterize}">#{node.content}</a>
      <br>
EOF

      table_of_content = table_of_content + times_of_space_string + link
    end

    #https://developer.squareup.com/blog/challenge-table-of-contents-generator/
    self.modified_content = table_of_content + "<hr>" + doc.to_html

    root.print_tree
  end

end
