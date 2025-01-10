Return-Path: <linux-aspeed+bounces-395-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B16E7719E
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fj1Qqyz3cXj;
	Sat, 11 Jan 2025 01:45:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520329;
	cv=none; b=V20ELB6Yzw2XWwKPNfLejwc3/aKp3+k0CH9XuEzstZKpY3D3BlpiWBYsedSPydSbw3D5of/K0EvBMsJYy8tPeHtz93/7/YpSdO/rg8qN46xW36KIbkGtJUZloHRqJzCwrCONBXgnriqSY+sshFTiehPakhEMHXZhx1yf+Co/wFtlvcHYBhd3EeB3Bphqp/nEMDwdXNuAju1qQOKHktiXH1+CUnoJaDYNqz6LdNr2U/sKN48eEHpQZpSVBI/mouA8EX+q3eVoZWp/79Z2Ft9lYu3trMcwRP4D+w85nIkqmd2etlhrwc0FUNsoNOlg59k3GNysgwwtR8kO+dFKZlYl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520329; c=relaxed/relaxed;
	bh=i9S+oPEuCyhLEGvNj6fnjb+ZIh78/rEM10hMcWWJezk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3Sz6NlHpETkLyiXlOk+XQI6h2rO9x9TSo9agQSl9cXujAtltUt4n/ZioOtVzcGcqDOAgF64BN9MkylVKJmLPITsySkyTSwTt8V4rzdz3riD/wlqw3eaZfpwKeFDh2MubTAodVCzdojcFsTibq0W7R30KUuaHOL8V1SYeuYuhV7/E0xZQeyv85fkRjJEJuHw+9F8PKuH+rlFS+avZcakTOoWHNKK0jb3GskxDV1EpPCJq4qGDvRlGRPYpzEFVpGAW5MP016mCultCnZhEsl6nf+gIN3BMujL899/iD4hCO/FDxqrUxdBCwJbANLqstGJq2sofGT86ks9wTSGIdRnyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=jNf0OrcA; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=jNf0OrcA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fg1thKz3c8x;
	Sat, 11 Jan 2025 01:45:26 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E516FF808;
	Fri, 10 Jan 2025 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9S+oPEuCyhLEGvNj6fnjb+ZIh78/rEM10hMcWWJezk=;
	b=jNf0OrcAs6DsWJYEnkFU2FEsFw+5PEjJbwC6b68fzB7ILAMfvVwQkA5jRMxb7VOdLd36bz
	y2QteFNU5AIHxrSSQ/Tm8f7w1ol0I1kbls0VlDonMzBduIcwwcwbrlspcrvBPewG8O7Kc/
	PWnjovuFLHtK97xoSlFXOtFlSR/AlRQhjHQuI7TvPNWz3hAulV2RfYRHAhxffvD4I2oEMe
	LirBC7eMwQ9VtZPF9Azq7BckGo/KJhCvEc8TG/Eyv11sQ2b5xDli0UlRkpVqP5vuPTyH4a
	XxwZ0u7S6WQYc6Ol13zIjHcoze+2/1L7QGo9zbPcROmaAtvqVZUBumPkYbs46w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:04 +0100
Subject: [PATCH v3 02/27] spi: spi-mem: Add a new controller capability
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-2-7ab4bd56cf6e@bootlin.com>
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
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

There are spi devices with multiple frequency limitations depending on
the invoked command. We probably do not want to afford running at the
lowest supported frequency all the time, so if we want to get the most
of our hardware, we need to allow per-operation frequency limitations.

Among all the SPI memory controllers, I believe all are capable of
changing the spi frequency on the fly. Some of the drivers do not make
any frequency setup though. And some others will derive a per chip
prescaler value which will be used forever.

Actually changing the frequency on the fly is something new in Linux, so
we need to carefully flag the drivers which do and do not support it. A
controller capability is created for that, and the presence for this
capability will always be checked before accepting such pattern.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-mem.c       | 6 ++++++
 include/linux/spi/spi-mem.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 12299ce89a1cc80495858dbbbaa822f2968bb7ab..96374afd0193ca2cf4f50004f66c36dce32894e8 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -191,6 +191,12 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 	    op->max_freq < mem->spi->controller->min_speed_hz)
 		return false;
 
+	if (op->max_freq &&
+	    op->max_freq < mem->spi->max_speed_hz) {
+		if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
+			return false;
+	}
+
 	return spi_mem_check_buswidth(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 84ec524987921a95963235de4b6f728ef2fc5987..c7a7719c264846ad9fce613ba96d9284ad7893e7 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -311,11 +311,13 @@ struct spi_controller_mem_ops {
  * @ecc: Supports operations with error correction
  * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
  *	    Octal DTR
+ * @per_op_freq: Supports per operation frequency switching
  */
 struct spi_controller_mem_caps {
 	bool dtr;
 	bool ecc;
 	bool swap16;
+	bool per_op_freq;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\

-- 
2.47.0


