Return-Path: <linux-aspeed+bounces-4151-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0D0CD5BD1
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Jun 2026 09:14:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTSvn6J7pz2xmV;
	Mon, 01 Jun 2026 19:14:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780305269;
	cv=none; b=TzBivXf3pxU0s1ilq+m2UriKnRr8p2y5C3jSM+2lSkoOp1bhQMWCYhBgwuCM3rDXInCqICnoJrazHAxrYzq/a5tGg+VrERL7HgPiENN+l78cqpHQSzz4XlDWYnIkNBvsaNAC52TLPNr0/JzDD2SXiEJTtL0cZFOU7XoM5ayLQU5LjVoJnueyuIZWBPi+we5l/ZmZPbW5Z9haEF+7rML7u5TbTQSqDDSDj8fwVN3ysD3na5dyFcjRVtcKqbHzLZS3i/sG/0Tw1PxMgaC3iyX6fS3EApQz09GS8d9Eqb5AxtGYnPBbAgsU0Mrrr9hr0bqqUIyV9Y4yhIBVa1L27B5rtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780305269; c=relaxed/relaxed;
	bh=q7Pe+MIjaP0GckUzKiVimtbYf2O8ZGKXwMtUS0jmzkY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ELh84tebq6NxoyXVxa5amgkQo0jTTpF6oUv/h481VcpLpr4dWR/mqVK8JfFXUVbK6lpKAnSx5qyAqAaTg7Uy98TVZTDfQh43E2Qtrofy+rqpVywfujNB4K+T1Fpw1g2gCpdx2VZQH5DpzhYYkrGY/QrOqq3WL9ZPcHMIIqmZo3YBYa4WAqT8Zs9MosWVzxmcZ5b34bEl21EfPerBZaatrne2/RTPvWt4Du3NKkZzNUjEK/rFaRkbAvPw+eeBOmlKVXuAJ0j2lpYH2HFZdCVYMEcRkor6a19wXBTZ/sXBu7sf68JxFc4e1baEUa9Lt8cCHdNlzzWoc/H8k1QhTEcrQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=tommy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=tommy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTSvm3c3Hz2xdb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 01 Jun 2026 19:14:27 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 17:14:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 17:14:10 +0800
From: Tommy Huang <tommy_huang@aspeedtech.com>
Subject: [PATCH 0/2] rtc: aspeed: Add AST2700 RTC support
Date: Mon, 1 Jun 2026 17:14:05 +0800
Message-ID: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAF1NHWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwND3cTiEiNzAwPdopJk3RSTxJQkU8MUI0MTCyWgjoKi1LTMCrBp0bG
 1tQD52m9pXQAAAA==
X-Change-ID: 20260601-ast2700-rtc-d4adb51d2148
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, Tommy Huang <tommy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780305250; l=637;
 i=tommy_huang@aspeedtech.com; s=20260601; h=from:subject:message-id;
 bh=BIVqZiBYz0UJFJj0e/Ht6rWfSBtx/Fyk2CN8Z7NBoqw=;
 b=k+dRNdw4ySTci6bzre+yAKaseUFPXui2dpoGU5J7TDjLJOtLdZMBf13b3+uyAeFodlxfG31+p
 UVXjbQSHHl7Dpg8yNLgXtNHBc6e02DHP6LdIkxtAgbTYnHpWIlvAp67
X-Developer-Key: i=tommy_huang@aspeedtech.com; a=ed25519;
 pk=/SRU8iPtlyPCtlX7hXjYJhOTpCUdfEZ9pIVVyCQOjLE=

This patch series adds support for the ASPEED AST2700 RTC define,
includeing dt-binding in the Document and rtc-aspeed.c

Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
---
Tommy Huang (2):
      dt-bindings: rtc: add ASPEED AST2700 compatible
      rtc: aspeed: add AST2700 compatible

 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 ++
 drivers/rtc/rtc-aspeed.c                               | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260601-ast2700-rtc-d4adb51d2148

Best regards,
-- 
Tommy Huang <tommy_huang@aspeedtech.com>


