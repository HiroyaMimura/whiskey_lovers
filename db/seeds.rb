# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  Admin.create!(
    email: ENV['SECRET_EMAIL'],
     password: ENV['SECRET_KEY'],
  )

  5.times do |n|
    User.create!(
      email: "test#{n + 1}@test.com",
      name: "飲兵衛#{n + 1}",
      password: "00000#{n + 1}"
    )
  end

    Whiskey.create!(
      user_id: '2',
      name: 'TALISKER',
      impression: '好きな味わいです',
      taste: '100',
      scent: '200',
      price_range: '2000円〜4000円',
      performance: '4',
      whiskey_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/image10.jpg')),
      filename: 'image10.jpg')
      )

    Whiskey.create!(
      user_id: '2',
      name: 'イチローズモルト',
      impression: '飲みやすいです',
      taste: '70',
      scent: '100',
      price_range: '4000円〜6000円',
      performance: '3',
      whiskey_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/image1.jpg')),
      filename: 'image1.jpg')
      )

    Whiskey.create!(
      user_id: '3',
      name: 'BOWMORE',
      impression: '美味しいです',
      taste: '100',
      scent: '170',
      price_range: '4000円〜6000円',
      performance: '3',
      whiskey_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/image9.jpg')),
      filename: 'image9.jpg')
      )

    Whiskey.create!(
      user_id: '4',
      name: 'ARDBEG',
      impression: 'かなりスモーキーです',
      taste: '130',
      scent: '235',
      price_range: '4000円〜6000円',
      performance: '3.5',
      whiskey_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/image14.jpg')),
      filename: 'image14.jpg')
      )

    Tag.create!(
      [
        {
          tag: 'おすすめ'
        },
        {
          tag: 'うまい'
        },
        {
          tag: 'プチ贅沢'
        },
        {
          tag: 'ハマる'
        },
        {
          tag: 'コスパが良い'
        },
        {
          tag: 'スモーキー最高'
        },
        {
          tag: '飲みやすい'
        }
      ]
    )


    WhiskeyTag.create!(
      [
        {
          whiskey_id: '1',
          tag_id: '1'
        },
        {
          whiskey_id: '1',
          tag_id: '4'
        },
        {
          whiskey_id: '1',
          tag_id: '5'
        },
        {
          whiskey_id: '2',
          tag_id: '2'
        },
        {
          whiskey_id: '2',
          tag_id: '3'
        },
        {
          whiskey_id: '3',
          tag_id: '2'
        },
        {
          whiskey_id: '3',
          tag_id: '4'
        },
        {
          whiskey_id: '3',
          tag_id: '6'
        },
      ]
    )
