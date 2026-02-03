Return-Path: <linux-aspeed+bounces-3469-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A1EE8304E
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 03:55:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4qQ84KTsz30M0;
	Tue, 03 Feb 2026 14:55:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770090928;
	cv=none; b=mZghAHpX/5YH9zWv/BTgDVwS5xAFyui84FOKo2vt7PoZcro/Q/A63LNBbCH85rUMFGtAqB9RKtoRyLbCtE59n1Bk/ly8kg3b7Nb9J8ojU9QNphgEdJTdJFSafnkwd1P7mBRyhjbFs5oLYCBOqUxcMVy5fDmUbvRTbrJp6CLTGBBFwZPcL5QoVxaGFY0W61HINcIz98zAgvjiulEc2kOKJHZ8X/IN8u1OzA7zcZcxryDU29/wIfE7CQq8Su57kDtabnzOxS07/MVMAnAX5vRZjYlcnsICQsaZRItMtty8wVZB/HBWpUqkcL7nkb9D9vnT/bPuNekgfSN4ZYJCrgY+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770090928; c=relaxed/relaxed;
	bh=Eficn5SUDprprqXIyWY8ZmcbLH8EHfhxDKGE8oULaPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IC1xPtMFNISIvCPEASPF6SjBKlnZ0GymiRjlNFuKTEx5UqrHKpVAtrXse6i/BAq+vDas31pxU3RSHaJJYShI+gtq4awg8kQxC3opcJEO9UweQ0ZK0tzpm4HLmx5sS7EX+BUiIgnKuZlLWYSmHR6zN0aIhScp2N3sJJdhRfsUekwEzWzmMnHATgKg2LSN17DjZF+JXZIfvOWAtpfr4/lRjpkiaYOZojb9FXIjr5rmdZpvlaflG3lK/TTnHHUXnd84YUqH6W4Ll9aMhOuyB4IDg1T/A9NQCBPxiJDJ9wzej5BChFwr0CPix33SySuuqYbdizY4r3obee2xQWR820VxBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4qQ75NGVz309y
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 14:55:27 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 11:55:11 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 11:55:11 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 3 Feb 2026 11:55:09 +0800
Subject: [PATCH 2/2] soc: aspeed: uart-routing: Add AST27xx dual node
 support
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
Message-ID: <20260203-upstream_uart_routing-v1-2-6bd5dd75ee3b@aspeedtech.com>
References: <20260203-upstream_uart_routing-v1-0-6bd5dd75ee3b@aspeedtech.com>
In-Reply-To: <20260203-upstream_uart_routing-v1-0-6bd5dd75ee3b@aspeedtech.com>
To: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Oskar
 Senft" <osk@google.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jammy Huang
	<jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770090911; l=12415;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=C+gKHTXPGEeSoSOHR1iwE6giVzW3rWmmmHtDD/QYRfU=;
 b=fZlFakSoNkWt98SJsU/kor2vLlCtWPDjRhDRsuZ0UkZIDIg9I/UzrLDx/WWAIVs7xDPa/K+ST
 Db8fOKbX5i+BykSeIS6I9iVQ64Yh8PcN4369URfifXi6ScstLnQCa4v
X-Developer-Key: i=jammy_huang@aspeedtech.com; a=ed25519;
 pk=E5YwijeJZZcuDR6srvwNlXrNHvLxwipUg3Mb/xxUF9o=

From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>

Add dual node support for AST27xx SoCs.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/soc/aspeed/aspeed-uart-routing.c | 424 +++++++++++++++++++++++++++++++
 1 file changed, 424 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index 0191e36e66..9b648f5a1b 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -15,20 +15,30 @@
 #define HICRA	0x9c
 
 /* attributes options */
+#define UART_ROUTING_IO0	"io0"
 #define UART_ROUTING_IO1	"io1"
 #define UART_ROUTING_IO2	"io2"
 #define UART_ROUTING_IO3	"io3"
 #define UART_ROUTING_IO4	"io4"
 #define UART_ROUTING_IO5	"io5"
 #define UART_ROUTING_IO6	"io6"
+#define UART_ROUTING_IO7	"io7"
+#define UART_ROUTING_IO8	"io8"
+#define UART_ROUTING_IO9	"io9"
 #define UART_ROUTING_IO10	"io10"
+#define UART_ROUTING_IO12	"io12"
+#define UART_ROUTING_UART0	"uart0"
 #define UART_ROUTING_UART1	"uart1"
 #define UART_ROUTING_UART2	"uart2"
 #define UART_ROUTING_UART3	"uart3"
 #define UART_ROUTING_UART4	"uart4"
 #define UART_ROUTING_UART5	"uart5"
 #define UART_ROUTING_UART6	"uart6"
+#define UART_ROUTING_UART7	"uart7"
+#define UART_ROUTING_UART8	"uart8"
+#define UART_ROUTING_UART9	"uart9"
 #define UART_ROUTING_UART10	"uart10"
+#define UART_ROUTING_UART12	"uart12"
 #define UART_ROUTING_RES	"reserved"
 
 struct aspeed_uart_routing {
@@ -488,6 +498,416 @@ static const struct attribute_group ast2600_uart_routing_attr_group = {
 	.attrs = ast2600_uart_routing_attrs,
 };
 
+/* routing selector for AST27xx node 0 */
+static struct aspeed_uart_routing_selector ast2700n0_uart9_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART9),
+	.reg = HICR9,
+	.shift = 12,
+	.mask = 0xf,
+	.options = {
+		    UART_ROUTING_IO9,
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_IO3,
+			UART_ROUTING_RES,
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART12,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_io9_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO9),
+	.reg = HICR9,
+	.shift = 8,
+	.mask = 0xf,
+	.options = {
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART12,
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_IO3,
+			UART_ROUTING_RES,
+		    UART_ROUTING_UART9,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_uart3_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART3),
+	.reg = HICRA,
+	.shift = 25,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO3,
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_IO9,
+		    NULL,
+	},
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_uart2_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART2),
+	.reg = HICRA,
+	.shift = 22,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_IO3,
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_IO9,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_uart1_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART1),
+	.reg = HICRA,
+	.shift = 19,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_IO3,
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_IO9,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_uart0_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART0),
+	.reg = HICRA,
+	.shift = 16,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_IO3,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_IO9,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_io3_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO3),
+	.reg = HICRA,
+	.shift = 9,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART9,
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_IO9,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_io2_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO2),
+	.reg = HICRA,
+	.shift = 6,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART9,
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_IO0,
+		    UART_ROUTING_IO1,
+		    UART_ROUTING_IO9,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_io1_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO1),
+	.reg = HICRA,
+	.shift = 3,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART9,
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_IO3,
+		    UART_ROUTING_IO9,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n0_io0_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO0),
+	.reg = HICRA,
+	.shift = 0,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART0,
+		    UART_ROUTING_UART1,
+		    UART_ROUTING_UART2,
+		    UART_ROUTING_UART3,
+		    UART_ROUTING_UART9,
+		    UART_ROUTING_IO2,
+		    UART_ROUTING_IO3,
+		    UART_ROUTING_IO9,
+		    NULL,
+		    },
+};
+
+static struct attribute *ast2700n0_uart_routing_attrs[] = {
+	&ast2700n0_uart9_sel.dev_attr.attr,
+	&ast2700n0_io9_sel.dev_attr.attr,
+	&ast2700n0_uart3_sel.dev_attr.attr,
+	&ast2700n0_uart2_sel.dev_attr.attr,
+	&ast2700n0_uart1_sel.dev_attr.attr,
+	&ast2700n0_uart0_sel.dev_attr.attr,
+	&ast2700n0_io3_sel.dev_attr.attr,
+	&ast2700n0_io2_sel.dev_attr.attr,
+	&ast2700n0_io1_sel.dev_attr.attr,
+	&ast2700n0_io0_sel.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ast2700n0_uart_routing_attr_group = {
+	.attrs = ast2700n0_uart_routing_attrs,
+};
+
+/* routing selector for AST27xx node 1 */
+static struct aspeed_uart_routing_selector ast2700n1_uart10_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART10),
+	.reg = HICR9,
+	.shift = 12,
+	.mask = 0xf,
+	.options = {
+		    UART_ROUTING_IO10,
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_IO8,
+			UART_ROUTING_RES,
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART12,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_io10_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO10),
+	.reg = HICR9,
+	.shift = 8,
+	.mask = 0xf,
+	.options = {
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART12,
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_IO8,
+			UART_ROUTING_RES,
+		    UART_ROUTING_UART10,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_uart8_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART8),
+	.reg = HICRA,
+	.shift = 25,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO8,
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_IO10,
+		    NULL,
+	},
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_uart7_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART7),
+	.reg = HICRA,
+	.shift = 22,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_IO8,
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_IO10,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_uart6_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART6),
+	.reg = HICRA,
+	.shift = 19,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_IO8,
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_IO10,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_uart5_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_UART5),
+	.reg = HICRA,
+	.shift = 16,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_IO8,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_IO10,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_io8_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO8),
+	.reg = HICRA,
+	.shift = 9,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART10,
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_IO10,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_io7_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO7),
+	.reg = HICRA,
+	.shift = 6,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART10,
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_IO5,
+		    UART_ROUTING_IO6,
+		    UART_ROUTING_IO10,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_io6_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO6),
+	.reg = HICRA,
+	.shift = 3,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART10,
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_IO8,
+		    UART_ROUTING_IO10,
+		    NULL,
+		    },
+};
+
+static struct aspeed_uart_routing_selector ast2700n1_io5_sel = {
+	.dev_attr = ROUTING_ATTR(UART_ROUTING_IO5),
+	.reg = HICRA,
+	.shift = 0,
+	.mask = 0x7,
+	.options = {
+		    UART_ROUTING_UART5,
+		    UART_ROUTING_UART6,
+		    UART_ROUTING_UART7,
+		    UART_ROUTING_UART8,
+		    UART_ROUTING_UART10,
+		    UART_ROUTING_IO7,
+		    UART_ROUTING_IO8,
+		    UART_ROUTING_IO10,
+		    NULL,
+		    },
+};
+
+static struct attribute *ast2700n1_uart_routing_attrs[] = {
+	&ast2700n1_uart10_sel.dev_attr.attr,
+	&ast2700n1_io10_sel.dev_attr.attr,
+	&ast2700n1_uart8_sel.dev_attr.attr,
+	&ast2700n1_uart7_sel.dev_attr.attr,
+	&ast2700n1_uart6_sel.dev_attr.attr,
+	&ast2700n1_uart5_sel.dev_attr.attr,
+	&ast2700n1_io8_sel.dev_attr.attr,
+	&ast2700n1_io7_sel.dev_attr.attr,
+	&ast2700n1_io6_sel.dev_attr.attr,
+	&ast2700n1_io5_sel.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ast2700n1_uart_routing_attr_group = {
+	.attrs = ast2700n1_uart_routing_attrs,
+};
+
 static ssize_t aspeed_uart_routing_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -580,6 +1000,10 @@ static const struct of_device_id aspeed_uart_routing_table[] = {
 	  .data = &ast2500_uart_routing_attr_group },
 	{ .compatible = "aspeed,ast2600-uart-routing",
 	  .data = &ast2600_uart_routing_attr_group },
+	{ .compatible = "aspeed,ast2700n0-uart-routing",
+	  .data = &ast2700n0_uart_routing_attr_group },
+	{ .compatible = "aspeed,ast2700n1-uart-routing",
+	  .data = &ast2700n1_uart_routing_attr_group },
 	{ },
 };
 

-- 
2.34.1


