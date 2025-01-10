Return-Path: <linux-aspeed+bounces-412-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B4DE7719E
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:46:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4GH6pQrz3cXw;
	Sat, 11 Jan 2025 01:45:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520359;
	cv=none; b=mdQDFUqTOFfnIg7fynR8kVP6R+WtLk6NfhsJ5NUC8IumdlgJvJO1AdzWoRVhiqRXHJT7nglTC5lnd9Hw5HYAM+1EK1+2glPkNdAo1vU5vdFdTN3rlGIW8CvcSqPEJGpeUsVFilSRaLdmN+BjusrK3mRNfcKu2BiowgY0x+0pzME1UJQdtXIG8Jwof8EcJTyppyAtBpavsKRQIHz6egJK02fgEwvnLj6BnHa94P0X2yvqIH/dvESNshnFjV3v6j4/h4+MvOyikvA6+8jVZ/k3PmeoLhC6PkO5/fSrUovlxIsBYM04LRFc7yBjZaNrLRNwYNKt41ZEYj7XRyH5Hpql6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520359; c=relaxed/relaxed;
	bh=DV0g0pOzPZr7JQwGFl2TLj96VbJ3qNwf0y0PZqiRQeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnjdL9ePHqQ5J7FzM25gozkv0xeYUtuPB4tQl16lFo+WCH9aXajQWK4kbEO8QzbNHpqo11j7Lqa2llYoMaTER79rj0QYxM6/bjQaIXiFl4R3gM49BuB1HYlIz5OUC+lvniL0rGIuxFQuHOTgMryhAZSnfd5Pmmiy+sbpH0MtdrL5dq8NvqCsfVXVCnS6v0JXt3IMvRizg8UxF/V6Yf2DFe4eR+4w+8CdxruFMaIhmw4mruw5D3ljFlx1cYz3suFFBksywUlzeDSw8RGxTdr+KJKYTYEPjpiFE2ShZqjLUza80ix4uYfdH4ZxunbPhiPLtEjqwj/YQvmQNbUGwrJR4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=Iub4XWBe; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=Iub4XWBe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4GG3VDvz3cXp;
	Sat, 11 Jan 2025 01:45:58 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F330DFF80E;
	Fri, 10 Jan 2025 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV0g0pOzPZr7JQwGFl2TLj96VbJ3qNwf0y0PZqiRQeg=;
	b=Iub4XWBewLpqM4mjtcf282n05DtpSp2+ih1ggGNeYCSDRcaoMk1i7i3N4OYiPgVjR6G+Em
	TdyUPQQdcrAbzg1kHwRp1fZBvniO8vkZqKZNKLxVoRDmpjP+DYR7LMQNiWGTETMrai+7NR
	tC2eq5dAERYbVVq2sY5tkBjjk1CLAhSZo+XbiRU5XZNE0NSTkeHVAbL0Vl9yROQ0rUj1M0
	OsbKv8+D2Kj7IU1D7PpEFfGH/aBZqRctYRNEieN7ZkJnN4BBx3yN23Zll5WovDvVjwyQXy
	itpcADRE5oX9JEZfI4AgblOu+Um7po2ZiDqadR4KW3airgn5EftBZOdcv2N/nQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:22 +0100
Subject: [PATCH v3 20/27] spi: spi-mem: Estimate the time taken by
 operations
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-20-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

In the SPI-NAND layer, we currently make list of operation variants from
the fastest one to the slowest and there is a bit of logic in the core
to go over them and pick the first one that is supported by the
controller, ie. the fastest one among the supported ops.

This kind of logic only works if all operations run at the same
frequency, but as soon as we introduce per operation max frequencies it
is not longer as obvious which operation will be faster, especially
since it also depends on the PCB/controller frequency limitation.

One way to make this choice more clever is to go over all the
variants and for each of them derive an indicator which will help derive
the theoretical best. In this case, we derive a theoretical duration for
the entire operation and we take the smallest one.

Add a helper that parses the spi-mem operation and returns this value.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 30 ++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 96374afd0193ca2cf4f50004f66c36dce32894e8..a9f0f47f4759b0e1ce22348e713a3b42cfb8ea9c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -562,6 +562,36 @@ void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
 
+/**
+ * spi_mem_calc_op_duration() - Derives the theoretical length (in ns) of an
+ *			        operation. This helps finding the best variant
+ *			        among a list of possible choices.
+ * @op: the operation to benchmark
+ *
+ * Some chips have per-op frequency limitations, PCBs usually have their own
+ * limitations as well, and controllers can support dual, quad or even octal
+ * modes, sometimes in DTR. All these combinations make it impossible to
+ * statically list the best combination for all situations. If we want something
+ * accurate, all these combinations should be rated (eg. with a time estimate)
+ * and the best pick should be taken based on these calculations.
+ *
+ * Returns a ns estimate for the time this op would take.
+ */
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
+{
+	u64 ncycles = 0;
+	u32 ns_per_cycles;
+
+	ns_per_cycles = 1000000000 / op->max_freq;
+	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
+	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
+	ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
+
+	return ncycles * ns_per_cycles;
+}
+EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 306c05dd13789017da2c5339cddc031f03302bb9..c4830dfaff3db5549c45bb7a9c4bf5110fa2e338 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -424,6 +424,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);

-- 
2.47.0


