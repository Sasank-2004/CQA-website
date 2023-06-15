-- Example of schema 
-- The schema does not include any indexes ( except PK's )

-- Users
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	account_id INTEGER,
	reputation INTEGER NOT NULL,
	views INTEGER DEFAULT 0,
	down_votes INTEGER DEFAULT 0,
	up_votes INTEGER DEFAULT 0,
	display_name VARCHAR(255) NOT NULL,
	location VARCHAR(512),
	profile_image_url VARCHAR(255),
	website_url VARCHAR(255),
	about_me TEXT,
	creation_date TIMESTAMP NOT NULL,
	last_access_date TIMESTAMP NOT NULL
);

-- Posts
CREATE TABLE posts (
	id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	last_editor_user_id INTEGER,
	post_type_id SMALLINT NOT NULL,
	accepted_answer_id INTEGER,
	score INTEGER NOT NULL,
	parent_id INTEGER,
	view_count INTEGER,
	answer_count INTEGER DEFAULT 0,
	comment_count INTEGER DEFAULT 0,
	owner_display_name VARCHAR(64),
	last_editor_display_name VARCHAR(64),
	title VARCHAR(512),
	tags VARCHAR(512),
	-- content_license VARCHAR(64) NOT NULL,
	body TEXT NOT NULL,
	favorite_count INTEGER,
	creation_date TIMESTAMP NOT NULL,
	community_owned_date TIMESTAMP,
	closed_date TIMESTAMP,
	last_edit_date TIMESTAMP,
	last_activity_date TIMESTAMP,
	foreign key (owner_user_id) references users,
	check (post_type_id = 1 or post_type_id = 2) 
);

CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	score SMALLINT NOT NULL,
	text TEXT NOT NULL,
	creation_date TIMESTAMP NOT NULL,
	foreign key (post_id) references posts,
	foreign key (user_id) references users
);

-- Votes
CREATE TABLE votes (
	id SERIAL PRIMARY KEY,
	user_id INTEGER,
	post_id INTEGER NOT NULL,
	vote_type_id SMALLINT NOT NULL,
	bounty_amount SMALLINT,
	creation_date TIMESTAMP NOT NULL,
	foreign key (user_id) references users,
	foreign key (post_id) references posts,
	check (vote_type_id = 2 or vote_type_id = 3)
);

-- Tags
CREATE TABLE tags (
	id SERIAL PRIMARY KEY,
	excerpt_post_id INTEGER,
	wiki_post_id INTEGER,
	tag_name VARCHAR(255) NOT NULL,
	count INTEGER DEFAULT 0
);