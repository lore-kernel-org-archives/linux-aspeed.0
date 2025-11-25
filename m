Return-Path: <linux-aspeed+bounces-2992-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4930CFD315
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Nov 2025 05:56:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFsPj0NCXz2ynC;
	Tue, 25 Nov 2025 16:56:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764049481;
	cv=none; b=LEs/zVBZkvsaYelB8ZLvqum03LkiZY6o8YjEVGtNrlXBbF+T3wKVjEFzXjYShxVbR/fLx4o1Eh7fz/MNCyMe19sWyTcAggSPZatiN8r56c2yAO5bXUuk7MVnMUuD7Vd5mYfy/ckvgWT6wchbQWXYBISZHZb0MEjGIeyarKBoDFx0eHiK1MiiDc6Vj272SNOg82LFH0TFBxNnh8v2Pv88TJADRFLld8nzej1H/L1oCx6w0N5TgDnzJWYBHKunYE+wPP07pF6F1uiOl+psNcREnmU68DyvJROaqXu+BpFCXNOTLNRIvtO8uMf/RdlZtI71F+GS55BT5FaJMAWxMHsoww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764049481; c=relaxed/relaxed;
	bh=wU758igsmLPYBRY5GuEqnwep8DpXhcYVva2ZYDF4Duo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QLfWqj5RFdyLs7CpfnpENr3fZe2OVV5zOToPzX2nE4gWtYsxkau4Ew8LNrlmm8XMy0HLBYjxiub+lrXnGo0wtdWA2jzUOEaG+qkCfCa/YSD4tV3kE/aekjyw29Ky7df3vG7V3uvDbJGYY5pdBFYK6wFJSDI2k0y13pbDpjHNo2qkR2gJsIhkN6MWKXzC8ECdbOfyZwX5SYFp5qS4Scb5oU6nQ7JtMr/3a27M86xIdnyXFnGm+bfhH2WXL8rWe8Z81taGIAnvykJUs8bzBqJfrIswDnOj1q4cQuBVVWhg9Rupj9fCxPTi0Ls5gmJ6r5QnQ1S9J8f2MUpinqFY1tCg8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uB8rb81R; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+kimi.zy.chen.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uB8rb81R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+kimi.zy.chen.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFs8S2Clrz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 16:44:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9BAF4600CB;
	Tue, 25 Nov 2025 05:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A3E9C4CEF1;
	Tue, 25 Nov 2025 05:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764049477;
	bh=qY2QP76VbEE+tQpE3vnVHe7Qa+9ipLp7VVuCWmmPAE0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uB8rb81RgN5g1U2MJPK3YTSwg67bDTxqxez1scm+9P/JAtBfft28yvhcQdIs2um3x
	 CXtQY1dk93LzK0lhK8lUDIUJh9oLHu9ThaVMX7udfEg1fZUQuhkTmOL0oN2w1nOLOs
	 ml7/h8LDO5OsxNRrKdKRS47spisRzgZnt9EKP6Zvu5W+C6zkyTk//kvq/ptqVrUl9p
	 4wXfUySn2tvChCK6gkd1TxowWNzauFgVfTET46fLpUrDgeBLGdR5I3la5zT0loM4we
	 GvM9CCFO+BX1y2S/5QN32GRQHdt5LDv2goMmby7Z/Y0H7mSj9i9NfFZeoDEXFOdZS+
	 JXV++XHOr7eug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB3CFD315;
	Tue, 25 Nov 2025 05:44:37 +0000 (UTC)
From: Kimi Chen via B4 Relay <devnull+kimi.zy.chen.fii-foxconn.com@kernel.org>
Date: Tue, 25 Nov 2025 13:42:50 +0800
Subject: [PATCH v4] ARM: dts: aspeed: clemente: add gpio line name to io
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
Content-Transfer-Encoding: 8bit
Message-Id: <20251125-dts-add-gpio-to-io-expander-v4-1-e6d31f80470c@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIANlBJWkC/43NwY7CIBDG8VcxnHcMUIZ2PfkexgMdBuWw0EDT1
 Ji++6InkzVmL5P85/D77qJyiVzFYXcXhZdYY04tzNdO0NWlC0P0rYWWGpWSFvxcwXkPlylmmDO
 0y+vkkucCzlCniQJa50QTpsIhrk/9dG59jXXO5fYcW9Tj+z93UaBgNL1Fkt+aRz6GGCHklXJKe
 8o/4qEv+lXsP4u6iTigN8NgEI19L3Yvopafxa6JNFqUjnobBvwrbtv2CxBfBOlwAQAA
X-Change-ID: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, Kimi Chen <kimi.zy.chen@fii-foxconn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764049476; l=2917;
 i=kimi.zy.chen@fii-foxconn.com; s=20251105; h=from:subject:message-id;
 bh=XlfLH7aJAuTw4x56m8cEY+a7zkKS1LZ5QGzrmf+4eBo=;
 b=NVYxgBZKetYbHl9F3aQlJ7gp9sSKijq+JKD+rU92nilq7JM5ipsoFXrjWvIGef2z64tNRTNIQ
 qSN5/IqtucmCxhNuRN8OiiBkm4RQXn/SyVOOPkY8buZeVkVwKT1wjQE
X-Developer-Key: i=kimi.zy.chen@fii-foxconn.com; a=ed25519;
 pk=3zHetsW/3CYYIgQlYV9dqSS7aW7aZXLUaIvc+OKr3NM=
X-Endpoint-Received: by B4 Relay for kimi.zy.chen@fii-foxconn.com/20251105
 with auth_id=559
X-Original-From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
Reply-To: kimi.zy.chen@fii-foxconn.com

From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>

The chassis power cycle process requires a forced shutdown before
cutting off the standby power. The SCM CPLD implements a hard shutdown
host function that is controlled through the IO expander in the
Clemente platform.

This change adds a new GPIO line named "shdn_force_l_cpld" to the
PCA9555 IO expander's gpio-line-names at index 10. When asserted,
this GPIO signals the CPLD to pull the HPM's SHDN_FORCE_L pin low,
which triggers a forced host shutdown.

Signed-off-by: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
---
Changes in v4:
- Rebased onto latest kernel; corrected "shdn_force_l_cpld" positioning
  in gpio-line-names from line 6 (v3) to index 10 (dts array index, not device pin).
- Updated commit message to clarify "index 10" refers to gpio-line-names
  array position, not PCA9555 device pin.
- Link to v3: https://lore.kernel.org/r/20251120-dts-add-gpio-to-io-expander-v3-1-cb650ac76f85@fii-foxconn.com

Changes in v3:
- Improve commit message clarity: restructure the description to clarify the 
  complete signal flow (BMC → IO expander → "shdn_force_l_cpld" GPIO → CPLD → 
  SHDN_FORCE_L pin → HPM → forced host shutdown).
- Rename GPIO line to match the schematics net naming convention.
- Add rationale: The current standby-AC power cycling process is suboptimal.
  When HSC power is turned off while host power remains active, the FPGA may
  detect a power fault. During this fault window, the FPGA—sustained by holdup
  capacitance—asserts power brake and initiates power-down sequence. A forced
  shutdown before cutting standby power ensures the FPGA properly handles the
  AC cycle event without spurious fault assertions. This patch enables the BMC
  to perform forced shutdown via the IO expander GPIO, thereby optimizing the
  standby-AC power cycling process.
- Link to v2: https://lore.kernel.org/r/20251107-dts-add-gpio-to-io-expander-v2-1-585d48845546@fii-foxconn.com

Changes in v2:
- Add "hard_shutdown_host" GPIO line name to PCA9555 IO expander for Clemente platform.
- Link to v1: https://lore.kernel.org/r/20251106-dts-add-gpio-to-io-expander-v1-1-b4765c092ebe@fii-foxconn.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 885c50a7d665..dfe8f6d0eeef 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -1013,7 +1013,7 @@ io_expander4: gpio@4f {
 			"",
 			"",
 			"",
-			"",
+			"shdn_force_l_cpld",
 			"",
 			"",
 			"",

---
base-commit: f5f4511ccb747e01ed5364e9eec7be8b62020c4b
change-id: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa

Best regards,
-- 
Kimi Chen <kimi.zy.chen@fii-foxconn.com>



