Return-Path: <linux-aspeed+bounces-290-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A0CE77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhCw0TpVz2xfb;
	Wed, 25 Dec 2024 04:07:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735060076;
	cv=none; b=ciiKSr8MOgr77K54yMqnrERXebbKH13g5OCIGSSUnlaMGqglP7Cf8Hl0CnD85OQ+82bw7Nq5Q5B5IKtNHFI4EHZRd1VtHyaoU8TGHtU7W6UDNMRmx47NzDyDR+hxYP1HQRLlPKe+eCU9ikfcOb4hxfWjv/nG8uudCn7zpfI9K3qpYFWf+HlNTXOTX442BKFoox5ei0WXSR7UKXiy2pSeSs4GNDYLsi5xaseAa3QDW8GYyMA2WlZQ0N3AXs8ZYmbvoHUrxuGv+VMGEDpCdpcJjDeE9Q8qipQY2VzkhwKPVZn7s1HVfcU+h7fY1GoZiEN3TSVCw/BcDJs0STNjuAMHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735060076; c=relaxed/relaxed;
	bh=kbQep8baX7V18i3WQzlRcus+JcLBQAZAEQ0EVnsTNJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SG7aVKNQLn2aKc6wDNKODINnqeuUhJh4eAb7uDJN0FuGKTBpfrMH1Tl18bnI4GjZqgpl08RbV7KvTIwnqeZi4np5bk6swn80AWnUnRrnDhg2J8k/WRVv3Q0JQnJPzOuoHWw+UArYlZiB25UEpPUdTWa1O2A8/su0Oj4uQcObqZnI74VIMofoBVZ2fF8V0evC1xEJ5OcJPsFwuCD+nY+lIWPJdxWNU7Ck69NCX5vZP8G/BWGpc/Me+Jp5RKI8iCffHkRxQBImnecTr/TZ+Kvzt4TeKBhnrRmZbEvnwHsCrTIB53r5wBTnLgYy/hX9+CrS1PivAkham9IV00h3q54c6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=QLRtoFxK; dkim-atps=neutral; spf=pass (client-ip=217.70.183.194; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=QLRtoFxK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.194; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhCt49LZz301N;
	Wed, 25 Dec 2024 04:07:54 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6473340002;
	Tue, 24 Dec 2024 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbQep8baX7V18i3WQzlRcus+JcLBQAZAEQ0EVnsTNJ0=;
	b=QLRtoFxKhPx0761tFyItDBBDh2ZlFhF74KE6N+ECmWyJZguR1WQ5Ubts5K4LFjzLqsiF8f
	znkeDr/77Gx65+E0itx1DTZB5nG6gmx+RZ5PoaZ348+69I1KFnN8av9noGAGWqGVqa8VJH
	/47qulqvgam/S4uoVPc9phHZzhGwvSiZDuuFV3dpfkin0H8Khid96WKjSwJDVCdkUlpw1z
	T+5MCcHJ5EE35MNfDSFbQQD3KEUm93JXLCEUgKCidBEmGQk7JER2pakRH+bareC++ojpDF
	xBHAi4D1P//sZEySLVewnaP8Lt0ihrF6PYH2v7ExzKqcTZ6RPIzkkSanj9zaGg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:06:04 +0100
Subject: [PATCH v2 19/27] spi: spi-mem: Create macros for DTR operation
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-19-ad218dbc406f@bootlin.com>
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
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

We do have macros for defining command, address, dummy and data
cycles. We also have a .dtr flag that implies sampling the bus on both
edges, but there are currently no macros enabling it. We might make use
of such macros, so let's create:
- SPI_MEM_DTR_OP_CMD
- SPI_MEM_DTR_OP_ADDR
- SPI_MEM_DTR_OP_DUMMY
- SPI_MEM_DTR_OP_DATA_OUT
- SPI_MEM_DTR_OP_DATA_OUT

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index ca6ea01c40f85095ac2730cb424cfb21d7daa700..306c05dd13789017da2c5339cddc031f03302bb9 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -20,6 +20,14 @@
 		.opcode = __opcode,				\
 	}
 
+#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+	{							\
+		.nbytes = 1,					\
+		.opcode = __opcode,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
 	{							\
 		.nbytes = __nbytes,				\
@@ -27,6 +35,14 @@
 		.val = __val,					\
 	}
 
+#define SPI_MEM_DTR_OP_ADDR(__nbytes, __val, __buswidth)	\
+	{							\
+		.nbytes = __nbytes,				\
+		.val = __val,					\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
 #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
@@ -35,6 +51,13 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
@@ -45,6 +68,15 @@
 		.buf.in = __buf,				\
 	}
 
+#define SPI_MEM_DTR_OP_DATA_IN(__nbytes, __buf, __buswidth)	\
+	{							\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.buswidth = __buswidth,				\
@@ -53,6 +85,15 @@
 		.buf.out = __buf,				\
 	}
 
+#define SPI_MEM_DTR_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
+	{							\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DATA	{ }
 
 /**

-- 
2.47.0


