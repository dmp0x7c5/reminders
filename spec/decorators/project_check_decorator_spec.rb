require "rails_helper"

describe ProjectCheckDecorator do
  let(:check) { OpenStruct.new }
  let(:decorator) { described_class.new(check) }

  describe "#last_check_date" do
    context "when there is no date" do
      it 'returns "not checked yet"' do
        check.last_check_date = nil
        expect(decorator.last_check_date).to eq "not checked yet"
      end
    end

    context "when the date is set" do
      it 'returns "X days ago" for more than one day' do
        check.last_check_date = 2.days.ago.to_date
        expect(decorator.last_check_date).to eq "2 days ago"
      end

      it 'returns "yesterday" for one day ago' do
        check.last_check_date = Time.zone.yesterday
        expect(decorator.last_check_date).to eq "yesterday"
      end

      it 'returns "today" for today' do
        check.last_check_date = Time.zone.today
        expect(decorator.last_check_date).to eq "today"
      end
    end
  end
end
