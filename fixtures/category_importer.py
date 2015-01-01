from oscar.apps.catalogue.categories import create_from_breadcrumbs

categories = (
    # Men's Clothing
    "Clothing > Men's Clothing > Accessories",
    "Clothing > Men's Clothing > Shirts",
    "Clothing > Men's Clothing > Shirts > T-Shirt",
    "Clothing > Men's Clothing > Shirts > Longshirt",
    "Clothing > Men's Clothing > Shirts > Tanktop",
    "Clothing > Men's Clothing > Shorts",
    "Clothing > Men's Clothing > Pants",
    "Clothing > Men's Clothing > Jackets & Coats",
    "Clothing > Men's Clothing > Swimwear",
    "Clothing > Men's Clothing > Base Layer",
    "Clothing > Men's Clothing > Sweathirts",
    # Women's Clothing
    "Clothing > Women's Clothing > Accessories",
    "Clothing > Women's Clothing > Shirts & Tops",
    "Clothing > Women's Clothing > Shirts & Tops > T-Shirt",
    "Clothing > Women's Clothing > Shirts & Tops > Longshirt",
    "Clothing > Women's Clothing > Shirts & Tops > Tanktop",
    "Clothing > Women's Clothing > Shorts",
    "Clothing > Women's Clothing > Pants",
    "Clothing > Women's Clothing > Jackets & Coats",
    "Clothing > Women's Clothing > Swimsuits",
    "Clothing > Women's Clothing > Base Layer",
    "Clothing > Women's Clothing > Sweathirts",
    "Clothing > Women's Clothing > Dresses & Skirts",
    # Kid's Clothing
    "Clothing > Kid's Clothing > Accessories",
    "Clothing > Kid's Clothing > Boy's Shirts",
    "Clothing > Kid's Clothing > Boy's Shirts > T-Shirt",
    "Clothing > Kid's Clothing > Boy's Shirts > Longshirt",
    "Clothing > Kid's Clothing > Boy's Shirts > Tanktop",
    "Clothing > Kid's Clothing > Boy's Pants & Shorts",
    "Clothing > Kid's Clothing > Boy's Jackets & Coats",
    "Clothing > Kid's Clothing > Boy's Swimwear",
    "Clothing > Kid's Clothing > Girl's Shirts",
    "Clothing > Kid's Clothing > Girl's Shirts> T-Shirt",
    "Clothing > Kid's Clothing > Girl's Shirts > Longshirt",
    "Clothing > Kid's Clothing > Girl's Shirts > Tanktop",
    "Clothing > Kid's Clothing > Girl's Pants & Shorts",
    "Clothing > Kid's Clothing > Girl's Dresses & Skirts",
    "Clothing > Kid's Clothing > Girl's Jackets & Coats",
    "Clothing > Kid's Clothing > Girl's Swimwear",
    # Men's Shoes
    "Shoes > Men's Footwear > Sandals",
    "Shoes > Men's Footwear > Shoes",
    "Shoes > Men's Footwear > Boots",
    "Shoes > Men's Footwear > Socks",
    # Women's Shoes
    "Shoes > Women's Footwear > Sandals",
    "Shoes > Women's Footwear > Shoes",
    "Shoes > Women's Footwear > Boots",
    "Shoes > Women's Footwear > Socks",
    # Kid's Shoes
    "Shoes > Kid's Footwear > Kid's Shoes",
    "Shoes > Kid's Footwear > Kid's Boots",
    "Shoes > Kid's Footwear > Kid's Socks",
    # Outdoor Gear
    #"Sports & Outdoors > Outdoor Gear > Camping & Hiking",
    #"Sports & Outdoors > Outdoor Gear > Hunting",
    #"Sports & Outdoors > Outdoor Gear > Climbing Gear",
    #"Sports & Outdoors > Outdoor Gear > Binoculars & Camera",
    # Sporting Goods
    #"Sports & Outdoors > Sporting Goods > Running & Fitness",
    #"Sports & Outdoors > Sporting Goods > Golf",
    #"Sports & Outdoors > Sporting Goods > Ski",
    #"Sports & Outdoors > Sporting Goods > Water Sports",
    #"Sports & Outdoors > Sporting Goods > Tennis",
    # Brands
    # "Brands > H.A.D.",
    # "Brands > Charko",
    # "Brands > Bourg-de-Peage",
    # "Brands > F-Lite",
    # "Brands > 8BPlus",
    # "Brands > Makak",
)

for breadcrumbs in categories:
    create_from_breadcrumbs(breadcrumbs)

