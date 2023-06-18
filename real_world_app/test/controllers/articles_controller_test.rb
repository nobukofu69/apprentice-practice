require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = Article.new(
      title: "test1",
      description: "This is test",
      body: "You have to believe",
    )
    @article.save
  end

  # Create Article
  test "should create article" do
    assert_difference('Article.count', 1) do
      post articles_url, params: {
        article: {
          title: "How to train your dragon",
          description: "Ever wonder how?",
          body: "You have to believe"
        }
      }
    end
    assert_response :created
  end

  # Get Article
  test "should get article" do
    get article_url(@article.slug)
    assert_response :ok
  end

  # Update Article
  test "should update article" do
    put article_url(@article.slug), params: {
      article: {
        title: "Updateしました!!!!!!!!!!!!",
        description: "Ever wonder how?",
        body: "You have to believe"
      }
    }
    assert_response :ok
  end

  # Delete Article
  test "should delete article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article.slug)
      assert_response :no_content
    end
  end
end
