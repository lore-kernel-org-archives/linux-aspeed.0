Return-Path: <linux-aspeed+bounces-305-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A460AE77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:27:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhdx2QWkz303N;
	Wed, 25 Dec 2024 04:27:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.178.240
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735061221;
	cv=none; b=JbA/5gomNz8NpyJd7NRxzbILzw+1o9c8E8lE+qfSaeiiNxMR3AEyAdvvzVa4sy4lwEgXopClRmCG977eZ0ec1mzCieWoWQPEAojpUvNZJUr7Jv407NfTjyosIRWm3Lu/6MXY71K/eKiBwihw7IYX90rSIAui/uMNRZxZm4Z3Ianl7/F5SVwPln6gkXbdC8q5tk73U7xmFXF445G0vj2drial6S1u1qwWyh9KI/RIhLHiUSDnxjC+g4of1Wkubs4j5shUYBGk7muTNIQpeUW395/dcvV14sYp9AjmUNdXGzSQcsIYBe39k8z3Y8HqZOu3UxgiQsrXDrI6VfMIsP2meA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735061221; c=relaxed/relaxed;
	bh=i9S+oPEuCyhLEGvNj6fnjb+ZIh78/rEM10hMcWWJezk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ViR5tgprq3Vj74lXOJfBAFLGPo682MYxfks8aQqKALDpPdyG8ronY1XqRJU/x/V/V5jZqtrA8k51lSWqtSCf7d1vzJpryjZUPdSRgCOGkJaYQ7S5ryih1pCZQTJWPT6a5ggt3Kdf+Zh9urpAubOAErsdryHGsxZF+kPIiIXqel/ZdgYrvfCd+dJasMOJZs7qtjtXJdC9x0gn1O4iYCbIVjdomqw6pH3x8lDGZ0cinYgwmzwIWqrqPBmYkVdjzZbkU7oXzvjTPXilYmzxdZZcB9xUrK92u4izREJBajkDXeAxC9uvX982+mPOIooZJo6WKDfop3I2hLkep2iGrPKuJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=Z0HzeJSk; dkim-atps=neutral; spf=pass (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=Z0HzeJSk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhdv4PxKz3054;
	Wed, 25 Dec 2024 04:26:59 +1100 (AEDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 725F5C080A;
	Tue, 24 Dec 2024 17:06:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56B8040006;
	Tue, 24 Dec 2024 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735059992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9S+oPEuCyhLEGvNj6fnjb+ZIh78/rEM10hMcWWJezk=;
	b=Z0HzeJSkWJBJAnnLOcrKAORNX+qzBkEihH4Jjz4/IRUc5pm0xpbkE/vtiZKpldy1mV+nsp
	2I1pMlURXp1r/JLH9yot2K48XCGltGgAZpOwbUeQ2wEtDXftm6vf/rBwnsy+7UOZRpVwxR
	tve89iHTqUyJ7Fwt8+3BqNLFEF8rit2S7Ve2mPwKIscx6MWemW1AHDJWrxHRdrbmg5RAGW
	oitqIZA1V2ELYhiNYnEhnoLxcMQftgvGzorm6CHdBriJF80BixVMMVDw+PJwwUL0MCeEgm
	rjDmH6frum0L+Rmx3Zy2UbqsiboJf3myDxaU5ECJEAHuN02NyHSP6zSGzaFR3w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:47 +0100
Subject: [PATCH v2 02/27] spi: spi-mem: Add a new controller capability
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-2-ad218dbc406f@bootlin.com>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
In-Reply-To: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
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


