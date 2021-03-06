require "rails_helper"

RSpec.describe Mention, type: :model do
  let(:comment) { create(:comment, commentable: create(:podcast_episode)) }

  describe "#create_all" do
    it "enqueues a job to create mentions" do
      assert_enqueued_with(job: Mentions::CreateAllJob, args: [comment.id, "Comment"], queue: "mentions_create_all") do
        described_class.create_all(comment)
      end
    end
  end

  # TODO: Replace this test with validation spec
  it "creates a valid mention" do
    expect(create(:mention)).to be_valid
  end

  # TODO: Replace this test with validation spec
  it "doesn't raise undefined method for NilClass on valid?" do
    expect(described_class.new.valid?).to eq(false)
  end
end
