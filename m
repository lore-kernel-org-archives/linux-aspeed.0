Return-Path: <linux-aspeed+bounces-2804-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4EDCCFA1A
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cqk315gz2xQ4;
	Fri,  7 Nov 2025 09:51:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762399750;
	cv=none; b=LkaF9NwHxk1k00tyyD37AYPX2zNrMpVfh/xvp+u0jYPFmKT2DvQ3NpnqtKShZico42UyG6hnXS/cGSGg4MTGJhi6571Y5O4d8OVoOHSpHi5NrBEzyp6BQ9K/KdlLetSAYyVV7RHaSrAtBKHPHGl31pQgD7P7XE52oEDtRVnlzkTvrT/DtFMq35l/VRNQgHZup1s3EjKHzXI5LZOG+/dYkGOsPHB0qtojaHbfpqsXkZ9ejU0GzBQu5xmFFH/T5dyaeEQ50oGdFMwXnWoelUdjOxrav6soQcx87xthzlN7E+pj4apgqpVJM3jwZrAkKJizNuylpNcffixRkJ3K7ND6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762399750; c=relaxed/relaxed;
	bh=ILy73sttCQKjQ905fT2jb4GJKnPBKwJV0b2jd47RFds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h7rsrIsESyOymFTSsldGMVq1i2Db73pkLx5917FjUMStaDDdRV2QWi2AuRcfoZ/T9t7Cc+gu/Eyy3YdFImwUCfq4asvfLne9go706RVv6unruzpd3mFagO5RyB3NPxwP/XQKAH/4mGZ+62h0xlO0w4wZKjzU6iQwS11L9lI10Ntmt9MPQfF1FGRkdlYlpzFImGiafy0GuG73fmvJrfgWJlBUMuzV4gV60VkzOH9q5sAjkZCFL36u/N2l48nSLkKCXUszykgfkXyP2kRJ82Uf0U79mviyfUkve7DqxYKNYu7CgtZf9F478JArurBUAXZ9x7WTS7diZhHP6wXc91wbfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dh/0XwzC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+kimi.zy.chen.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dh/0XwzC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+kimi.zy.chen.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d272s3BSVz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Nov 2025 14:29:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B1DB160051;
	Thu,  6 Nov 2025 03:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A9DC4CEF5;
	Thu,  6 Nov 2025 03:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762399746;
	bh=M0+1u9tcjtZAWeIYRMKAetnt82+eDnNc/pxxjVmeGJ8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Dh/0XwzCtPCb0+qYPzg7D7KZCE9NvK2+eQz0QYIYPccpP3TpZCVGlWnTBz/kDIP+I
	 VXA59TVihOTPfE3z700wZC8gLk/1MxZF95f8JJ5P+QDe1Wx57NEtOdFUjfv3LCvC7i
	 0ZPVuir+WBdj6jXJk6+bVx7VtydAp/iOWprFEJDYs5PB3gGGhiLfoA6mqpcz/bcX44
	 aT2N+7JDGvi0JyAOVQRqxHpWdUHz5Ivd3N6jaijEBGMbTHl05FbWtL+EfJ9ygVO/fB
	 AXEP0egvtMYYyAwNoPBy0V/NsTw9aJP4WmY7U3MeG1SRw+yi+YFigpA9Vf8jKg+ePZ
	 IR3dpCojZa3Vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65ACCF9F8;
	Thu,  6 Nov 2025 03:29:06 +0000 (UTC)
From: Kimi Chen via B4 Relay <devnull+kimi.zy.chen.fii-foxconn.com@kernel.org>
Date: Thu, 06 Nov 2025 11:28:57 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: add gpio line name to io
 expander
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-dts-add-gpio-to-io-expander-v1-1-b4765c092ebe@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAPgVDGkC/x3MMQqAMAxA0atIZgO2WgevIg6hiTVLW1oRQby7x
 eXDW/4DVYpKhaV7oMilVVNsMH0H/qAYBJWbwQ7WGTPMyGdFYsaQNeGZsFXuTJGlIE1+tN7vbia
 CdshFdr3/+7q97weaqovrbQAAAA==
X-Change-ID: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, Kimi Chen <kimi.zy.chen@fii-foxconn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762399744; l=1184;
 i=kimi.zy.chen@fii-foxconn.com; s=20251105; h=from:subject:message-id;
 bh=AqtmtuP+jr8hv72i4Nsvgu+5GWsxpYdSguFgfPJMrrg=;
 b=gWTwCX2zWlQlFmQ63qT3cV1Pcm+eKRpXeZgl3/1S5mJQoeNAfaz9EI1I+tUftf1a7t2j1hDTo
 eWJkfoeyTbcD7nRo1MdQ4AHqWcYF0SRWvsqNNqGdct6+z+VvOuuCC5b
X-Developer-Key: i=kimi.zy.chen@fii-foxconn.com; a=ed25519;
 pk=3zHetsW/3CYYIgQlYV9dqSS7aW7aZXLUaIvc+OKr3NM=
X-Endpoint-Received: by B4 Relay for kimi.zy.chen@fii-foxconn.com/20251105
 with auth_id=559
X-Original-From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
Reply-To: kimi.zy.chen@fii-foxconn.com

From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>

The chassis power cycle process requires a forced shutdown before
cutting off the standby power. Therefore, SCM CPLD adds a hard shutdown
host function and triggers it via the IO expander in Clemente platform.

Thus, a new GPIO line named "hard_shutdown_host" is added to the
PCA9555 IO expander at line 10 to notify the CPLD to execute the hard
shutdown host function.

Signed-off-by: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 450446913e36..0eafd8ea04ac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -983,7 +983,7 @@ io_expander4: gpio@4f {
 			"",
 			"",
 			"",
-			"",
+			"hard_shutdown_host",
 			"",
 			"",
 			"",

---
base-commit: 6953afcd81a2cc73784e3dd23faa0a1aaf97441a
change-id: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa

Best regards,
-- 
Kimi Chen <kimi.zy.chen@fii-foxconn.com>



