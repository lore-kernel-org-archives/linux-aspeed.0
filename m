Return-Path: <linux-aspeed+bounces-2382-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3A9CAC5B8
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Oct 2025 09:57:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccnJj5srQz3cg1;
	Thu,  2 Oct 2025 19:57:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759399029;
	cv=none; b=mqAO6JNmr52cLl4G2MeL36Jo9oMQmeHDE06BAAzMHRamhNQBwcGbKgBLyxv9DlZeAInnCtBOcN/T0r8fITW7yLQUJrQYTlUddqMGrtzXRv2msT05qtE0XrNJEBXFIaDbM0x02EEUFXRMxJL0Xgj+gCdceTyZBKG7DCUV+rSBPoazxbjeiYC4dWQhuu7OweDZxz5Ybj7NA9/PcFjm+h7ms6FKdK0rKrfTza2yq7aET8FZbX+zosDm6WrieXhLvvG4rYHlx4p36WiNDB8ZP5sJShxx1VijZg4uyeF19rIGGCr0jUVkZPOX1SiaeLSYyvKaZ7hqDckcyot2rKlqGZzcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759399029; c=relaxed/relaxed;
	bh=UNv3b1LV1oc60rdjH6HeSpWhFtcDp87XphoA4vFQrBk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Htx84J7v5MNJYs3b3BcgXNU0F3Edw0/iirvJlGYqkdQcPV/sJ8HhpoeW0CJyd3kKNgVpru2Z6rU/BuerGnuxo+ddMnQ+B9wyEGbDxGcC8EXbFwRVi/3ze7zM904PpfQoMyAPlME0V50UBbomFxdydGOE97UfBiSXB+cj0ylMgyaAaxmx9Dmqmfaz5HOXB8iOrudBoH4xDOCShS01JlH5kXxRMsp1RZv2+cYQ/P3IbzpLAkXbd5VhpkTBsnr9KISgjd3jA4LLbaP8zOxpw634+BNorpgBFAV0J6lIVLgOJXsQpwzJAUWwMPaF7tbwLJPwHKgqhYfUhCqXdzUFBdrDBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccnJj0HH0z3069
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 19:57:08 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 2 Oct
 2025 17:56:51 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Oct 2025 17:56:51 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset definition
Date: Thu, 2 Oct 2025 17:56:51 +0800
Message-ID: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain

Add VIDEO reset bit definition for AST2500/AST2600.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 include/dt-bindings/clock/aspeed-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index 06d568382c77..421ca577c1b2 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -53,5 +53,6 @@
 #define ASPEED_RESET_AHB		8
 #define ASPEED_RESET_CRT1		9
 #define ASPEED_RESET_HACE		10
+#define ASPEED_RESET_VIDEO		21
 
 #endif

base-commit: 7f7072574127c9e971cad83a0274e86f6275c0d5
prerequisite-patch-id: 80cfedcb62367922b1e875e8e734ced8f7cc19ba
prerequisite-patch-id: d74dc2e0aff712f033ca5c2f299410ae92867d8c
-- 
2.25.1


