Return-Path: <linux-aspeed+bounces-3849-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF2CFB518D
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 03:08:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqWNs3J6Rz2ygp;
	Tue, 07 Apr 2026 13:08:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775531309;
	cv=none; b=kh/rp5rVyvVnkJENIcFQhGKPzP7xKUL+EXdLO7UlbA8N4jWOliXZQzDl+aCjIfjXTPVOv1irScTzXq8DEwUUIYlYiTQATKBPtk06GZYRSxDf2Yot3QBAunwo1yynDC//obsdihcGWHE36MSFzejmKGLkSNGaZoiF7LGHm2H5DFqGcBY+IDz58glmLNsJY7J0vgSPJGrJ1NzeBHQS/FKLtv/hMCFEuoAEYM9V2Ao2vHZ+FM+CjQs6by7f7m37Ay8V/VlAdADtVQJCE2QGHZNKUuB5jlc0Qcrm4AjUL6l0om3IQ7gXSNediDkIn7Lh60r2ISJnR3HIHmuZ37ey2Z+i7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775531309; c=relaxed/relaxed;
	bh=jvXGsbLmIHtwxyCYQjYEdWkWVArvaM4bhcpAj1sYMb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=F7uFVBjh2Aepg6deQBNTjhFrZYD611Sr5LG0qaaUl1spN7YvELRkgKyidtfqbkv1TSyKJqP6NzxwA+9CC3gMirjMW6xQX7d8UlCmvsajXRCiC4oyPUuiGGQDJ29UTJU7m3jzmt9gfpfXKANtAazCGDmPyquycD6uaPpg/2HhYh3M1YwwOcyim5FL1GCvpDKM4NSAOATZ3zALNRnwitTOehssCIwu/HflxBceWYnXS5cmYA08CwaFLGCo3xUMhSKOAp12ZBFbSTYM5mD0uS8kEDoP9MAUm0uaIYb8dIcI3wzsxjC5OhsgaD0jLdMmwDH5XvaspSO1lX2keDVca2SwrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqWNr2xSPz2xQs
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 13:08:28 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 7 Apr
 2026 11:08:05 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 7 Apr 2026 11:08:05 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 7 Apr 2026 11:08:06 +0800
Subject: [PATCH v5 3/4] irqchip/ast2700-intc: Add KUnit tests for route
 resolution
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
Message-ID: <20260407-irqchip-v5-3-c0b0a300a057@aspeedtech.com>
References: <20260407-irqchip-v5-0-c0b0a300a057@aspeedtech.com>
In-Reply-To: <20260407-irqchip-v5-0-c0b0a300a057@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775531284; l=15577;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=0sLR6BB/w8nrHF2voMDdQ7Ck+6iZYGuYex8Z6iat808=;
 b=oALstVX3nuBZA6On1anELklfPOi4sb15t/Mw9LA3R2Wl4h0K392+r1zeSypxVWg6BIQbyz6qL
 peuSMDBUtOsB4s/dfldK7D5g9tLxpEOqXjFo8BnJVWxOWLvtVOPiH2J
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add a KUnit suite for aspeed_intc0_resolve_route().

Cover invalid arguments, invalid domain/range data, connected and
disconnected mappings, and malformed upstream range cases.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v5:
- modify enable CONFIG_PROVE_LOCKING irq lock inversion dependency
  detected.
Changes in v4:
- fix warning: the frame size of 1296 bytes is larger than 1280 bytes.
Changes in v2:
- add line break before include "irq-ast2700.h"
- remove pointless newline.
- rename arm_gicv3_fwnode_read_string_array to
  gicv3_fwnode_read_string_array
- add .kunitconfig file
---
 drivers/irqchip/.kunitconfig             |   5 +
 drivers/irqchip/Kconfig                  |  11 +
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-ast2700-intc0-test.c | 473 +++++++++++++++++++++++++++++++
 drivers/irqchip/irq-ast2700-intc0.c      |   3 +-
 5 files changed, 492 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/.kunitconfig b/drivers/irqchip/.kunitconfig
new file mode 100644
index 000000000000..00a12703f635
--- /dev/null
+++ b/drivers/irqchip/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_OF=y
+CONFIG_COMPILE_TEST=y
+CONFIG_ASPEED_AST2700_INTC=y
+CONFIG_ASPEED_AST2700_INTC_TEST=y
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0156fee89b2c..143af3f30a4b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -122,6 +122,17 @@ config ASPEED_AST2700_INTC
 
 	  If unsure, say N.
 
+config ASPEED_AST2700_INTC_TEST
+	bool "Tests for the ASPEED AST2700 Interrupt Controller"
+	depends on ASPEED_AST2700_INTC && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for AST2700 INTC route resolution.
+	  The tests exercise error handling and route selection paths.
+	  This option is intended for test builds.
+
+	  If unsure, say N.
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 62790663f982..ac04a4b97797 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ASPEED_AST2700_INTC)	+= irq-ast2700.o irq-ast2700-intc0.o irq-ast2700-intc1.o
+obj-$(CONFIG_ASPEED_AST2700_INTC_TEST)	+= irq-ast2700-intc0-test.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
diff --git a/drivers/irqchip/irq-ast2700-intc0-test.c b/drivers/irqchip/irq-ast2700-intc0-test.c
new file mode 100644
index 000000000000..d49784509ac7
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700-intc0-test.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2026 Code Construct
+ */
+#include <kunit/test.h>
+
+#include "irq-ast2700.h"
+
+static void aspeed_intc0_resolve_route_bad_args(struct kunit *test)
+{
+	static const struct aspeed_intc_interrupt_range c1ranges[] = { 0 };
+	static const u32 c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	const struct irq_domain c0domain = { 0 };
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(NULL, 0, c1outs, 0, c1ranges, NULL);
+	KUNIT_EXPECT_EQ(test, rc, -EINVAL);
+
+	rc = aspeed_intc0_resolve_route(&c0domain, 0, c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_EQ(test, rc, -ENOENT);
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					0, c1ranges, &resolved);
+	KUNIT_EXPECT_EQ(test, rc, -ENOENT);
+}
+
+static int gicv3_fwnode_read_string_array(const struct fwnode_handle *fwnode,
+					  const char *propname, const char **val, size_t nval)
+{
+	if (!propname)
+		return -EINVAL;
+
+	if (!val)
+		return 1;
+
+	if (WARN_ON(nval != 1))
+		return -EOVERFLOW;
+
+	*val = "arm,gic-v3";
+	return 1;
+}
+
+static const struct fwnode_operations arm_gicv3_fwnode_ops = {
+	.property_read_string_array = gicv3_fwnode_read_string_array,
+};
+
+static void aspeed_intc_resolve_route_invalid_c0domain(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &arm_gicv3_fwnode_ops },
+	};
+	const struct irq_domain c0domain = { .fwnode = &intc0_node.fwnode };
+	static const struct aspeed_intc_interrupt_range c1ranges[] = { 0 };
+	static const u32 c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_NE(test, rc, 0);
+}
+
+static int
+aspeed_intc0_fwnode_read_string_array(const struct fwnode_handle *fwnode_handle,
+				      const char *propname, const char **val,
+				      size_t nval)
+{
+	if (!propname)
+		return -EINVAL;
+
+	if (!val)
+		return 1;
+
+	if (WARN_ON(nval != 1))
+		return -EOVERFLOW;
+
+	*val = "aspeed,ast2700-intc0";
+	return nval;
+}
+
+static const struct fwnode_operations intc0_fwnode_ops = {
+	.property_read_string_array = aspeed_intc0_fwnode_read_string_array,
+};
+
+static void
+aspeed_intc0_resolve_route_c1i1o1c0i1o1_connected(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &intc0_fwnode_ops },
+	};
+	struct aspeed_intc_interrupt_range c1ranges[] = {
+		{
+			.start = 0,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 1,
+				.param = { 128 }
+			}
+		}
+	};
+	static const u32 c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	struct aspeed_intc_interrupt_range intc0_ranges[] = {
+		{
+			.start = 128,
+			.count = 1,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = { 0 },
+			}
+		}
+	};
+	struct aspeed_intc0 intc0 = {
+		.ranges = { .ranges = intc0_ranges, .nranges = ARRAY_SIZE(intc0_ranges), }
+	};
+	const struct irq_domain c0domain = {
+		.host_data = &intc0,
+		.fwnode = &intc0_node.fwnode
+	};
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, resolved.start, 0);
+	KUNIT_EXPECT_EQ(test, resolved.count, 1);
+	KUNIT_EXPECT_EQ(test, resolved.upstream.param[0], 128);
+}
+
+static void
+aspeed_intc0_resolve_route_c1i1o1c0i1o1_disconnected(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &intc0_fwnode_ops },
+	};
+	struct aspeed_intc_interrupt_range c1ranges[] = {
+		{
+			.start = 0,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 1,
+				.param = { 128 }
+			}
+		}
+	};
+	static const u32 c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	struct aspeed_intc_interrupt_range intc0_ranges[] = {
+		{
+			.start = 129,
+			.count = 1,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = { 0 },
+			}
+		}
+	};
+	struct aspeed_intc0 intc0 = {
+		.ranges = {
+			.ranges = intc0_ranges,
+			.nranges = ARRAY_SIZE(intc0_ranges),
+		}
+	};
+	const struct irq_domain c0domain = {
+		.host_data = &intc0,
+		.fwnode = &intc0_node.fwnode
+	};
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_NE(test, rc, 0);
+}
+
+static void aspeed_intc0_resolve_route_c1i1o1mc0i1o1(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &intc0_fwnode_ops },
+	};
+	struct aspeed_intc_interrupt_range c1ranges[] = {
+		{
+			.start = 0,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 1,
+				.param = { 480 }
+			}
+		}
+	};
+	static const u32 c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	struct aspeed_intc_interrupt_range intc0_ranges[] = {
+		{
+			.start = 192,
+			.count = 1,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = { 0 },
+			}
+		}
+	};
+	struct aspeed_intc0 intc0 = {
+		.ranges = {
+			.ranges = intc0_ranges,
+			.nranges = ARRAY_SIZE(intc0_ranges),
+		}
+	};
+	const struct irq_domain c0domain = {
+		.host_data = &intc0,
+		.fwnode = &intc0_node.fwnode
+	};
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, resolved.start, 0);
+	KUNIT_EXPECT_EQ(test, resolved.count, 1);
+	KUNIT_EXPECT_EQ(test, resolved.upstream.param[0], 480);
+}
+
+static void aspeed_intc0_resolve_route_c1i2o2mc0i1o1(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &intc0_fwnode_ops },
+	};
+	struct aspeed_intc_interrupt_range c1ranges[] = {
+		{
+			.start = 0,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 1,
+				.param = { 480 }
+			}
+		},
+		{
+			.start = 1,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 1,
+				.param = { 510 }
+			}
+		}
+	};
+	static const u32 c1outs[] = { 1 };
+	struct aspeed_intc_interrupt_range resolved;
+	static struct aspeed_intc_interrupt_range intc0_ranges[] = {
+		{
+			.start = 208,
+			.count = 1,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = { 0 },
+			}
+		}
+	};
+	struct aspeed_intc0 intc0 = {
+		.ranges = {
+			.ranges = intc0_ranges,
+			.nranges = ARRAY_SIZE(intc0_ranges),
+		}
+	};
+	const struct irq_domain c0domain = {
+		.host_data = &intc0,
+		.fwnode = &intc0_node.fwnode
+	};
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, resolved.start, 1);
+	KUNIT_EXPECT_EQ(test, resolved.count, 1);
+	KUNIT_EXPECT_EQ(test, resolved.upstream.param[0], 510);
+}
+
+static void aspeed_intc0_resolve_route_c1i1o1mc0i2o1(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &intc0_fwnode_ops },
+	};
+	struct aspeed_intc_interrupt_range c1ranges[] = {
+		{
+			.start = 0,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 1,
+				.param = { 510 }
+			}
+		},
+	};
+	static const u32 c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	static struct aspeed_intc_interrupt_range intc0_ranges[] = {
+		{
+			.start = 192,
+			.count = 1,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = {0},
+			}
+		},
+		{
+			.start = 208,
+			.count = 1,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = {0},
+			}
+		}
+	};
+	struct aspeed_intc0 intc0 = {
+		.ranges = {
+			.ranges = intc0_ranges,
+			.nranges = ARRAY_SIZE(intc0_ranges),
+		}
+	};
+	const struct irq_domain c0domain = {
+		.host_data = &intc0,
+		.fwnode = &intc0_node.fwnode
+	};
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, resolved.start, 0);
+	KUNIT_EXPECT_EQ(test, resolved.count, 1);
+	KUNIT_EXPECT_EQ(test, resolved.upstream.param[0], 510);
+}
+
+static void aspeed_intc0_resolve_route_c1i1o2mc0i1o1_invalid(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &intc0_fwnode_ops },
+	};
+	struct aspeed_intc_interrupt_range c1ranges[] = {
+		{
+			.start = 0,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 1,
+				.param = { 480 }
+			}
+		}
+	};
+	static const u32 c1outs[] = {
+		AST2700_INTC_INVALID_ROUTE, 0
+	};
+	struct aspeed_intc_interrupt_range resolved;
+	struct aspeed_intc_interrupt_range intc0_ranges[] = {
+		{
+			.start = 192,
+			.count = 1,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = { 0 },
+			}
+		}
+	};
+	struct aspeed_intc0 intc0 = {
+		.ranges = {
+			.ranges = intc0_ranges,
+			.nranges = ARRAY_SIZE(intc0_ranges),
+		}
+	};
+	const struct irq_domain c0domain = {
+		.host_data = &intc0,
+		.fwnode = &intc0_node.fwnode
+	};
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_EQ(test, rc, 1);
+	KUNIT_EXPECT_EQ(test, resolved.start, 0);
+	KUNIT_EXPECT_EQ(test, resolved.count, 1);
+	KUNIT_EXPECT_EQ(test, resolved.upstream.param[0], 480);
+}
+
+static void
+aspeed_intc0_resolve_route_c1i1o1mc0i1o1_bad_range_upstream(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &intc0_fwnode_ops },
+	};
+	struct aspeed_intc_interrupt_range c1ranges[] = {
+		{
+			.start = 0,
+			.count = 1,
+			.upstream = {
+				.fwnode = &intc0_node.fwnode,
+				.param_count = 0,
+				.param = { 0 }
+			}
+		}
+	};
+	static const u32 c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	struct aspeed_intc_interrupt_range intc0_ranges[] = {
+		{
+			.start = 0,
+			.count = 0,
+			.upstream = {
+				.fwnode = NULL,
+				.param_count = 0,
+				.param = { 0 },
+			}
+		}
+	};
+	struct aspeed_intc0 intc0 = {
+		.ranges = {
+			.ranges = intc0_ranges,
+			.nranges = ARRAY_SIZE(intc0_ranges),
+		}
+	};
+	const struct irq_domain c0domain = {
+		.host_data = &intc0,
+		.fwnode = &intc0_node.fwnode
+	};
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_NE(test, rc, 0);
+}
+
+static struct kunit_case ast2700_intc0_test_cases[] = {
+	KUNIT_CASE(aspeed_intc0_resolve_route_bad_args),
+	KUNIT_CASE(aspeed_intc_resolve_route_invalid_c0domain),
+	KUNIT_CASE(aspeed_intc0_resolve_route_c1i1o1c0i1o1_connected),
+	KUNIT_CASE(aspeed_intc0_resolve_route_c1i1o1c0i1o1_disconnected),
+	KUNIT_CASE(aspeed_intc0_resolve_route_c1i1o1mc0i1o1),
+	KUNIT_CASE(aspeed_intc0_resolve_route_c1i2o2mc0i1o1),
+	KUNIT_CASE(aspeed_intc0_resolve_route_c1i1o1mc0i2o1),
+	KUNIT_CASE(aspeed_intc0_resolve_route_c1i1o2mc0i1o1_invalid),
+	KUNIT_CASE(aspeed_intc0_resolve_route_c1i1o1mc0i1o1_bad_range_upstream),
+	{},
+};
+
+static struct kunit_suite ast2700_intc0_test_suite = {
+	.name = "ast2700-intc0",
+	.test_cases = ast2700_intc0_test_cases,
+};
+
+kunit_test_suite(ast2700_intc0_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-ast2700-intc0.c b/drivers/irqchip/irq-ast2700-intc0.c
index 65e17b2dc6fa..14b8b88f1179 100644
--- a/drivers/irqchip/irq-ast2700-intc0.c
+++ b/drivers/irqchip/irq-ast2700-intc0.c
@@ -311,7 +311,8 @@ int aspeed_intc0_resolve_route(const struct irq_domain *c0domain, size_t nc1outs
 	if (nc1outs == 0 || nc1ranges == 0)
 		return -ENOENT;
 
-	if (!fwnode_device_is_compatible(c0domain->fwnode, "aspeed,ast2700-intc0"))
+	if (!IS_ENABLED(CONFIG_ASPEED_AST2700_INTC_TEST) &&
+	    !fwnode_device_is_compatible(c0domain->fwnode, "aspeed,ast2700-intc0"))
 		return -ENODEV;
 
 	intc0 = c0domain->host_data;

-- 
2.34.1


