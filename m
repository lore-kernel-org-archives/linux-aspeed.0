Return-Path: <linux-aspeed+bounces-5212-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC00CCA46C
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:34:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5XBs0ktMz3080;
	Fri, 16 Oct 2026 15:33:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791701245;
	cv=none; b=kH0v8bKo+gjnDjvt+hJ8sll2ADKtC7xtX0WvcNfeNgKg+iJPqouKvY3i2o9i8llWdtzE4Z+qa1MQATmMCO/qFWEjsndJV14cjlRCb0a41jHlFrcsBxsK+TCLEhvYHMFrNGJUJ8tt7SqwWQaSus/H5IOPQIqb6hCusDfR8mtyTG0Ov6TTrWrISHXUdQGTzcD7jyzBHUUhjzWT/jVAAjI5O+Ib88gCvcEJy/wqwOj3bdz4D87id6vCyHcAyg4pJ3xgr2xow/KQq8Gw06bbWoG4jlaZZmO1Ue38BEQSnC6Mzag5HvnLvxm9+UVqpLOPk7V9/GWsY7YvtpRmxZMtcU9JXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791701245; c=relaxed/relaxed;
	bh=1QXG/OHOueFMbmPjMgjHa4I8+bxiyo5Fb5MP2BTqljM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUfKVl1gv2ISGocZTxkEIBp/woc8WUurqbPE7D7ZU1dXvubTorL8JUnpvDNAau5y7e9s65euRLEAr6SZ5IBqClABK1CiRtCZVqpEXBmePI+xYuAG4xnq+BSYrvG+9xBcrBge/ek1uEyUpu8ZSMRV5QLdg8AZcphxVfLxbF4IxASCi7vOyCbcKVIB3p7rdXETn3g/Hoc2W2ZvVYyeU61ukDGQ8KzYbQC5NPYygWm0yKAtIluelbSJ5TcQ5Dtp5KMPQrTtzib3CHtkJTj+NFHnQdFvt/Z4rzX5+vu6sGdYx5H+sMWuIsMXwQ+OGTbPEvo3kMHR6capx3CkjJhRduI6Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZsLkSf0c; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=thnkslprpt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZsLkSf0c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=thnkslprpt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2WP752gkz2yNj
	for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Oct 2026 17:47:22 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so7376205e9.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 10 Oct 2026 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791701238; x=1792306038; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1QXG/OHOueFMbmPjMgjHa4I8+bxiyo5Fb5MP2BTqljM=;
        b=ZsLkSf0cD56bMMzelYcHvQXHFouXBHycXqY8TTCgFfvd92shkjxV0IajJoghfbMuvx
         k4X7RCHzqkhfgUsUIA1anhzAVebhQeKREwyBtJzdDTVnABa9W/1LoP1WLF2mvetLsiiC
         qdsa4CPxXRlyhSmlgjh/UK25zOBlKynSqbOJVTty+XDVnUow4PYEAvwtnU3s+ECkflcY
         RT7iE5iJLuCXjBSHljzoVwiGra+ZmMPe6VkX4OSh0ZsRQdL1PG2gOYc9DAikdQPl3+P/
         vXxQlWjG16M8u2gCglMz7HmG+xBwvaJQiiG6tcVlhbvL/3rZvppqb02TkV7gxBqye+YE
         Kj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791701238; x=1792306038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1QXG/OHOueFMbmPjMgjHa4I8+bxiyo5Fb5MP2BTqljM=;
        b=X0od3aq+xPJZItVe2PCLMLX+JPwnBaVHSdCRF9bsExCKVex7q7C/kDQiy6W2vRhJJR
         i/dDoff1gjlPP5RpiuGVIl/iM9YdjbkLeoRE23ieI7MSvTDcK69RzwaMjWD/5N1Ml36g
         faGzURDjs4S6nL/GSQC4+KRmI8kKfoU/KVOhLQUT9enr8UY7QNbRzWTQcziZayK/fsXs
         sAfcL5Tws+onLtdheziNWf1bvCp6EQBms7Wz1TQxbtE765EqEyZTxlno+k3sQneocQDc
         iPnZ+2sjXdVG7A1f6dieMveHOH8Avk/R2uBQXW3SuZnDhVce6Q0NhO0W/TVZvHDuc822
         IwsA==
X-Forwarded-Encrypted: i=1; AKwUvBy8TxRBiTco02GJ+XbIw5+f2Qtfi+3kxs7P/ZTKT0DQyraUhMF7CE7aCwYiMLq97sSwoJK6JaJ/MkC39FU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYINkqMCym9ESTE3Ub16slyWS38hc+oA+kB/8FI6kofpYq3hERG4
	Z0orIVCuZsAaHAXvPLLa9ygEVtxvMPl/wzVM81hX1vGvZq1cEYZ5XYTn
X-Gm-Gg: AYBFou0bc7cRz2nF4of66qJgK1BSv5mAKWw3zpYKct7bYO7exunt/53mvTZPWkTnF4o
	UsYksVIuvuOpv/+iHXaIc06D4ebPhnu1GfVF3+pFhmamKiGjo2oAi+WUWXFjArvb+f/qhULdsH8
	EhUolxN71TN46r5/Pi9TxG+CIfnIHlfDpUpjIlLDNhwCxwJUBx1z2sRs9lP5MszAbmGF/9W5yeo
	l07ihupaghpGSAl1ZdCxppS5TPhojD/dPPhkb/2yNc5CE9m4oAgSl+PDf7HfCHpNLMcvSkdSbdp
	/W1pV8uVx3AANDfy/trEoG/TFi7Q+Hr07NijhoOQHiNy/VJG35Zaig1HUoXlXV6gaovrR+FNQwK
	MkTWk8v6Jzx5dUI0ldY+sVJ2Ki7tOWrSSnnVytU/01sLaSfxQDXhbaQmi5vJ3Ziohpe1EMtwmS7
	jjJwKHgVpsX54Fav6erSu4sxXR8Xgaibd4KRXOKWBFVIfkHfvzlU6q+7Fn4QFl8A4TkKfdmFzxi
	QHsbYcrHr4oSbJ+tOYeftma2nfYQe/dCPc=
X-Received: by 2002:a05:600c:1c15:b0:4a0:2867:d8a9 with SMTP id 5b1f17b1804b1-4a18e4d67e2mr131695315e9.30.1791701238379;
        Sat, 10 Oct 2026 23:47:18 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a06:c701:4778:c500:e952:dc8f:95c1:823c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf31b83sm194319945e9.12.2026.10.10.23.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:47:17 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/aspeed: Propagate DAC mux register update errors
Date: Sun, 11 Oct 2026 09:47:14 +0300
Message-ID: <20261011064715.2422596-1-thnkslprpt@gmail.com>
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

dac_mux_store() currently returns 0 when regmap_update_bits()
fails, implying a zero-length write instead of the actual error.

Return the negative error code itself for observability. No obvious
reason that this return should be clobbered to zero.

Fixes: 696029eb36c0 ("drm/aspeed: Add sysfs for output settings")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index c8746766f258..a933ad358852 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -268,7 +268,7 @@ static ssize_t dac_mux_store(struct device *dev, struct device_attribute *attr,
 
 	rc = regmap_update_bits(priv->scu, priv->dac_reg, 0x30000, val << 16);
 	if (rc < 0)
-		return 0;
+		return rc;
 
 	return count;
 }
-- 
2.43.0


