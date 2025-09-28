-- SQLite Kitchen Database
-- Simplified version with sample data

-- Table structure for table 'users'
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Sample data for users
INSERT INTO users (id, name, created_at, updated_at) VALUES
(22, 'Joe Webster', '2024-08-12 18:02:44', '2024-08-12 18:02:44'),
(23, 'Matthew Smith', '2024-08-12 18:05:20', '2024-08-12 18:05:21'),
(25, 'Dylan Jonas', '2025-02-12 15:33:19', '2025-02-12 15:33:19'),
(27, 'Shannon Webb', '2025-02-28 19:24:10', '2025-03-01 02:27:33'),
(31, 'Brooklyn Sanchez', '2025-03-31 03:03:03', '2025-03-31 03:03:03');

-- Table structure for table 'units'
CREATE TABLE units (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  singular TEXT NOT NULL,
  plural TEXT NOT NULL,
  type TEXT NOT NULL,
  to_base_factor REAL NOT NULL DEFAULT 0.0,
  display_threshold REAL NOT NULL DEFAULT 0.0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Sample data for units
INSERT INTO units (id, singular, plural, type, to_base_factor, display_threshold) VALUES
(1, 'cup', 'cups', 'volume', 236.5882, 0.0),
(2, 'teaspoon', 'teaspoons', 'volume', 4.9289, 0.0),
(3, 'tablespoon', 'tablespoons', 'volume', 14.7868, 0.0),
(4, 'unit', 'units', 'other', 0.0, 0.0),
(8, 'ounce', 'ounces', 'weight', 28.3495, 0.0),
(10, 'pound', 'pounds', 'weight', 453.5924, 0.0),
(11, 'clove', 'cloves', 'other', 0.0, 0.0),
(13, 'pinch', 'pinches', 'other', 0.0, 0.0),
(14, 'gram', 'grams', 'weight', 1.0, 0.0);

-- Table structure for table 'ingredients'
CREATE TABLE ingredients (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

-- Sample data for ingredients
INSERT INTO ingredients (id, name) VALUES
(1, 'Milk'),
(7, 'Sugar'),
(8, 'Egg'),
(10, 'Flour'),
(11, 'Baking Powder'),
(12, 'Salt'),
(13, 'Butter'),
(14, 'Peanut Butter'),
(16, 'Brown Sugar'),
(17, 'Vanilla Extract'),
(18, 'Baking Soda'),
(19, 'Milk Chocolate Chips'),
(21, 'Yeast'),
(22, 'Water'),
(26, 'Ground Sausage'),
(27, 'Minced Garlic'),
(28, 'Frozen Hash Browns'),
(30, 'Cheddar Cheese'),
(31, 'Black Pepper'),
(40, 'Extra Virgin Olive Oil'),
(47, 'Chicken Breast'),
(61, 'Onion'),
(69, 'Ground Beef'),
(70, 'Bell Pepper'),
(78, 'Diced Tomatoes'),
(79, 'Chicken Stock'),
(80, 'Parsley'),
(89, 'Spaghetti'),
(91, 'Chicken Broth'),
(93, 'Rice'),
(129, 'Mozzarella Cheese');

-- Table structure for table 'recipes'
CREATE TABLE recipes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  image_path TEXT DEFAULT NULL,
  description TEXT,
  user_id INTEGER NOT NULL,
  instructions TEXT,
  quantity REAL DEFAULT NULL,
  unit_id INTEGER DEFAULT NULL,
  servings INTEGER DEFAULT NULL,
  is_visible INTEGER NOT NULL DEFAULT 1,
  is_public INTEGER NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE SET NULL
);

-- Sample data for recipes
INSERT INTO recipes (id, name, image_path, description, user_id, instructions, servings, is_visible, is_public, created_at, updated_at) VALUES
(9, 'Doug''s Famous Chocolate Chip Cookies', 'recipes/cookies.avif', NULL, 22, '<ol><li>Preheat oven to 350 degrees</li><li>Add butter, sugar and brown sugar, mixing well</li><li>Add eggs and vanilla, mixing well</li><li>Add flour 1/2 cup at a time, mixing well between additions</li><li>Add salt and baking soda, mixing well</li><li>Stir in chocolate chips by hand</li></ol><p>Place 1" balls on a cookie sheet. Bake for 10-12 minutes, or until the sides start to brown.</p>', 8, 1, 1, '2025-02-26 21:56:54', '2025-04-22 04:23:06'),
(20, 'Breakfast Casserole', NULL, 'Made by Dylan''s Mom', 25, '<ol><li>Prepare oven. Heat oven to 375°F.</li><li>Brown the sausage. Drain.</li><li>Add the thawed diced potatoes and 1 1/2 cups cheese to the mixing bowl with the sausage.</li><li>In a separate small bowl, whisk together the eggs, milk, salt and black pepper until combined.</li><li>Pour the mixture into a 9x13-inch baking dish and top with remaining cheese.</li><li>Cover with aluminum foil and bake for 40 minutes. Remove foil and bake additional 10-15 minutes.</li></ol>', 8, 1, 1, '2025-02-28 15:34:45', '2025-02-28 15:34:45'),
(76, 'Picadillo', NULL, 'Quick and cheap Brazilian picadillo recipe. Best served over rice or noodles.', 23, '<ol><li>Place a large pan over medium-high heat. Add olive oil.</li><li>Add onion and bell pepper. Sauté for 2-3 minutes until soft.</li><li>Add garlic and sauté for 1-2 minutes until fragrant.</li><li>Add ground beef. Cook through, stirring occasionally.</li><li>Season with salt, pepper, cumin, oregano, and paprika.</li><li>Add tomatoes and stock. Simmer covered for 10 minutes.</li><li>Finish with parsley and serve!</li></ol>', 5, 1, 1, '2025-04-03 05:01:28', '2025-04-08 19:33:40'),
(105, 'Hearts Of Palm Pasta', 'recipes/pasta.jpg', 'Pasta with hearts of palm. A great dish for a Palm Sunday meal.', 23, '<ol><li>Cook pasta al dente according to package directions, but subtract 2 minutes from cooking time.</li><li>In a large sauté pan, heat olive oil over medium heat.</li><li>Add hearts of palm and garlic. Cook until fragrant.</li><li>Add chicken broth and cook for 2 minutes.</li><li>Add heavy cream, parsley, salt, and pepper. Bring to simmer.</li><li>Add pasta and toss, adding starchy water until desired consistency.</li><li>Add parmesan cheese and mix before serving.</li></ol>', 5, 1, 1, '2025-04-14 01:24:10', '2025-04-22 17:39:57'),
(106, 'Lemon Garlic Chicken & Rice Skillet', 'recipes/chicken_rice.jpg', NULL, 23, '<ol><li>Heat olive oil in large skillet over medium-high heat.</li><li>Add chicken. Season with salt, pepper, paprika, and Italian seasoning.</li><li>Add garlic, onion, bell pepper, and zucchini. Sauté for 2 minutes.</li><li>Stir in uncooked rice and cook 1-2 minutes to toast lightly.</li><li>Pour in chicken broth and lemon juice. Stir to combine.</li><li>Bring to boil, then reduce heat to low. Cover and simmer 15-18 minutes for white rice.</li><li>Garnish with parsley and serve warm.</li></ol>', 4, 1, 1, '2025-04-15 03:45:05', '2025-04-22 17:37:36');

-- Table structure for table 'ingredient_recipe'
CREATE TABLE ingredient_recipe (
  recipe_id INTEGER NOT NULL,
  ingredientable_type TEXT,
  ingredientable_id INTEGER DEFAULT NULL,
  order_num INTEGER DEFAULT NULL,
  numerator INTEGER DEFAULT NULL,
  denominator INTEGER DEFAULT NULL,
  unit_id INTEGER DEFAULT NULL,
  name TEXT,
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
  FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE SET NULL
);

-- Sample data for ingredient_recipe relationships
INSERT INTO ingredient_recipe (recipe_id, ingredientable_type, ingredientable_id, order_num, numerator, denominator, unit_id, name) VALUES
-- Chocolate Chip Cookies ingredients
(9, 'ingredient', 13, 1, 11, 1, 3, 'Butter'),
(9, 'ingredient', 7, 2, 1, 2, 1, 'Sugar'),
(9, 'ingredient', 16, 3, 2, 3, 1, 'Brown Sugar'),
(9, 'ingredient', 8, 4, 1, 1, NULL, 'Egg'),
(9, 'ingredient', 17, 5, 1, 1, 2, 'Vanilla Extract'),
(9, 'ingredient', 10, 6, 2, 1, 1, 'Flour'),
(9, 'ingredient', 12, 7, 1, 2, 2, 'Salt'),
(9, 'ingredient', 18, 8, 1, 2, 2, 'Baking Soda'),
(9, 'ingredient', 19, 9, 1, 2, 8, 'Milk Chocolate Chips'),

-- Breakfast Casserole ingredients
(20, 'ingredient', 26, 1, 1, 1, 10, 'Ground Sausage'),
(20, 'ingredient', 27, 2, 3, 1, 11, 'Garlic, minced'),
(20, 'ingredient', 28, 3, 20, 1, 8, 'Frozen Hash Browns'),
(20, 'ingredient', 30, 4, 2, 1, 1, 'Shredded Cheddar Cheese'),
(20, 'ingredient', 8, 5, 10, 1, NULL, 'Egg'),
(20, 'ingredient', 1, 6, 1, 3, 1, 'Milk'),
(20, 'ingredient', 12, 7, 1, 1, 2, 'Salt'),
(20, 'ingredient', 31, 8, 1, 1, 13, 'Black Pepper'),

-- Picadillo ingredients
(76, 'ingredient', 69, 1, 1, 1, 10, 'Ground Beef'),
(76, 'ingredient', 40, 2, 1, 1, 3, 'Extra Virgin Olive Oil'),
(76, 'ingredient', 61, 3, 1, 1, NULL, 'Onion, diced'),
(76, 'ingredient', 70, 4, 1, 1, NULL, 'Bell Pepper, diced'),
(76, 'ingredient', 27, 5, 3, 1, 11, 'Minced Garlic'),
(76, 'ingredient', 78, 6, 14, 1, 8, 'Diced Tomatoes, with juice'),
(76, 'ingredient', 79, 7, 1, 2, 1, 'Chicken Stock (or water)'),
(76, 'ingredient', 80, 8, 1, 4, 1, 'Parsley, minced'),

-- Hearts of Palm Pasta ingredients
(105, 'ingredient', 89, 1, 1, 1, 10, 'Spaghetti'),
(105, 'ingredient', 40, 2, 2, 1, 3, 'Extra Virgin Olive Oil'),
(105, 'ingredient', 27, 3, 2, 1, 11, 'Minced Garlic'),
(105, 'ingredient', 91, 4, 1, 4, 1, 'Chicken Broth'),

-- Chicken & Rice Skillet ingredients
(106, 'ingredient', 40, 1, 1, 1, 3, 'Extra Virgin Olive Oil'),
(106, 'ingredient', 47, 2, 2, 1, NULL, 'Chicken Breasts cut into chunks'),
(106, 'ingredient', 12, 3, NULL, NULL, NULL, 'Salt'),
(106, 'ingredient', 31, 4, NULL, NULL, NULL, 'Black Pepper'),
(106, 'ingredient', 27, 5, 3, 1, 11, 'Minced Garlic'),
(106, 'ingredient', 61, 6, 1, 1, NULL, 'Small Onion, diced'),
(106, 'ingredient', 70, 7, 1, 1, NULL, 'Bell Pepper, chopped'),
(106, 'ingredient', 93, 8, 1, 1, 1, 'Uncooked Rice'),
(106, 'ingredient', 91, 9, 2, 1, 1, 'Chicken Broth'),
(106, 'ingredient', 80, 10, 1, 1, 3, 'Parsley, chopped');

-- Create indexes for better performance
CREATE INDEX idx_recipes_user_id ON recipes(user_id);
CREATE INDEX idx_ingredient_recipe_recipe_id ON ingredient_recipe(recipe_id);
CREATE INDEX idx_ingredient_recipe_ingredientable ON ingredient_recipe(ingredientable_type, ingredientable_id);
CREATE INDEX idx_ingredient_recipe_unit_id ON ingredient_recipe(unit_id);
