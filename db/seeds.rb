# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

loc1 = Location.create(name: 'Dhaka',desc:'North')
loc2 = Location.create(name: 'Rangpur',desc:'North')
loc3 = Location.create(name: 'Rajshahi',desc:'North')
loc4 = Location.create(name: 'Khulna',desc:'North')

cat = Category.create(name: 'Car')
cat2 = Category.create(name: 'Mobile')
cat3 = Category.create(name: 'Computer')
descs = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
        ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
        in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
        non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",

        "But I must explain to you how all this mistaken idea of denouncing pleasure and
        praising pain was born and I will give you a complete account of the system, and expound
        the actual teachings of the great explorer of the truth, the master-builder of human happiness.
        No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because
        those who do not know how to pursue pleasure rationally encounter consequences that are
        extremely painful.",

        "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum
        deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident,
        similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum
        quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio
        cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus." ]

image_paths = ['http://placehold.it/350x150','http://placehold.it/200x300','http://placehold.it/300x300']

20.times do |t|
  post = Post.create(title: "Post-#{t}",desc: descs.sample ,image: image_paths.sample, location: [loc1,loc2,loc3,loc4].sample)
  post.categories<< [cat,cat2,cat3].sample
end