# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Member.create!(
  [
    {
      email: 'test@com',
      name: 'サンプル',
      password: '111111',
      introduction: 'ホラーが好きです'
    },
    {
      email: 'test1@com',
      name: 'さんぷる',
      password: '111111',
      introduction: 'コメディーが好き！'
    },
    {
      email: 'test2@com',
      name: 'sample',
      password: '111111',
      introduction: 'アクションをよく観ます'
    },
    {
      email: 'test3@com',
      name: 'てすと',
      password: '111111',
      introduction: '恋愛映画をよく観ます'
    }
  ]
)
