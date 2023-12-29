-- CreateTable
CREATE TABLE "Users" (
    "userId" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "coverPic" TEXT,
    "profilePic" TEXT,
    "city" TEXT,
    "website" TEXT,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Posts" (
    "postId" TEXT NOT NULL,
    "desc" TEXT,
    "img" TEXT,
    "postUserId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Posts_pkey" PRIMARY KEY ("postId")
);

-- CreateTable
CREATE TABLE "Comments" (
    "commentId" TEXT NOT NULL,
    "desc" TEXT NOT NULL,
    "commentUserId" TEXT NOT NULL,
    "commentPostId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "postsId" TEXT NOT NULL,

    CONSTRAINT "Comments_pkey" PRIMARY KEY ("commentId")
);

-- CreateTable
CREATE TABLE "Stories" (
    "storyId" TEXT NOT NULL,
    "img" TEXT NOT NULL,
    "storyUserId" TEXT NOT NULL,

    CONSTRAINT "Stories_pkey" PRIMARY KEY ("storyId")
);

-- CreateTable
CREATE TABLE "Relationships" (
    "followerRelationshipId" TEXT NOT NULL,
    "followerUserId" TEXT NOT NULL,
    "followedUserId" TEXT NOT NULL,
    "usersUserId" TEXT,

    CONSTRAINT "Relationships_pkey" PRIMARY KEY ("followerRelationshipId")
);

-- CreateTable
CREATE TABLE "Likes" (
    "likeId" TEXT NOT NULL,
    "likeUserId" TEXT NOT NULL,
    "likepostId" TEXT NOT NULL,

    CONSTRAINT "Likes_pkey" PRIMARY KEY ("likeId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_username_key" ON "Users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Posts_postUserId_key" ON "Posts"("postUserId");

-- CreateIndex
CREATE UNIQUE INDEX "Comments_commentUserId_key" ON "Comments"("commentUserId");

-- CreateIndex
CREATE UNIQUE INDEX "Comments_commentPostId_key" ON "Comments"("commentPostId");

-- AddForeignKey
ALTER TABLE "Posts" ADD CONSTRAINT "Posts_postUserId_fkey" FOREIGN KEY ("postUserId") REFERENCES "Users"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_commentUserId_fkey" FOREIGN KEY ("commentUserId") REFERENCES "Users"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_commentPostId_fkey" FOREIGN KEY ("commentPostId") REFERENCES "Posts"("postId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stories" ADD CONSTRAINT "Stories_storyUserId_fkey" FOREIGN KEY ("storyUserId") REFERENCES "Users"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Relationships" ADD CONSTRAINT "Relationships_followerUserId_fkey" FOREIGN KEY ("followerUserId") REFERENCES "Users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Relationships" ADD CONSTRAINT "Relationships_followedUserId_fkey" FOREIGN KEY ("followedUserId") REFERENCES "Users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Relationships" ADD CONSTRAINT "Relationships_usersUserId_fkey" FOREIGN KEY ("usersUserId") REFERENCES "Users"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Likes" ADD CONSTRAINT "Likes_likeUserId_fkey" FOREIGN KEY ("likeUserId") REFERENCES "Users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Likes" ADD CONSTRAINT "Likes_likepostId_fkey" FOREIGN KEY ("likepostId") REFERENCES "Posts"("postId") ON DELETE RESTRICT ON UPDATE CASCADE;
