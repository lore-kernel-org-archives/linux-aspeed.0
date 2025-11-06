Return-Path: <linux-aspeed+bounces-2803-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E3ACCFA13
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cqj2gZMz2xlQ;
	Fri,  7 Nov 2025 09:51:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762448356;
	cv=none; b=dV1stvMDj8QvOeoF9T2BGB752V6GhQftl8iyyxbcqHYSJLZRH7rYAEive7IN3KW01IGQMA+RXq5S+y1DuidDqjX7Dl5x2r2C4d+z3+hhsYmmQWHaI1Cz0GzNfUPiC1eMGqrSZ1xfwgCssy3E+WvUjTLd8dNS17u9lOjOJ157L8bE0BuvcbUBuS/WWtacPWtmcO3sBoq/MLq9Fo/38rjPboWH9Bbrlw/b80bK/fM6RbEfmxkdtkXWMZ2q470L9yWI1As3ICP7PXQd1GUpMWIlufYHTJTmKwY3T3tCDNbTjcRKQZ5zA15b/Tq1CkKemkg5kwCQnXijxVrDzprE1WMuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762448356; c=relaxed/relaxed;
	bh=rvdBRXuVZQm8G2d5SpNLaJ207ItUCAtXqb2fjgCGcoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Aufhh3GbbOCBVtDDIOsYTMvHBHs2vVvfqWFOb9YSEKeK5MFYNCKCTaJFNIYL4Nwu+YJ6f1FcmMFTwMybthUHPo8qku74pAhkpwmgAgSXKHcBQwMI3iEHMj/QWmohGC3ojhR3/kk1ELqI4ZMV3Wr9pS5nnPMY2i9oEG5K9pO1Szl+APWdp2JrDjOX/nKgMZvqLWdU7rH9ipG8ZpjTaNhz4hl5fevrfgS+Ta5aUaOGi4Yzv5Nmo/9IEasnQmqkcNJN/OmLCQ20Io51uyEJcPk7XE0WRdYaui8Du7e/gQTkAO1kh9GIjF8olyfhDz/xN41RRPsPVkJ0Fr/YZObbUtjT2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m/pF21hX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+kimi.zy.chen.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m/pF21hX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+kimi.zy.chen.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2T1b6lpgz30MY
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:59:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D7BC6191B;
	Thu,  6 Nov 2025 16:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7582C4CEF7;
	Thu,  6 Nov 2025 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448353;
	bh=5zVxDLJDS4HgZvm0mUPMa4NXwy0uzOr1eXabb1arNpI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=m/pF21hXXdxtUQjEpD7ImAPfMVCmNCJ2tehEPz5uAKfbfWxrAQnoXZPNFBbgOe+A6
	 VyU4Gr6tnm/VOVLcTJIsz8H2+IFUox0CEJF3M25ALvUjI6qwJ+M23+yi68cfIhFcg9
	 Iokb74FJ1ZmUNMPv5qBKvvCpMQbccALrAlRtUB8dCFNz+k4yk+hyUm8ZIAk9m6qREs
	 ZaA0G8RRFZCikQck59el+G/yILo0vRrVxw/9zzEnfmLM+1PGZ/ozslAgVoenTS1X64
	 uobNY6wQ7vIDer2ViUmnr7nFcyCNtQzy4CjD60pQd3QwRygy+NKpxX7XZg6rDF+VCG
	 Bh0ISPmF1I24g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D679ACCFA13;
	Thu,  6 Nov 2025 16:59:12 +0000 (UTC)
From: Kimi Chen via B4 Relay <devnull+kimi.zy.chen.fii-foxconn.com@kernel.org>
Date: Fri, 07 Nov 2025 00:58:39 +0800
Subject: [PATCH v2] ARM: dts: aspeed: clemente: add gpio line name to io
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
Message-Id: <20251107-dts-add-gpio-to-io-expander-v2-1-585d48845546@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAL7TDGkC/42NQQ6CMBBFr2Jm7RhaAaMr72FYlOkUZmGHtIRgC
 He3cgI3P3l/8d4GmZNwhsdpg8SLZNFYwJ5PQKOLA6P4wmAr2xhTtejnjM57HCZRnBXL8jq56Dm
 hq+lqiULTOgfFMCUOsh72V1d4lDxr+hyxxfze/7yLQYN9fWsbqu6We34GEQy6ksZ4IX1Dt+/7F
 3ryuuvMAAAA
X-Change-ID: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, Kimi Chen <kimi.zy.chen@fii-foxconn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762448350; l=1406;
 i=kimi.zy.chen@fii-foxconn.com; s=20251105; h=from:subject:message-id;
 bh=q3Hjka33GAqrC98JfV2gHVz/SyvVpQc9OOGcXtH2A3s=;
 b=NrYZXH/6ZM0K5uh1E4Dpz9BEY/90j+EqlD+xpSNYCWBMgYSWb8gU3AUlhgA9eKPNOTBjBQ8xF
 hI/8nERMKFgDSBf2fbZg1SHASISyBZ14VLdDlX6u4mgFSYLGXe1XLtL
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
Changes in v2:
- Add "hard_shutdown_host" GPIO line name to PCA9555 IO expander for Clemente platform.
- Link to v1: https://lore.kernel.org/r/20251106-dts-add-gpio-to-io-expander-v1-1-b4765c092ebe@fii-foxconn.com
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



