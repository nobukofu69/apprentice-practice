require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new(
      title: "Todaaaaaaaaaaaaaaaaaa",
      description: "Ever wonder how?",
      body: "You have to believe",
    )
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "title should be present" do
    @article.title = "    "
    assert_not @article.valid?
  end

  test "description should be present" do
    @article.description = "    "
    assert_not @article.valid?
  end

  test "body should be present" do
    @article.body = "    "
    assert_not @article.valid?
  end
end
