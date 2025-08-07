Return-Path: <linux-aspeed+bounces-1930-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14705C87FCF
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Aug 2025 13:29:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bySgK5smcz3cRs;
	Thu,  7 Aug 2025 23:29:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754573357;
	cv=none; b=gB3Jk8CVevHV5md0kk0ylotcIxiuypGP8VdonNceBI7Oc34gYIYV8elHZwBfqEol1A1Gg4+opTg9Z7PfF1VFiBPs11ArlLu7FOILWTTR8q/H7ZwaUMUOKTiw21qEfw935T9cJSbpTBAQYBpj8U0y/Y9btYx6BGPNZ/lBbO0p2Hc7D6M5XWbzgDv2ClhMhN5fMYUwfS1aRg/5S8h/zdVYghgBzbFSL4Pes+YD3afFkiFqPNFaNscBP7NH3hezS1nyBmZAAyBBwBsM/2d9Jz++UM+tLzr2CXorgaBQ4WcnIsEMS2tV28iGyGOPiFkZDu+9HHuiQe192+tSepoh6a8JGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754573357; c=relaxed/relaxed;
	bh=i2cv+ljq9/iSwRq9kuiT1B+CMizj0zq2pLMXcAzAs90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmZN6WByx8DFdSYvCkf7Eb4RzqiRTdHCx6Pr8rpAFHZgZrpfs19VpYfLFz9oOFWb7XcY96BqKiBXCItgY9VUK0M0MdIk7I+/crIsp4wJjq3bsNxuEkmTrvrSxoRbgigEDqvhtIK46YG5EcNtZ1iZIYW7BJ5osCV79QUYzqtTqMj/GsKUQ9jUtQOf9PGj6uNfFu/T9B6DVAjTl6xTM2hGTzDky6d6zlJMsVQnzTx596KBL00qkKHOeXT7Kjt20pNyxtCEryjM5q5dF6x1HX6sA0SqGd1/7XIUrwc6Np2Xoz/Ij0MG9rK+HGJpRdSHCTcw5t0oWqv0XqkYE8JqeJxqfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fdH50sZk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fdH50sZk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bySgK272dz3cRn
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 23:29:17 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 72CAF601BB;
	Thu,  7 Aug 2025 13:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16415C4CEEB;
	Thu,  7 Aug 2025 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573354;
	bh=cdCOhY1Kx0+VMbY2fmJzeqOhQxEfpe/s5pe8/mpr8oI=;
	h=From:To:Cc:Subject:Date:From;
	b=fdH50sZkCPkZ5YhsmHuypP27Q6dcAah/XTEns6CZoxVZHHD0K4k0xcdsffjLVNGHi
	 ezM8uqmxoaY1nqQzHVfiSBSObNvbEyyYjlP2kbt2YY3mZlnzOBNwdUXQAGHaElPQXj
	 tsjLxwU3lubnul9g97n/1bcN1KTz7r7tN3klFZwdRsZ+7CICuuvyinRVVwCogoRQFs
	 MAKMXSe5/RnJSdoXfjOgtPOR1Cg4GxF2p5uijesxX+089O7nFbuqFvger7Ms+iHhz5
	 NppMFQRzcex0f10xFVJTA4VfMNYbLwxjWJC/kkqFnFCA9yk3kufB7+UHbpek8M3OaN
	 YQdvvx7ayVhgw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: aspeed-lpc: Add missing "clocks" property on lpc-snoop node
Date: Thu,  7 Aug 2025 08:29:08 -0500
Message-ID: <20250807132909.3291770-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
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

The ASpeed lpc-snoop nodes have a "clocks" property which isn't
documented. It looks like all the LPC child devices have the same clock
source. Perhaps it is the parent device that should have the clock, but
it's too late for that. The driver for lpc-snoop requires a clock to be
present.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index d88854e60b7f..f329223cec07 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -137,6 +137,9 @@ patternProperties:
       reg:
         maxItems: 1
 
+      clocks:
+        maxItems: 1
+
       interrupts:
         maxItems: 1
 
-- 
2.47.2


