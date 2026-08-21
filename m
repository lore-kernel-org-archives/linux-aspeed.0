Return-Path: <linux-aspeed+bounces-4813-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11542C5DF87
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 10:08:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRGGV00XJz3bwF;
	Fri, 21 Aug 2026 20:08:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787306897;
	cv=none; b=CeTn42RVyfI7Zc6ugzUvtvzPhjVniRtzAqifIdyd0ucVQArj7JfT+pLZP4FfpZktAEK7OgAZeJyzExFO5JYRdBzyCnL0ONCAJpwwMTE736T38VgZsfT17WbQ7aldc1WUFjsxkdOwrnke5AehjSZk9nIyRTzC78YeTp5CMW64O+B65/YY2UUVd6xo0uN3es6d29VxzK6gd4VlfTNLToPq8AbDqJMuLgl8MNXpde3HaUwh2/Bds060dAbuA+pfN9sV0P2gzluXpVbc0coHsSz64UXETmqj7QTSItT+cta5+FXq1PYtGLfUmDL3iroJXvdZnjiZ+ricDcJSmXfef6Vb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787306897; c=relaxed/relaxed;
	bh=mGHfYVi6qDm7s7G6q93buprYrMKUFRSSUos1yUz/o4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nC1P3AAwVIWLB1BYgk1wSZSPWTOC/QJIVOlDPvB/+kxqS3f17b3ipzv7VjQNklZIlYhW/rqHne0bRGP7VEbEXzqnbz4vXh/xmtXcmmh47bIXIue4HazDyh1jsGxFp6nnvTqWLQ9MwOsdz5Z9wXFMDHvbBLEtwm5FvxB6YCZe71PC5TRhvNzM+YEKP5yuGUBZQtyDsx8hX6iaZ9dkOIMYx0sXcKzfGJAtBjufNXgZgCxjxLxlnyMe12aKigYm7gjioJhDLeBMfv1+DZhL+F9gZT4RHNtjB6sk6AZ8tKQ75W5tQlfwOS1wd1ncrEUPayc+cT766298sUoWsPsnRZXSKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRGGS0PX5z3064;
	Fri, 21 Aug 2026 20:08:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5234560A71;
	Fri, 21 Aug 2026 10:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0189B1F000E9;
	Fri, 21 Aug 2026 10:08:09 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] peci: controller: aspeed: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:08:05 +0200
Message-ID: <48aa77c45e109f78ccd806bc3b7bf380c5bc5e71.1787240145.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

Part One[1] fixed all cases that I identified to be real bugs, in
response to a crash I saw on BeagleBone Black.

This patch is the PECI subpart of Part Two, which fixes remaining cases
that are currently harmless.  These are still fragile, and may cause
future breakage when converting drivers to a different method for
specifying the parents.

[1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
     initialized (part 1)"
    https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be
---
 drivers/peci/controller/peci-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index a0c99ecf7f3805a1..2f4ea0e7d7a77dbd 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -413,7 +413,7 @@ static struct clk *devm_aspeed_peci_register_clk_div(struct device *dev, struct
 						     struct aspeed_peci *priv)
 {
 	struct clk_aspeed_peci *peci_clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *parent_name;
 	char name[32];
 	int ret;
-- 
2.43.0


