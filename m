Return-Path: <linux-aspeed+bounces-3480-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE39AE9126B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 06:07:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f66G10jQkz309y;
	Thu, 05 Feb 2026 17:07:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770271673;
	cv=none; b=K6y49otEkzlzrp51MJsg0eMEk6pwk/KecdPCfxVBt5V5jf3lFT6kS6q6ETABPLjdmCoNv3CgoL76B6v/pLYZ36wcm0CGWIprs9s/MoEVUTVUK38A0XKaaRf7bEWfkqxS3Zme3H5n1h81owrRkQVix/ZNsxcKhwBrvmLcnSmmuWt/LEMHhH9vtY1b32VGY8EEilsAAmDX1WDgT3zh6zM7vfmMIFcmqWRdjW2SkbwKW2gW2HkQsGpiY5KGQnEHbJQPtztp//6eqQz8bYFvQ6W+5L2d8+rRimRvM+G9su/aHRq1xkFZaBHMs4ebvcgJywS76Pvqv5h3Zn987FhlXzESGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770271673; c=relaxed/relaxed;
	bh=GJgWUPb0lVxXDbJh+zR0RSTw14CPAtdmN8xvFDA0OwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IxIZTrkyZzGOQWiOnE/GUZYUqUY12P07jJaDeTBTSbnb0UvamjOyKjdMg7GoTffL7jriKvgpcbA0B+Y64T22sg1Rlynh6UP55iFRfNIIn5GaBN+ZvfBuWwRy+T5gX/1qqQl1LkX9r2v2d1nEC4CBzHNTDAl2hzL4b80GHyCgucgjcRbWmDdX2RaE8+NCR/1079Qc8CsuugjEYckz/4ynBQzJmBfGdY2jgS/5VlUxBpW+7v1jGtgQumMKL6fTuPsgrE/YRhR0vP7dO1gNiRfehvLauffM/WpxJ2M/HZTP9fxzBf+0Lcq/KXsODrk6K9utfaE9XTcs9AEDKnd0wsh5TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f66Fz2nPsz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 17:07:51 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 5 Feb
 2026 14:07:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Feb 2026 14:07:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 5 Feb 2026 14:07:20 +0800
Subject: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1 support
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
Message-ID: <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
In-Reply-To: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271649; l=50884;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=Y1PlQKvcgT3RIgs+8Ja6zwrgkj1JB+npFm1kMrOX7KQ=;
 b=VQM7mi3jHh25LNWdvnrcXf3iSrd43hA9a2bHVfEulpxscLt4iAx9eJNV4Nh72rUxcoXgpgGmw
 g1E40SZemYcDm8oV3AXmhf6Tr7xBX3gsS4wDO5UMcpBq3IvnAcsSvKB
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The AST2700 interrupt fabric is shared by multiple integrated processors
(PSP/SSP/TSP/BootMCU), each with its own interrupt controller and its own
devicetree view of the system. As a result, interrupt routing cannot be
treated as fixed: the valid route for a peripheral interrupt depends on
which processor is consuming it.

The INTC0 driver models this by creating a hierarchical irqdomain under
the upstream interrupt controller selected by the interrupt-parent
property in the devicetree. Information derived from this relationship
is incorporated into the route resolution logic for the controller.

The INTC1 driver implements the banked INTM-fed controller and forwards
interrupts toward INTC0, without embedding assumptions about the final
destination processor.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/Kconfig                  |  11 +
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-ast2700-intc0-test.c | 474 +++++++++++++++++++
 drivers/irqchip/irq-ast2700-intc0.c      | 770 +++++++++++++++++++++++++++++++
 drivers/irqchip/irq-ast2700-intc1.c      | 345 ++++++++++++++
 drivers/irqchip/irq-ast2700.c            | 105 +++++
 drivers/irqchip/irq-ast2700.h            |  37 ++
 7 files changed, 1743 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f334f49c9791..3cc0f3af0e1e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -110,6 +110,17 @@ config AL_FIC
 	help
 	  Support Amazon's Annapurna Labs Fabric Interrupt Controller.
 
+config ASPEED_AST2700_INTC
+	bool "ASPEED AST2700 Interrupt Controller support"
+	depends on OF
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select IRQ_DOMAIN_HIERARCHY
+
+config ASPEED_AST2700_INTC_TEST
+	bool "Tests for the ASPEED AST2700 Interrupt Controller"
+	depends on ASPEED_AST2700_INTC && KUNIT=y
+	default KUNIT_ALL_TESTS
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 6a229443efe0..51fdf269e436 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
+obj-$(CONFIG_ASPEED_AST2700_INTC)	+= irq-ast2700.o irq-ast2700-intc0.o irq-ast2700-intc1.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
diff --git a/drivers/irqchip/irq-ast2700-intc0-test.c b/drivers/irqchip/irq-ast2700-intc0-test.c
new file mode 100644
index 000000000000..d6bc19676b2e
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700-intc0-test.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2026 Code Construct
+ */
+#include <kunit/test.h>
+#include "irq-ast2700.h"
+
+static void aspeed_intc0_resolve_route_bad_args(struct kunit *test)
+{
+	static const struct aspeed_intc_interrupt_range c1ranges[] = { 0 };
+	static const aspeed_intc_output_t c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	const struct irq_domain c0domain = { 0 };
+
+	int rc;
+
+	rc = aspeed_intc0_resolve_route(NULL, 0, c1outs, 0, c1ranges, NULL);
+	KUNIT_EXPECT_EQ(test, rc, -EINVAL);
+
+	rc = aspeed_intc0_resolve_route(&c0domain, 0, c1outs,
+					ARRAY_SIZE(c1ranges), c1ranges,
+					&resolved);
+	KUNIT_EXPECT_EQ(test, rc, -ENODEV);
+
+	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
+					0, c1ranges, &resolved);
+	KUNIT_EXPECT_EQ(test, rc, -ENODEV);
+}
+
+static int
+arm_gicv3_fwnode_read_string_array(const struct fwnode_handle *fwnode_handle,
+				   const char *propname, const char **val,
+				   size_t nval)
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
+	.property_read_string_array = arm_gicv3_fwnode_read_string_array,
+};
+
+static void aspeed_intc_resolve_route_invalid_c0domain(struct kunit *test)
+{
+	struct device_node intc0_node = {
+		.fwnode = { .ops = &arm_gicv3_fwnode_ops },
+	};
+	const struct irq_domain c0domain = { .fwnode = &intc0_node.fwnode };
+	static const struct aspeed_intc_interrupt_range c1ranges[] = { 0 };
+	static const aspeed_intc_output_t c1outs[] = { 0 };
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
+	*val = "aspeed,ast2700-intc0-ic";
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
+	static const aspeed_intc_output_t c1outs[] = { 0 };
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
+	static const aspeed_intc_output_t c1outs[] = { 0 };
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
+	static const aspeed_intc_output_t c1outs[] = { 0 };
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
+	static const aspeed_intc_output_t c1outs[] = { 1 };
+	struct aspeed_intc_interrupt_range resolved;
+	struct aspeed_intc_interrupt_range intc0_ranges[] = {
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
+	static const aspeed_intc_output_t c1outs[] = { 0 };
+	struct aspeed_intc_interrupt_range resolved;
+	struct aspeed_intc_interrupt_range intc0_ranges[] = {
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
+	static const aspeed_intc_output_t c1outs[] = {
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
+	static const aspeed_intc_output_t c1outs[] = { 0 };
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
+kunit_test_suite(ast2700_intc0_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-ast2700-intc0.c b/drivers/irqchip/irq-ast2700-intc0.c
new file mode 100644
index 000000000000..722457dd2e18
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700-intc0.c
@@ -0,0 +1,770 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+
+#include <asm-generic/errno.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/fwnode.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kconfig.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/property.h>
+#include <linux/spinlock.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "irq-ast2700.h"
+#define INT_NUM 480
+#define INTM_NUM 50
+#define SWINT_NUM 16
+
+#define INTM_BASE (INT_NUM)
+#define SWINT_BASE (INT_NUM + INTM_NUM)
+#define INT0_NUM (INT_NUM + INTM_NUM + SWINT_NUM)
+
+#define GIC_P2P_SPI_END 128
+
+#define INTC0_SWINT_IER 0x10
+#define INTC0_SWINT_ISR 0x14
+#define INTC0_INTBANKX_IER 0x1000
+#define INTC0_INTBANK_GROUPS 11
+#define INTC0_INTBANKS_PER_GRP 3
+#define INTC0_INTMX_IER 0x1b00
+#define INTC0_INTMX_ISR 0x1b04
+#define INTC0_INTM_BANK_NUM 3
+#define INTM_IRQS_PER_BANK 10
+
+struct aspeed_intc0 {
+	struct device *dev;
+	void __iomem *base;
+	raw_spinlock_t intc_lock;
+	struct irq_domain *local;
+	struct device_node *parent;
+	struct aspeed_intc_interrupt_ranges ranges;
+};
+
+static void aspeed_swint_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bit = data->hwirq - SWINT_BASE;
+	unsigned int mask;
+
+	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
+	mask = readl(intc0->base + INTC0_SWINT_IER) & ~BIT(bit);
+	writel(mask, intc0->base + INTC0_SWINT_IER);
+	irq_chip_mask_parent(data);
+}
+
+static void aspeed_swint_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bit = data->hwirq - SWINT_BASE;
+	unsigned int unmask;
+
+	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
+	unmask = readl(intc0->base + INTC0_SWINT_IER) | BIT(bit);
+	writel(unmask, intc0->base + INTC0_SWINT_IER);
+	irq_chip_unmask_parent(data);
+}
+
+static void aspeed_swint_irq_eoi(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bit = data->hwirq - SWINT_BASE;
+
+	writel(BIT(bit), intc0->base + INTC0_SWINT_ISR);
+	irq_chip_eoi_parent(data);
+}
+
+static struct irq_chip aspeed_swint_chip = {
+	.name = "ast2700-swint",
+	.irq_eoi = aspeed_swint_irq_eoi,
+	.irq_mask = aspeed_swint_irq_mask,
+	.irq_unmask = aspeed_swint_irq_unmask,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.flags = IRQCHIP_SET_TYPE_MASKED,
+};
+
+static void aspeed_intc0_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bank = (data->hwirq - INTM_BASE) / INTM_IRQS_PER_BANK;
+	int bit = (data->hwirq - INTM_BASE) % INTM_IRQS_PER_BANK;
+	unsigned int mask;
+
+	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
+	mask = readl(intc0->base + INTC0_INTMX_IER + bank * 0x10) & ~BIT(bit);
+	writel(mask, intc0->base + INTC0_INTMX_IER + bank * 0x10);
+	irq_chip_mask_parent(data);
+}
+
+static void aspeed_intc0_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bank = (data->hwirq - INTM_BASE) / INTM_IRQS_PER_BANK;
+	int bit = (data->hwirq - INTM_BASE) % INTM_IRQS_PER_BANK;
+	unsigned int unmask;
+
+	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
+	unmask = readl(intc0->base + INTC0_INTMX_IER + bank * 0x10) | BIT(bit);
+	writel(unmask, intc0->base + INTC0_INTMX_IER + bank * 0x10);
+	irq_chip_unmask_parent(data);
+}
+
+static void aspeed_intc0_irq_eoi(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bank = (data->hwirq - INTM_BASE) / INTM_IRQS_PER_BANK;
+	int bit = (data->hwirq - INTM_BASE) % INTM_IRQS_PER_BANK;
+
+	writel(BIT(bit), intc0->base + INTC0_INTMX_ISR + bank * 0x10);
+	irq_chip_eoi_parent(data);
+}
+
+static struct irq_chip aspeed_intm_chip = {
+	.name = "ast2700-intmerge",
+	.irq_eoi = aspeed_intc0_irq_eoi,
+	.irq_mask = aspeed_intc0_irq_mask,
+	.irq_unmask = aspeed_intc0_irq_unmask,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.flags = IRQCHIP_SET_TYPE_MASKED,
+};
+
+static struct irq_chip linear_intr_irq_chip = {
+	.name = "ast2700-int",
+	.irq_eoi = irq_chip_eoi_parent,
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = irq_chip_unmask_parent,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.flags = IRQCHIP_SET_TYPE_MASKED,
+};
+
+#define INTC0_IN_NUM 480
+#define INTC0_ROUTE_NUM 5
+
+static const aspeed_intc_output_t aspeed_intc0_routes[INTC0_IN_NUM / 32][INTC0_ROUTE_NUM] = {
+	[0] = {
+		[0b000] = 0,
+		[0b001] = 256,
+		[0b010] = 426,
+		[0b011] = AST2700_INTC_INVALID_ROUTE,
+		[0b100] = AST2700_INTC_INVALID_ROUTE,
+	},
+	[1] = {
+		[0b000] = 32,
+		[0b001] = 288,
+		[0b010] = 458,
+		[0b011] = AST2700_INTC_INVALID_ROUTE,
+		[0b100] = AST2700_INTC_INVALID_ROUTE,
+	},
+	[2] = {
+		[0b000] = 64,
+		[0b001] = 320,
+		[0b010] = 490,
+		[0b011] = AST2700_INTC_INVALID_ROUTE,
+		[0b100] = AST2700_INTC_INVALID_ROUTE,
+	},
+	[3] = {
+		[0b000] = 96,
+		[0b001] = 352,
+		[0b010] = 522,
+		[0b011] = AST2700_INTC_INVALID_ROUTE,
+		[0b100] = AST2700_INTC_INVALID_ROUTE,
+	},
+	[4] = {
+		[0b000] = 128,
+		[0b001] = 384,
+		[0b010] = 554,
+		[0b011] = 160,
+		[0b100] = 176,
+	},
+	[5] = {
+		[0b000] = 129,
+		[0b001] = 385,
+		[0b010] = 555,
+		[0b011] = 161,
+		[0b100] = 177,
+	},
+	[6] = {
+		[0b000] = 130,
+		[0b001] = 386,
+		[0b010] = 556,
+		[0b011] = 162,
+		[0b100] = 178,
+	},
+	[7] = {
+		[0b000] = 131,
+		[0b001] = 387,
+		[0b010] = 557,
+		[0b011] = 163,
+		[0b100] = 179,
+	},
+	[8] = {
+		[0b000] = 132,
+		[0b001] = 388,
+		[0b010] = 558,
+		[0b011] = 164,
+		[0b100] = 180,
+
+	},
+	[9] = {
+		[0b000] = 133,
+		[0b001] = 544,
+		[0b010] = 714,
+		[0b011] = 165,
+		[0b100] = 181,
+	},
+	[10] = {
+		[0b000] = 134,
+		[0b001] = 545,
+		[0b010] = 715,
+		[0b011] = 166,
+		[0b100] = 182,
+	},
+	[11] = {
+		[0b000] = 135,
+		[0b001] = 546,
+		[0b010] = 706,
+		[0b011] = 167,
+		[0b100] = 183,
+	},
+	[12] = {
+		[0b000] = 136,
+		[0b001] = 547,
+		[0b010] = 707,
+		[0b011] = 168,
+		[0b100] = 184,
+
+	},
+	[13] = {
+		[0b000] = 137,
+		[0b001] = 548,
+		[0b010] = 708,
+		[0b011] = 169,
+		[0b100] = 185,
+
+	},
+	[14] = {
+		[0b000] = 138,
+		[0b001] = 549,
+		[0b010] = 709,
+		[0b011] = 170,
+		[0b100] = 186,
+	},
+};
+
+#define INTC0_INTM_NUM 50
+
+static const aspeed_intc_output_t
+	aspeed_intc0_intm_routes[INTC0_INTM_NUM / 10] = {
+		[0] = 192, /* INTM00 ~ INTM09 */
+		[1] = 416, /* INTM10 ~ INTM19 */
+		[2] = 586, /* INTM20 ~ INTM29 */
+		[3] = 208, /* INTM30 ~ INTM39 */
+		[4] = 224, /* INTM40 ~ INTM49 */
+	};
+
+static bool range_contains_element(u32 start, u32 count, u32 value)
+{
+	if (WARN_ON_ONCE((U32_MAX - count) < start))
+		return false;
+
+	return value >= start && value < start + count;
+}
+
+static int
+resolve_input_from_child_ranges(const struct aspeed_intc0 *intc0,
+				const struct aspeed_intc_interrupt_range *range,
+				u32 outpin, u32 *input)
+{
+	u32 offset;
+	u32 base;
+
+	if (!range_contains_element(range->start, range->count, outpin))
+		return -ENOENT;
+
+	if (range->upstream.param_count == 0)
+		return -EINVAL;
+
+	base = range->upstream.param[0];
+	offset = outpin - range->start;
+	if ((U32_MAX - offset) < base) {
+		dev_warn(intc0->dev,
+			 "%s: Arithmetic overflow for input derivation: %u + %u\n",
+			 __func__, base, offset);
+		return -EINVAL;
+	}
+
+	*input = base + offset;
+	return 0;
+}
+
+static bool resolve_parent_range_for_output(const struct aspeed_intc0 *intc0,
+					    const struct fwnode_handle *parent,
+					    u32 output,
+					    struct aspeed_intc_interrupt_range *resolved)
+{
+	for (size_t i = 0; i < intc0->ranges.nranges; i++) {
+		struct aspeed_intc_interrupt_range range =
+			intc0->ranges.ranges[i];
+
+		dev_dbg(intc0->dev,
+			"%s: Inspecting candidate parent range %zu starting at %u for %u\n",
+			__func__, i, range.start, range.count);
+		if (!range_contains_element(range.start, range.count, output)) {
+			dev_dbg(intc0->dev, "%s: Output %u not in range [%u, %u)\n",
+				__func__, output, range.start, range.start + range.count);
+			continue;
+		}
+
+		if (range.upstream.fwnode != parent) {
+			dev_dbg(intc0->dev, "%s: Parent mismatch for range %zu\n", __func__, i);
+			continue;
+		}
+
+		dev_dbg(intc0->dev, "%s: Parent range %zu matched for output %u\n",
+			__func__, i, output);
+
+		if (resolved) {
+			resolved->start = output;
+			resolved->count = 1;
+			resolved->upstream = range.upstream;
+			resolved->upstream.param[1] += output - range.start;
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
+static int resolve_parent_route_for_input(const struct aspeed_intc0 *intc0,
+					  const struct fwnode_handle *parent, u32 input,
+					  struct aspeed_intc_interrupt_range *resolved)
+{
+	aspeed_intc_output_t c0o;
+	int rc = -ENOENT;
+
+	if (input < INT_NUM) {
+		bool found;
+
+		dev_dbg(intc0->dev, "%s: Resolving parent route for linear input %u\n",
+			__func__, input);
+		static_assert(INTC0_ROUTE_NUM < INT_MAX, "Broken cast");
+		for (size_t i = 0; rc == -ENOENT && i < INTC0_ROUTE_NUM; i++) {
+			c0o = aspeed_intc0_routes[input / 32][i];
+			if (c0o == AST2700_INTC_INVALID_ROUTE)
+				continue;
+
+			if (input < GIC_P2P_SPI_END)
+				c0o += input % 32;
+
+			found = resolve_parent_range_for_output(intc0, parent, c0o, resolved);
+			rc = found ? (int)i : -ENOENT;
+		}
+	} else if (input < (INT_NUM + INTM_NUM)) {
+		bool found;
+
+		dev_dbg(intc0->dev, "%s: Resolving parent route for merged input %u\n",
+			__func__, input);
+		c0o = aspeed_intc0_intm_routes[(input - INT_NUM) / INTM_IRQS_PER_BANK];
+		c0o += ((input - INT_NUM) % INTM_IRQS_PER_BANK);
+
+		found = resolve_parent_range_for_output(intc0, parent, c0o, resolved);
+		rc = found ? 0 : -ENOENT;
+	} else if (input < (INT_NUM + INTM_NUM + SWINT_NUM)) {
+		bool found;
+
+		dev_dbg(intc0->dev, "%s: Resolving parent route for merged input %u\n",
+			__func__, input);
+		c0o = input - SWINT_BASE + 144;
+		found = resolve_parent_range_for_output(intc0, parent, c0o, resolved);
+		rc = found ? 0 : -ENOENT;
+	} else {
+		dev_dbg(intc0->dev, "%s: Invalid input: %u\n", __func__, input);
+		return -ENOENT;
+	}
+
+	if (rc < 0) {
+		dev_dbg(intc0->dev,
+			"%s: Failed to resolve INTC0 parent route for input %u: %d\n",
+			__func__, input, rc);
+	} else {
+		dev_dbg(intc0->dev,
+			"%s: Resolved INTC0 input %u route to parent via %d\n",
+			__func__, input, rc);
+	}
+
+	return rc;
+}
+
+/**
+ * aspeed_intc0_resolve_route - Determine the necessary interrupt output at intc1
+ * @c0domain: The pointer to intc0's irq_domain
+ * @nc1outs: The number of valid intc1 outputs available for the input
+ * @c1outs: The array of available intc1 output indices for the input
+ * @nc1ranges: The number of interrupt range entries for intc1
+ * @c1ranges: The array of configured intc1 interrupt ranges
+ * @resolved: The fully resolved range entry after applying the resolution
+ *            algorithm
+ *
+ * Returns: The intc1 route index associated with the intc1 output identified in
+ * @resolved on success. Otherwise, a negative errno value.
+ *
+ * The AST2700 interrupt architecture allows any peripheral interrupt source
+ * to be routed to one of up to four processors running in the SoC. A processor
+ * binding a driver for a peripheral that requests an interrupt is (without
+ * further design and effort) the destination for the requested interrupt.
+ *
+ * Routing a peripheral interrupt to its destination processor requires
+ * coordination between INTC0 on the CPU die and one or more INTC1 instances.
+ * At least one INTC1 instance exists in the SoC on the IO-die, however up
+ * to two more instances may be integrated via LTPI (LVDS Tunneling Protocol
+ * & Interface).
+ *
+ * Between the multiple destinations, various route constraints, and the
+ * devicetree binding design, some information that's needed at INTC1 instances
+ * to route inbound interrupts correctly to the destination processor is only
+ * available at INTC0.
+ *
+ * aspeed_intc0_resolve_route() is to be invoked by INTC1 driver instances to
+ * perform the route resolution. The implementation in INTC0 allows INTC0 to
+ * encapsulate the information used to perform route selection, and provides it
+ * with an opportunity to apply policy as part of the selection process. Such
+ * policy may, for instance, choose to de-prioritise some interrupts destined
+ * for the PSP (Primary Service Processor) GIC.
+ */
+int aspeed_intc0_resolve_route(const struct irq_domain *c0domain, size_t nc1outs,
+			       const aspeed_intc_output_t c1outs[static nc1outs],
+			       size_t nc1ranges,
+			       const struct aspeed_intc_interrupt_range c1ranges[static nc1ranges],
+			       struct aspeed_intc_interrupt_range *resolved)
+{
+	struct aspeed_intc0 *intc0;
+	struct fwnode_handle *parent_fwnode;
+	int ret;
+
+	if (!c0domain || !resolved)
+		return -EINVAL;
+
+	if (nc1outs > INT_MAX)
+		return -EINVAL;
+
+	if (nc1outs == 0 || nc1ranges == 0)
+		return -ENODEV;
+
+	if (!fwnode_device_is_compatible(c0domain->fwnode,
+					 "aspeed,ast2700-intc0-ic"))
+		return -ENODEV;
+
+	intc0 = c0domain->host_data;
+	if (!intc0)
+		return -EINVAL;
+
+	parent_fwnode = of_fwnode_handle(intc0->parent);
+
+	for (size_t i = 0; i < nc1outs; i++) {
+		aspeed_intc_output_t c1o = c1outs[i];
+
+		if (c1o == AST2700_INTC_INVALID_ROUTE) {
+			dev_dbg(intc0->dev, "%s: Invalid output at route index %zu\n",
+				__func__, i);
+			continue;
+		}
+
+		dev_dbg(intc0->dev, "%s: Have output %u for route index %zu\n",
+			__func__, c1o, i);
+
+		for (size_t j = 0; j < nc1ranges; j++) {
+			struct aspeed_intc_interrupt_range c1r = c1ranges[j];
+			u32 input;
+
+			dev_dbg(intc0->dev,
+				"%s: Inspecting candidate range %zu starting at %u for %u\n",
+				__func__, j, c1r.start, c1r.count);
+
+			/*
+			 * Range match for intc1 output pin
+			 *
+			 * Assume a failed match is still a match for the purpose of testing,
+			 * saves a bunch of mess in the test fixtures
+			 */
+			if (!(c0domain == irq_find_matching_fwspec(&c1r.upstream,
+								   c0domain->bus_token) ||
+			      IS_ENABLED(CONFIG_ASPEED_AST2700_INTC_TEST))) {
+				dev_dbg(intc0->dev, "%s: Parent mismatch for candidate range %zu\n",
+					__func__, j);
+				continue;
+			}
+
+			ret = resolve_input_from_child_ranges(intc0, &c1r, c1o, &input);
+			if (ret) {
+				if (ret == -ENOENT)
+					dev_dbg(intc0->dev,
+						"%s: Output %u not in candidate range %zu starting at %u for %u\n",
+						__func__, c1o, j, c1r.start, c1r.count);
+				continue;
+			}
+			dev_dbg(intc0->dev,
+				"%s: Resolved INTC0 input to %u using candidate range %zu: [%u, %u)\n",
+				__func__, input, j, c1r.start, c1r.start + c1r.count);
+
+			/*
+			 * INTC1 should never request routes for peripheral interrupt sources
+			 * directly attached to INTC0.
+			 */
+			if (input < GIC_P2P_SPI_END) {
+				dev_dbg(intc0->dev,
+					"%s: Invalid range specification at index %zu routed INTC1 output to unreachable INTC0 input\n",
+					__func__, j);
+				continue;
+			}
+
+			ret = resolve_parent_route_for_input(intc0, parent_fwnode, input, NULL);
+			if (ret < 0)
+				continue;
+
+			/* Route resolution succeeded */
+			resolved->start = c1o;
+			resolved->count = 1;
+			resolved->upstream = c1r.upstream;
+			resolved->upstream.param[0] = input;
+			dev_dbg(intc0->dev,
+				"%s: Route resolution selected INTC1 output %u via index %zu\n",
+				__func__, c1o, i);
+			/* Cast protected by prior test against nc1outs */
+			return (int)i;
+		}
+	}
+
+	ret = -EHOSTUNREACH;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aspeed_intc0_resolve_route);
+
+static int aspeed_intc0_irq_domain_map(struct irq_domain *domain,
+				       unsigned int irq, irq_hw_number_t hwirq)
+{
+	if (hwirq < GIC_P2P_SPI_END)
+		irq_set_chip_and_handler(irq, &linear_intr_irq_chip,
+					 handle_level_irq);
+	else if (hwirq < INTM_BASE)
+		return -EINVAL;
+	else if (hwirq < SWINT_BASE)
+		irq_set_chip_and_handler(irq, &aspeed_intm_chip,
+					 handle_level_irq);
+	else if (hwirq < INT0_NUM)
+		irq_set_chip_and_handler(irq, &aspeed_swint_chip,
+					 handle_level_irq);
+	else
+		return -EINVAL;
+
+	irq_set_chip_data(irq, domain->host_data);
+	return 0;
+}
+
+static int aspeed_intc0_irq_domain_translate(struct irq_domain *domain,
+					     struct irq_fwspec *fwspec,
+					     unsigned long *hwirq,
+					     unsigned int *type)
+{
+	if (fwspec->param_count != 1)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static int aspeed_intc0_irq_domain_alloc(struct irq_domain *domain,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *data)
+{
+	struct aspeed_intc0 *intc0 = domain->host_data;
+	struct aspeed_intc_interrupt_range resolved;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	struct irq_chip *chip;
+	unsigned long hwirq;
+	unsigned int type;
+	int ret;
+
+	ret = aspeed_intc0_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	if (hwirq >= GIC_P2P_SPI_END && hwirq < INT_NUM)
+		return -EINVAL;
+
+	if (hwirq < INTM_BASE)
+		chip = &linear_intr_irq_chip;
+	else if (hwirq < SWINT_BASE)
+		chip = &aspeed_intm_chip;
+	else
+		chip = &aspeed_swint_chip;
+
+	ret = resolve_parent_route_for_input(intc0, domain->parent->fwnode,
+					     (u32)hwirq, &resolved);
+	if (ret)
+		return ret;
+
+	parent_fwspec = resolved.upstream;
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					   &parent_fwspec);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
+		ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip,
+						    domain->host_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aspeed_intc0_irq_domain_activate(struct irq_domain *domain,
+					    struct irq_data *data, bool reserve)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+
+	if (data->hwirq < INT_NUM) {
+		int bank = data->hwirq / 32;
+		int bit = data->hwirq % 32;
+		u32 mask = BIT(bit);
+		int route;
+
+		route = resolve_parent_route_for_input(intc0,
+						       intc0->local->parent->fwnode,
+						       data->hwirq, NULL);
+		if (route < 0)
+			return route;
+
+		guard(raw_spinlock_irqsave)(&intc0->intc_lock);
+		for (int i = 0; i < 3; i++) {
+			void __iomem *sel = intc0->base + 0x200 + bank * 4 + 0x100 * i;
+			u32 reg = readl(sel);
+
+			if (route & BIT(i))
+				reg |= mask;
+			else
+				reg &= ~mask;
+
+			writel(reg, sel);
+			if (readl(sel) != reg)
+				return -EACCES;
+		}
+	} else if (data->hwirq < INT0_NUM) {
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc0_ic_irq_domain_ops = {
+	.translate = aspeed_intc0_irq_domain_translate,
+	.alloc = aspeed_intc0_irq_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+	.map = aspeed_intc0_irq_domain_map,
+	.activate = aspeed_intc0_irq_domain_activate,
+};
+
+static void aspeed_intc0_disable_swint(struct aspeed_intc0 *intc0)
+{
+	writel(0, intc0->base + INTC0_SWINT_IER);
+}
+
+static void aspeed_intc0_disable_intbank(struct aspeed_intc0 *intc0)
+{
+	int i, j;
+
+	for (i = 0; i < INTC0_INTBANK_GROUPS; i++) {
+		for (j = 0; j < INTC0_INTBANKS_PER_GRP; j++) {
+			u32 base = INTC0_INTBANKX_IER + (0x100 * i) + (0x10 * j);
+
+			writel(0, intc0->base + base);
+		}
+	}
+}
+
+static void aspeed_intc0_disable_intm(struct aspeed_intc0 *intc0)
+{
+	int i;
+
+	for (i = 0; i < INTC0_INTM_BANK_NUM; i++)
+		writel(0, intc0->base + INTC0_INTMX_IER + (0x10 * i));
+}
+
+static int aspeed_intc0_ic_probe(struct platform_device *pdev,
+				 struct device_node *parent)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct irq_domain *parent_domain;
+	struct aspeed_intc0 *intc0;
+	int ret;
+
+	if (!parent) {
+		pr_err("missing parent interrupt node\n");
+		return -ENODEV;
+	}
+
+	intc0 = devm_kzalloc(&pdev->dev, sizeof(*intc0), GFP_KERNEL);
+	if (!intc0)
+		return -ENOMEM;
+
+	intc0->dev = &pdev->dev;
+	intc0->parent = parent;
+	intc0->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(intc0->base))
+		return PTR_ERR(intc0->base);
+
+	aspeed_intc0_disable_swint(intc0);
+	aspeed_intc0_disable_intbank(intc0);
+	aspeed_intc0_disable_intm(intc0);
+
+	raw_spin_lock_init(&intc0->intc_lock);
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("unable to obtain parent domain\n");
+		return -ENODEV;
+	}
+
+	if (!of_device_is_compatible(parent, "arm,gic-v3"))
+		return -ENODEV;
+
+	intc0->local = irq_domain_create_hierarchy(parent_domain, 0, INT0_NUM,
+						   of_fwnode_handle(node),
+						   &aspeed_intc0_ic_irq_domain_ops,
+						   intc0);
+	if (!intc0->local)
+		return -ENOMEM;
+
+	ret = aspeed_intc_populate_ranges(&pdev->dev, &intc0->ranges);
+	if (ret < 0) {
+		irq_domain_remove(intc0->local);
+		return ret;
+	}
+
+	return 0;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(ast2700_intc0)
+IRQCHIP_MATCH("aspeed,ast2700-intc0-ic", aspeed_intc0_ic_probe)
+IRQCHIP_PLATFORM_DRIVER_END(ast2700_intc0)
+
+#ifdef CONFIG_ASPEED_AST2700_INTC_TEST
+#include "irq-ast2700-intc0-test.c"
+#endif
diff --git a/drivers/irqchip/irq-ast2700-intc1.c b/drivers/irqchip/irq-ast2700-intc1.c
new file mode 100644
index 000000000000..51371cc57c5c
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700-intc1.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed AST2700 Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+
+#include "linux/dev_printk.h"
+#include "linux/device/devres.h"
+#include "linux/property.h"
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/spinlock.h>
+
+#include "irq-ast2700.h"
+
+#define INTC1_IER 0x100
+#define INTC1_ISR 0x104
+#define INTC1_IRQS_PER_BANK 32
+#define INTC1_BANK_NUM 6
+#define INTC1_ROUTE_NUM 7
+
+struct aspeed_intc1 {
+	struct device *dev;
+	void __iomem *base;
+	raw_spinlock_t intc_lock;
+	struct irq_domain *local;
+	struct irq_domain *upstream;
+	struct aspeed_intc_interrupt_ranges ranges;
+};
+
+static void aspeed_intc1_disable_int(struct aspeed_intc1 *intc1)
+{
+	for (int i = 0; i < INTC1_BANK_NUM; i++)
+		writel(0x0, intc1->base + INTC1_IER + (0x10 * i));
+}
+
+static void aspeed_intc1_ic_irq_handler(struct irq_desc *desc)
+{
+	struct aspeed_intc1 *intc1 = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long bit, status;
+
+	chained_irq_enter(chip, desc);
+
+	for (int bank = 0; bank < INTC1_BANK_NUM; bank++) {
+		status = readl(intc1->base + INTC1_ISR + (0x10 * bank));
+		if (!status)
+			continue;
+
+		for_each_set_bit(bit, &status, INTC1_IRQS_PER_BANK) {
+			generic_handle_domain_irq(intc1->local,
+						  (bank * INTC1_IRQS_PER_BANK) +
+							  bit);
+			writel(BIT(bit),
+			       intc1->base + INTC1_ISR + (0x10 * bank));
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_intc1_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc1 *intc1 = irq_data_get_irq_chip_data(data);
+	int bank = data->hwirq / INTC1_IRQS_PER_BANK;
+	int bit = data->hwirq % INTC1_IRQS_PER_BANK;
+	unsigned int mask;
+
+	guard(raw_spinlock_irqsave)(&intc1->intc_lock);
+	mask = readl(intc1->base + INTC1_IER + (0x10 * bank)) & ~BIT(bit);
+	writel(mask, intc1->base + INTC1_IER + (0x10 * bank));
+}
+
+static void aspeed_intc1_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc1 *intc1 = irq_data_get_irq_chip_data(data);
+	int bank = data->hwirq / INTC1_IRQS_PER_BANK;
+	int bit = data->hwirq % INTC1_IRQS_PER_BANK;
+	unsigned int unmask;
+
+	guard(raw_spinlock_irqsave)(&intc1->intc_lock);
+	unmask = readl(intc1->base + INTC1_IER + (0x10 * bank)) | BIT(bit);
+	writel(unmask, intc1->base + INTC1_IER + (0x10 * bank));
+}
+
+static struct irq_chip aspeed_intc_chip = {
+	.name = "ASPEED INTC1",
+	.irq_mask = aspeed_intc1_irq_mask,
+	.irq_unmask = aspeed_intc1_irq_unmask,
+};
+
+static int aspeed_intc1_irq_domain_translate(struct irq_domain *domain,
+					     struct irq_fwspec *fwspec,
+					     unsigned long *hwirq,
+					     unsigned int *type)
+{
+	if (fwspec->param_count != 1)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = IRQ_TYPE_LEVEL_HIGH;
+	return 0;
+}
+
+static int aspeed_intc1_ic_map_irq_domain(struct irq_domain *domain,
+					  unsigned int irq,
+					  irq_hw_number_t hwirq)
+{
+	irq_domain_set_info(domain, irq, hwirq, &aspeed_intc_chip,
+			    domain->host_data, handle_level_irq, NULL, NULL);
+	return 0;
+}
+
+#define INTC1_IN_NUM 192
+
+/*
+ * In-bound interrupts are progressively merged into one out-bound interrupt in
+ * groups of 32. Apply this fact to compress the route table in corresponding
+ * groups of 32.
+ */
+static const aspeed_intc_output_t aspeed_intc1_routes[INTC1_IN_NUM / 32][INTC1_ROUTE_NUM] = {
+	[0] = {
+		[0b000] = 0,
+		[0b001] = AST2700_INTC_INVALID_ROUTE, /* path not verified */
+		[0b010] = 10,
+		[0b011] = 20,
+		[0b100] = 30,
+		[0b101] = 40,
+		[0b110] = 50,
+	},
+	[1] = {
+		[0b000] = 1,
+		[0b001] = AST2700_INTC_INVALID_ROUTE,
+		[0b010] = 11,
+		[0b011] = 21,
+		[0b100] = 31,
+		[0b101] = 41,
+		[0b110] = 50,
+	},
+	[2] = {
+		[0b000] = 2,
+		[0b001] = AST2700_INTC_INVALID_ROUTE,
+		[0b010] = 12,
+		[0b011] = 22,
+		[0b100] = 32,
+		[0b101] = 42,
+		[0b110] = 50,
+	},
+	[3] = {
+		[0b000] = 3,
+		[0b001] = AST2700_INTC_INVALID_ROUTE,
+		[0b010] = 13,
+		[0b011] = 23,
+		[0b100] = 33,
+		[0b101] = 43,
+		[0b110] = 50,
+	},
+	[4] = {
+		[0b000] = 4,
+		[0b001] = AST2700_INTC_INVALID_ROUTE,
+		[0b010] = 14,
+		[0b011] = 24,
+		[0b100] = 34,
+		[0b101] = 44,
+		[0b110] = 50,
+	},
+	[5] = {
+		[0b000] = 5,
+		[0b001] = AST2700_INTC_INVALID_ROUTE,
+		[0b010] = 15,
+		[0b011] = 25,
+		[0b100] = 35,
+		[0b101] = 45,
+		[0b110] = 50,
+	},
+};
+
+#define INTC1_BOOTMCU_ROUTE 0b110
+
+static int aspeed_intc1_parent_is_bootmcu(const struct irq_domain *upstream)
+{
+	if (!upstream || !upstream->fwnode)
+		return 0;
+
+	return fwnode_device_is_compatible(upstream->fwnode, "riscv,aplic");
+}
+
+static int aspeed_intc1_irq_domain_activate(struct irq_domain *domain,
+					    struct irq_data *data, bool reserve)
+{
+	struct aspeed_intc1 *intc1 = irq_data_get_irq_chip_data(data);
+	int bank = data->hwirq / INTC1_IRQS_PER_BANK;
+	struct aspeed_intc_interrupt_range resolved;
+	int bit = data->hwirq % INTC1_IRQS_PER_BANK;
+	u32 mask = BIT(bit);
+	int rc;
+
+	if (WARN_ON_ONCE((data->hwirq >> 5) >= ARRAY_SIZE(aspeed_intc1_routes)))
+		return -EINVAL;
+
+	dev_dbg(intc1->dev, "Activation request for hwirq %lu in domain %s\n",
+		data->hwirq, domain->name);
+
+	/*
+	 * outpin may be an error if the upstream is the BootMCU APLIC node, or
+	 * anything except a valid intc0 driver instance
+	 */
+	rc = aspeed_intc0_resolve_route(intc1->upstream, INTC1_ROUTE_NUM,
+					aspeed_intc1_routes[data->hwirq >> 5],
+					intc1->ranges.nranges,
+					intc1->ranges.ranges, &resolved);
+	if (rc < 0) {
+		if (!aspeed_intc1_parent_is_bootmcu(intc1->upstream)) {
+			dev_warn(intc1->dev,
+				 "Failed to resolve interrupt route for hwirq %lu in domain %s\n",
+				 data->hwirq, domain->name);
+			return rc;
+		}
+		rc = INTC1_BOOTMCU_ROUTE;
+	}
+
+	guard(raw_spinlock_irqsave)(&intc1->intc_lock);
+	/* Route selector uses 3 bits across the selector registers. */
+	for (int i = 0; i < 3; i++) {
+		void __iomem *sel = intc1->base + 0x80 + bank * 4 + 0x20 * i;
+		u32 reg = readl(sel);
+
+		if (rc & BIT(i))
+			reg |= mask;
+		else
+			reg &= ~mask;
+
+		writel(reg, sel);
+		if (readl(sel) != reg)
+			return -EACCES;
+	}
+
+	dev_dbg(intc1->dev,
+		"Routed hwirq %lu in domain %s to output %u via route %d\n",
+		data->hwirq, domain->name, resolved.start, rc);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc1_ic_irq_domain_ops = {
+	.map = aspeed_intc1_ic_map_irq_domain,
+	.translate = aspeed_intc1_irq_domain_translate,
+	.activate = aspeed_intc1_irq_domain_activate,
+};
+
+static void aspeed_intc1_request_interrupts(struct aspeed_intc1 *intc1)
+{
+	unsigned int i;
+
+	for (i = 0; i < intc1->ranges.nranges; i++) {
+		struct aspeed_intc_interrupt_range *r =
+			&intc1->ranges.ranges[i];
+
+		if (intc1->upstream !=
+		    irq_find_matching_fwspec(&r->upstream,
+					     intc1->upstream->bus_token))
+			continue;
+
+		for (u32 k = 0; k < r->count; k++) {
+			struct of_phandle_args parent_irq;
+			int irq;
+
+			parent_irq.np = to_of_node(r->upstream.fwnode);
+			parent_irq.args_count = 1;
+			parent_irq.args[0] =
+				intc1->ranges.ranges[i].upstream.param[0] + k;
+
+			irq = irq_create_of_mapping(&parent_irq);
+			if (!irq)
+				continue;
+
+			irq_set_chained_handler_and_data(irq,
+							 aspeed_intc1_ic_irq_handler, intc1);
+			dev_dbg(intc1->dev, "Mapped irq %d\n", parent_irq.args[0]);
+		}
+	}
+}
+
+static int aspeed_intc1_ic_probe(struct platform_device *pdev,
+				 struct device_node *parent)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct aspeed_intc1 *intc1;
+	struct irq_domain *host;
+	int ret;
+
+	if (!parent) {
+		dev_err(&pdev->dev, "missing parent interrupt node\n");
+		return -ENODEV;
+	}
+
+	if (!of_device_is_compatible(parent, "aspeed,ast2700-intc0-ic"))
+		return -ENODEV;
+
+	host = irq_find_host(parent);
+	if (!host)
+		return -ENODEV;
+
+	intc1 = devm_kzalloc(&pdev->dev, sizeof(*intc1), GFP_KERNEL);
+	if (!intc1)
+		return -ENOMEM;
+
+	intc1->dev = &pdev->dev;
+	intc1->upstream = host;
+	intc1->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(intc1->base))
+		return PTR_ERR(intc1->base);
+
+	aspeed_intc1_disable_int(intc1);
+
+	raw_spin_lock_init(&intc1->intc_lock);
+
+	intc1->local = irq_domain_create_linear(of_fwnode_handle(node),
+						INTC1_BANK_NUM * INTC1_IRQS_PER_BANK,
+						&aspeed_intc1_ic_irq_domain_ops, intc1);
+	if (!intc1->local)
+		return -ENOMEM;
+
+	ret = aspeed_intc_populate_ranges(&pdev->dev, &intc1->ranges);
+	if (ret < 0) {
+		irq_domain_remove(intc1->local);
+		return ret;
+	}
+
+	aspeed_intc1_request_interrupts(intc1);
+
+	return 0;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(ast2700_intc1)
+IRQCHIP_MATCH("aspeed,ast2700-intc1-ic", aspeed_intc1_ic_probe)
+IRQCHIP_PLATFORM_DRIVER_END(ast2700_intc1)
diff --git a/drivers/irqchip/irq-ast2700.c b/drivers/irqchip/irq-ast2700.c
new file mode 100644
index 000000000000..269d743207ae
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+#include "irq-ast2700.h"
+
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+
+int aspeed_intc_populate_ranges(struct device *dev,
+				struct aspeed_intc_interrupt_ranges *ranges)
+{
+	struct aspeed_intc_interrupt_range *arr;
+	const __be32 *pvs, *pve;
+	struct device_node *dn;
+	int len;
+
+	if (!dev || !ranges)
+		return -EINVAL;
+
+	dn = dev->of_node;
+
+	pvs = of_get_property(dn, "aspeed,interrupt-ranges", &len);
+	if (!pvs)
+		return -EINVAL;
+
+	if (len % sizeof(__be32))
+		return -EINVAL;
+
+	/* Over-estimate the range entry count for now */
+	ranges->ranges = devm_kmalloc_array(dev, (len / (3 * sizeof(__be32))),
+					    sizeof(*ranges->ranges),
+					    GFP_KERNEL);
+	if (!ranges->ranges)
+		return -ENOMEM;
+
+	pve = pvs + (len / sizeof(__be32));
+	for (unsigned int i = 0; pve - pvs >= 3; i++) {
+		struct aspeed_intc_interrupt_range *r;
+		struct device_node *target;
+		u32 target_cells;
+
+		target = of_find_node_by_phandle(be32_to_cpu(pvs[2]));
+		if (!target)
+			return -EINVAL;
+
+		if (of_property_read_u32(target, "#interrupt-cells",
+					 &target_cells)) {
+			of_node_put(target);
+			return -EINVAL;
+		}
+
+		if (!target_cells || target_cells > IRQ_DOMAIN_IRQ_SPEC_PARAMS) {
+			of_node_put(target);
+			return -EINVAL;
+		}
+
+		if (pve - pvs < 3 + target_cells) {
+			of_node_put(target);
+			return -EINVAL;
+		}
+
+		r = &ranges->ranges[i];
+		r->start = be32_to_cpu(pvs[0]);
+		r->count = be32_to_cpu(pvs[1]);
+
+		{
+			struct of_phandle_args args = {
+				.np = target,
+				.args_count = target_cells,
+			};
+
+			for (u32 j = 0; j < target_cells; j++)
+				args.args[j] = be32_to_cpu(pvs[3 + j]);
+
+			of_phandle_args_to_fwspec(target, args.args,
+						  args.args_count,
+						  &r->upstream);
+		}
+
+		if (target_cells >= 1)
+			dev_dbg(dev,
+				"Mapped %u outputs from %u to %u on parent %s",
+				r->count, r->start, r->upstream.param[0], target->full_name);
+		else
+			dev_dbg(dev,
+				"Registered interrupt range from %u for count %u\n",
+				r->start, r->count);
+
+		of_node_put(target);
+		pvs += 3 + target_cells;
+		ranges->nranges++;
+	}
+
+	/* Re-fit the range array now we know the entry count */
+	arr = devm_krealloc_array(dev, ranges->ranges, ranges->nranges,
+				  sizeof(*ranges->ranges), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+	ranges->ranges = arr;
+
+	return 0;
+}
diff --git a/drivers/irqchip/irq-ast2700.h b/drivers/irqchip/irq-ast2700.h
new file mode 100644
index 000000000000..56dbb1c88b11
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Aspeed AST2700 Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+#ifndef DRIVERS_IRQCHIP_AST2700
+#define DRIVERS_IRQCHIP_AST2700
+
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+
+#define AST2700_INTC_INVALID_ROUTE (~0U)
+
+struct aspeed_intc_interrupt_range {
+	u32 start;
+	u32 count;
+	struct irq_fwspec upstream;
+};
+
+struct aspeed_intc_interrupt_ranges {
+	struct aspeed_intc_interrupt_range *ranges;
+	unsigned int nranges;
+};
+
+int aspeed_intc_populate_ranges(struct device *dev,
+				struct aspeed_intc_interrupt_ranges *ranges);
+
+typedef u32 aspeed_intc_output_t;
+
+int aspeed_intc0_resolve_route(
+	const struct irq_domain *c0domain, size_t nc1outs,
+	const aspeed_intc_output_t c1outs[static nc1outs], size_t nc1ranges,
+	const struct aspeed_intc_interrupt_range c1ranges[static nc1ranges],
+	struct aspeed_intc_interrupt_range *resolved);
+
+#endif

-- 
2.34.1


