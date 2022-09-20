require "rails_helper"
require "pundit/matchers"

describe EventPolicy do
  include Pundit::Authorization
  subject { described_class.new(user, event) }

  context "user is logged in" do
    let(:current_user) { User.new }
  
    context "and event's owner" do
      let(:event) { Event.new(user: current_user) }
      before { authorize(current_user, event) }

      describe "#show?" do
        it { is_expected.to permit_action(:show) }
      end

      describe "#edit?" do
        it { is_expected.to permit_action(:edit) }
      end

      describe "#update?" do
        it { is_expected.to permit_action(:update) }
      end

      describe "#destroy?" do
        it { is_expected.to permit_action(:destroy) }
      end
    end

    context "and not event's owner" do
      let(:event) { Event.new }
      before { authorize(current_user, event) }

      describe "#show?" do
        it { is_expected.to permit_action(:show) }
      end

      describe "#edit?" do
        it { is_expected.not_to permit_action(:edit) }
      end

      describe "#update?" do
        it { is_expected.not_to permit_action(:update) }
      end

      describe "#destroy?" do
        it { is_expected.not_to permit_action(:destroy) }
      end
    end
  end

  context "user is not logged in" do
    let(:user) { nil }
    let(:owner) { User.new }
    let(:event) { Event.new(user: owner) }

    describe "#show?" do
      it { is_expected.to permit_action(:show) }
    end

    describe "#edit?" do
      it { is_expected.not_to permit_action(:edit) }
    end

    describe "#update?" do
      it { is_expected.not_to permit_action(:update) }
    end

    describe "#destroy?" do
      it { is_expected.not_to permit_action(:destroy) }
    end
  end
end

