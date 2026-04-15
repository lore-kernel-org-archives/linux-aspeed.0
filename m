Return-Path: <linux-aspeed+bounces-3904-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C6BF41986
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 10:25:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwchz4Wx1z2yvL;
	Wed, 15 Apr 2026 20:25:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776248707;
	cv=none; b=TIeTNFx2/OyYZ4g/hiQ1M4DKkFP2n9tspq3EEFQsDe/BYmPRbnmOjDLfh39zjK8wE/ZF/h+p3840CLKeLQtY8zSD/+NMkEJfepqIDwKDkYHsGvIAZ5ulAJn8RH/v2KkuCLOYI6IaaaBWTLHUnGB2BL4LE5Wo0QYyJqIS4+jipXXsWIimTZPc7EXpg44ZDj0tdgwr5tQrpds7ufLuMS+yEb4+uxSfHCvdz9hs9E7PHTpRcytlbjvhU7XnX6SjVpqiDfI8l8ykuVUi/HHbdadtbxrlajypOPQ+MRgwxbv5wvToK1/vLmlGwsc0wGUGz4dAiWkuOxHh/UbTxCh9pcl4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776248707; c=relaxed/relaxed;
	bh=fUoVCq31af6XYyzexqFt5Aja7lKfBwRcK204Ab+AUAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EVPofZLZhBSYi6AFhGnNKatkMiCgtz2NrP9myJg/FOMnglo3vY/LpOZUbaihhpNSXuHqCbTw2WMpTWRyKSnmx1dRJqHMRSkTgVvyc92PuRLZ2bYAoYVleFHiLCQyyfPTM8lMqPJqnWWGBHluUhS0eGv8sZ+WFsVXYzXiIxjVHEVzE4FP5xBVfXs+BiJ8Ljedz64C2czxiMOzgClyidvnmAh5nhPAr8DOLd85UWIcQOPgUHFdba6OR9/jhJGg8eWd2Ix/sNsaGErPWZTTUFOzpaHMOCzey6NcUoKH/KuyqBEo/lzwneVUzmwb7C2pkM0wwk0tj7yt9jM3eAAA9xa68w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwchy1Kpvz2yvG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Apr 2026 20:25:04 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Apr
 2026 18:24:46 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Apr 2026 18:24:46 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 15 Apr 2026 18:24:42 +0800
Subject: [PATCH] gpio: aspeed: fix AST2700 debounce selector bit
 definitions
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
Message-ID: <20260415-gpio-fix-v1-1-b08a89b31e6f@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAGln32kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0NT3fSCzHzdtMwKXUNzE1NTC+PU5DQDMyWg8oKiVKAw2Kjo2NpaADr
 KCulaAAAA
X-Change-ID: 20260415-gpio-fix-1745583ecf06
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776248686; l=1387;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=mm7hDoKN7iti+b5vLqDrPKkhJ+rkkywvY8n22UKL7Q4=;
 b=xltRCYSWnLbGHqjv3iCcpoxcxMICHhXNHsq8rZVGdgeOxVKQIMYm7j5TcRzziaAqE2G5qfqW0
 t13s1XuI2pMA6PQpU3uoagyImsMSbktSm1U/OoH2Ac9o2mabPBnwVlk
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The AST2700 datasheet defines reg_debounce_sel1 as the low bit and
reg_debounce_sel2 as the high bit. The current driver uses the AST2600
mapping instead, where sel1 is the high bit and sel2 is the low bit.

As a result, the debounce selector bits are programmed in reverse on
AST2700. Swap the G7 sel1/sel2 bit definitions so the driver matches the
hardware definition.

Fixes: b2e861bd1eaf ("gpio: aspeed: Support G7 Aspeed gpio controller")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 9115e56a1626..98b5bfbc04a3 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -42,8 +42,8 @@
 #define GPIO_G7_CTRL_IRQ_TYPE1 BIT(4)
 #define GPIO_G7_CTRL_IRQ_TYPE2 BIT(5)
 #define GPIO_G7_CTRL_RST_TOLERANCE BIT(6)
-#define GPIO_G7_CTRL_DEBOUNCE_SEL1 BIT(7)
-#define GPIO_G7_CTRL_DEBOUNCE_SEL2 BIT(8)
+#define GPIO_G7_CTRL_DEBOUNCE_SEL2 BIT(7)
+#define GPIO_G7_CTRL_DEBOUNCE_SEL1 BIT(8)
 #define GPIO_G7_CTRL_INPUT_MASK BIT(9)
 #define GPIO_G7_CTRL_IRQ_STS BIT(12)
 #define GPIO_G7_CTRL_IN_DATA BIT(13)

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260415-gpio-fix-1745583ecf06

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


