Return-Path: <linux-aspeed+bounces-4160-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAE1CD6E57
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 23:45:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVSB13bBPz2yS4;
	Wed, 03 Jun 2026 09:45:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780406708;
	cv=none; b=L5FT7haaRu7T+BaHLfh3z24R+/ND2Us6Zhw5oDP1l07I/z1DpZ4nhQLZFronFhKs6mGdwX8xJcpPOnPVW5iKJ4NDu+4TdKGrqnhot1qU42VlC6hQ7rNj8Yb4zLhIyJHOETW7YvE2cBb7UwD64c3TEg08KTufGnYmJV9HBb83gqTnwXmNmX+k3QHQm+Cjg+t0BkCfIQvtzp7TmTWfQ5BEFC9jXZAemVefAPLgO2lzK7lTjfjY5UNcTN5mmTFzxtZUYoH/NAOwkn9s+CsBDtsFxGHMxdUo9hs4qxcSLdrUzL3U8Xphpi9XeF/9E4Kh5I17+DQJFR1brqhiXFRjQ7+GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780406708; c=relaxed/relaxed;
	bh=D6gquGGgLgO+WovyzPeXpu39UWQ0ZoG7dv8HxT/OM8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4Iy5pUDR9aCTB2WY3L0x+TaQNf511xd+Ux0lI1FHxCY5TzpfrvTIccG92nuB7LnONORzWVD7l2Re0zMphIkGaPE0dCqF6eK6EvatGWY1UpFUnELoX/tql+RaPw8Bta8yoNxUCErH3SfOUIcTjjLQUZmNza+TKPANO0xDHAvEKCbype1HrB0DRKjUl/wBFrmmrbn8TUxYd6wprBCwhvPJb9nUmr5YAPsb/iFjnwO4udHHW5AezqC+BujTes3vBbGxFgDFZ/MmgzfMg2C2leWragcOMQ5ZbVWydPD0PkDSvTlGfKv5btL6SC1mjdDC7YFGB8b8N/6T2isO9fApPUjlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iIliYIeR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iIliYIeR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVBQW3bySz2xLm
	for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Jun 2026 23:25:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B90B044555;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89ECAC2BCC9;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780406704;
	bh=0B2cjxvLooufr1CsGKSgDR7A32ZSE9y3xVQJvm8b+Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iIliYIeRFoJm1ilhjjng+HRx2lTC7n2PPO02C9Zxjv1jaL1uwnpm1mlXG9RMso40Q
	 dO22FgD/P6+sBfrM/G8uYebeGhh7rY1ojLOlJAEHplMe0ZcrVyENZldPtzR9z89edW
	 //GOtZ8WoYej4sHsl2qMZ1crSk4n//JIqpwccq+RT2atA8mS3XMX2Q4d7jbtyG/3Hi
	 tt+1KiNIo6uy7nANeFU8dP4cfiPjHd4l9g9gRQCAvcbj2VGHjS1Yv3Fh3YIvCMc/vI
	 zKB2cMxalQz6Pk9pf75jNJObKWiYzZwrmKf433aHHsE9nRkS/dhivp3zCedQmazePX
	 zIx2SYDLidC/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741FCCD6E4A;
	Tue,  2 Jun 2026 13:25:04 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 02 Jun 2026 21:24:56 +0800
Subject: [PATCH v3 1/9] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2 DVT
 board
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
Message-Id: <20260602-anacapa-devlop-phase-devicetree-v3-1-7c93c5df8d9b@gmail.com>
References: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
In-Reply-To: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780406700; l=932;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=Mdgtp8BwSQD3eHvGI9wfdGeT4rx+6rxoxRX7WxtcMqI=;
 b=/tNsTUJPyHrZBJTcMMXijcmXOk3XEJwsxiYcMXQ+5GitFkdQGXwUwI/DXnOOxpjX9F2uNXg63
 r2dJJ8J1MvDCpTIlPGxvW1uGZErAuD7TJrF1HlZi1cnPQG9hwNuUMo1
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Document Anacapa BMC EVT1, EVT2, and DVT compatibles.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9ba195b8f22d..d3e9d9a2f881 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -84,6 +84,9 @@ properties:
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
+              - facebook,anacapa-bmc-evt1
+              - facebook,anacapa-bmc-evt2
+              - facebook,anacapa-bmc-dvt
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc

-- 
2.34.1



