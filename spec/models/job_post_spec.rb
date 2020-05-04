require 'rails_helper'

# matchers docs https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers

RSpec.describe JobPost, type: :model do
  describe "validates" do
    it "requires a title" do
      # Given
      job_post = JobPost.new

      # When
      job_post.valid?

      # Then
      # expect is is passed a value we're asserting
      # we can chain .to()
      # .to() accepts a assertion/expectation clause
      expect(job_post.errors.messages).to(have_key(:title))
    end

    it "title is unique" do
      persisted_job_post = JobPost.create(title: "full stack dev")
      job_post = JobPost.new(title: persisted_job_post.title)

      job_post.valid?

      expect(job_post.errors.messages).to(have_key(:title))
    end

    it "requires a description" do
      job_post = JobPost.new

      job_post.valid?

      expect(job_post.errors.messages).to(have_key(:description))
    end

    it "salary_min must be a number greater than 30_000" do
      job_post = JobPost.new(min_salary: 25_000)

      job_post.valid?

      # the error object on models have a method details that returns a hash with keys equal to columns that have errors. The value of those keys are an array of error messages each with a error key whose value is a validation symbol
      expect(job_post.errors.details[:min_salary][0][:error]).to(be(:greater_than_or_equal_to))
    end
  end
end
