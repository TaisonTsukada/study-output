require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
    end
    context 'メッセージを送信できる時' do
      it 'messageを入力すれば送信できる' do
        expect(@message).to be_valid
      end
    end
    context 'メッセージを送れない時' do
      it 'messageが空では保存できないこと' do
        @message.message = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Messageを入力してください")
      end

      it 'roomが紐付いていないと保存できないこと' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Roomを入力してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @message.user =nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end