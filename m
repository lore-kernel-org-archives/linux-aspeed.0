Return-Path: <linux-aspeed+bounces-3983-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B8FCD13D2
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 18:03:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5QCZ4q5Zz2yr0;
	Thu, 30 Apr 2026 04:03:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777485818;
	cv=none; b=bVD38tl6KnZXzInSIrLVHZ8qfW/Fx2FkXmBkKcdG0CEqLe5dDr1D13Kj/uPQkeWy6Rc1JSmi/0keeRk3zBKVaF+k1I+I+xANiaksrDuJdELFnyCpHehWlF7ZFSZAORZPX5nj23gHP81mzEG4TOaXXynw98oUqQwvNwQMusLLhQowTqU+qhbNqS53+3ZaraV/ZiKMmiCXa6XHNWo/DrV12nM80lpED44bz/l9zoik4jwkrfB+Y9Nkog9bkFjIABk3hFKXsa5f5xbAQwf3W/l3a8cwtze4a8aQx9IFGPQaRNxlBCvi8qQOOj9QTW4M3ESae3FhQsn7mQ1m2wYQpaSsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777485818; c=relaxed/relaxed;
	bh=pSiHGhf6ru2F9nLoledFRKcwtuecIRMIsmhWqwY8OEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+uh+kxzhKYEHMa+Gunvjr0rgDR7bRmSG0GAGO14bpK/dXPpNekx5ffnwwQNmmWEtSBosAgh0dY0jMyZuafPq0/hlZwMDmMO3RJ0u7bi/316Hti74JQk6XMQPxhoFnIj2CI/kDXva4uSaN21ItB8pf5NUOnuiTfCwo5SHtTYtPiPGQQithroIf5EVF0vUeaXAj9JDEKWHjPxiNv5R9EqEOJxhpJppswKQyiJyOnG1ABAX/elr7JR753HhfnXAvjItObN3VR22VqYkd/IcrxC5H3Fkp7JTU4eUnh/ze+49g5gGu39xazcS1WRdCGJzQ1iYgjYunguczOhMfxDXVGl7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bLojio66; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bLojio66;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5QCW2TNLz2yqP;
	Thu, 30 Apr 2026 04:03:35 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 29FD0C5CD62;
	Wed, 29 Apr 2026 17:58:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9AEA5FD43;
	Wed, 29 Apr 2026 17:58:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 715EB1072B16B;
	Wed, 29 Apr 2026 19:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485487; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pSiHGhf6ru2F9nLoledFRKcwtuecIRMIsmhWqwY8OEQ=;
	b=bLojio66LcIQgqN/n+btKKH1+KzZHd0PhjJy8pHU7MF2zY82En696K6fsqgENUw3A3AiWY
	X3FxgrXGk0o1KAKhuIXvZpamGGbU32i2p4Gb5DM8ThZNiNaHCKEfAM25Tj4GfcHeUp38Ic
	JN20kVj7ma8kWBTC92wK1zqutKyjAEaIxGMNPSoVSNzpsERpflZ1gcOcahdkVe+BCVuqME
	IfXeNaYNchdXorisuS9wvRB0un5DgtDzDQf7URs05HuP4/S7wGhp0DnwWiXj4DXWJLlAr8
	/Pf9CLPcC1E+1hnBjbVv7CguXmPeSSmuY/vsYMQnmnEKbndre52QePySVLx4wA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:45 +0200
Subject: [PATCH v3 08/11] mtd: spinand: winbond: Add support for continuous
 reads on W35NxxJW
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
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-8-0f38b3c229ad@bootlin.com>
References: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
In-Reply-To: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

W35N{01,02,04}JW support being read continuously under certain
circumstances. A bit must be set in their configuration register, and
a specific read from cache operation, a bit shorter than usual because
it no longer requires the address cycles, must be used for the occasion.

Setting the "enable" bit is already supported by the core, aside from
the subtlety of making sure the HFREQ bit is also set in octal DTR mode
above 90MHz. However, handling two different read from cache templates
involves creating a list of read from cache variants adapted the
continuous reads, ie. without address cycles.

Unfortunately, these operations, despite being very close to their
original read from cache cousins, are often unsupported by smart SPI
controller drivers because reading from cache historically allowed
changing the offset at which the host would start by providing a 2-byte
column address. In order to prevent issues with this, it has been
decided to implement these variants with a single "ignored" address byte
(respectively two in the octal DTR case), further reducing the amount of
dummy cycles needed before the first bit of data.

Enabling continuous reads has a side effect: the ECC status register now
may also return the value b11, which means that more than 1
uncorrectable error happened during the read. This non standard
behaviour requires to re-implement, almost identically the "get ECC"
helper from the core, with just an extra case for this value (it is
prefixed "w25w35nxxjw" because all these chips have the same behaviour).

Speed gain is substantial, see below. The flash_speed -C benchmark has
been run on a TI AM62A7 LP SK with CPU power management disabled,
mounted with a W35N01JW chip.

1S-8S-8S:

     1 page read speed is 15058 KiB/s
     2 page read speed is 15058 KiB/s
     3 page read speed is 16800 KiB/s
     4 page read speed is 17066 KiB/s
     5 page read speed is 18461 KiB/s
     6 page read speed is 18461 KiB/s
     7 page read speed is 19384 KiB/s
     8 page read speed is 19692 KiB/s
     9 page read speed is 19384 KiB/s
     10 page read speed is 20000 KiB/s
     11 page read speed is 20000 KiB/s
     12 page read speed is 20000 KiB/s
     13 page read speed is 20800 KiB/s
     14 page read speed is 20363 KiB/s
     15 page read speed is 20000 KiB/s
     16 page read speed is 19692 KiB/s
     32 page read speed is 19692 KiB/s
     64 page read speed is 19692 KiB/s

8D-8D-8D:

     1 page read speed is 23272 KiB/s
     2 page read speed is 23272 KiB/s
     3 page read speed is 28000 KiB/s
     4 page read speed is 32000 KiB/s
     5 page read speed is 34285 KiB/s
     6 page read speed is 34285 KiB/s
     7 page read speed is 36000 KiB/s
     8 page read speed is 36571 KiB/s
     9 page read speed is 36000 KiB/s
     10 page read speed is 34285 KiB/s
     11 page read speed is 36666 KiB/s
     12 page read speed is 40000 KiB/s
     13 page read speed is 41600 KiB/s
     14 page read speed is 37333 KiB/s
     15 page read speed is 40000 KiB/s
     16 page read speed is 36571 KiB/s
     32 page read speed is 42666 KiB/s
     64 page read speed is 42666 KiB/s

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Not all configurations have been tested/validated yet.
---
 drivers/mtd/nand/spi/winbond.c | 126 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index f4d4ffaa1f62..6c11f59a9f8d 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -15,9 +15,11 @@
 
 #define SPINAND_MFR_WINBOND		0xEF
 
+#define WINBOND_CFG_HFREQ		BIT(0)
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
 #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
+#define W25W35NXXJW_STATUS_ECC_MULT_UNCOR	(3 << 4)
 
 #define W25N0XJW_SR4			0xD0
 #define W25N0XJW_SR4_HS			BIT(2)
@@ -29,6 +31,49 @@
 #define W35N01JW_VCR_IO_MODE_OCTAL_DDR		0xC7
 #define W35N01JW_VCR_DUMMY_CLOCK_REG	0x01
 
+/*
+ * Winbond chips ignore the address bytes during continuous reads, and
+ * because the dummy cycles are enough they indicate dropping the
+ * address cycles from the continuous read from cache variants. This is
+ * very poorly supported by SPI controller drivers which are "wired" to
+ * always at least provide the column. Keep using address cycles, but
+ * reduce the number of dummy cycles accordingly.
+ */
+#define WINBOND_CONT_READ_FROM_CACHE_FAST_1S_1S_1S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x8b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(1, 0, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xcb, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 8),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 8),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x9d, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(2, 0, 8),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 2, 8),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
 /*
  * "X2" in the core is equivalent to "dual output" in the datasheets,
  * "X4" in the core is equivalent to "quad output" in the datasheets.
@@ -49,6 +94,19 @@ static SPINAND_OP_VARIANTS(read_cache_octal_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
+static SPINAND_OP_VARIANTS(cont_read_cache_octal_variants,
+		WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(24, NULL, 0, 120 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(16, NULL, 0, 86 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(3, NULL, 0, 120 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(2, NULL, 0, 105 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(20, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(16, NULL, 0, 162 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(12, NULL, 0, 124 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(8, NULL, 0, 86 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(2, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(1, NULL, 0, 133 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_FAST_1S_1S_1S_OP(1, NULL, 0, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_octal_variants,
 		SPINAND_PROG_LOAD_8D_8D_8D_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_8S_8S_OP(true, 0, NULL, 0),
@@ -326,6 +384,26 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static int w25w35nxxjw_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		return 1;
+
+	case STATUS_ECC_UNCOR_ERROR:
+	case W25W35NXXJW_STATUS_ECC_MULT_UNCOR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 			   enum spinand_bus_interface iface)
 {
@@ -451,6 +529,18 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
 	return 0;
 }
 
+static int w35n0xjw_set_cont_read(struct spinand_device *spinand, bool enable)
+{
+	const struct spi_mem_op *cont_op = spinand->op_templates->cont_read_cache;
+	u8 mask = enable ? 0 : WINBOND_CFG_BUF_READ;
+
+	if (cont_op && enable && spinand_op_is_odtr(cont_op) &&
+	    cont_op->max_freq >= 90 * HZ_PER_MHZ)
+		mask |= WINBOND_CFG_HFREQ;
+
+	return spinand_upd_cfg(spinand, WINBOND_CFG_BUF_READ | WINBOND_CFG_HFREQ, mask);
+}
+
 static const struct spinand_info winbond_spinand_table[] = {
 	/* 512M-bit densities */
 	SPINAND_INFO("W25N512GW", /* 1.8V */
@@ -504,13 +594,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc, 0x21),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
 		     0,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 	/* 2G-bit densities */
 	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
@@ -555,13 +647,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
 		     0,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 	/* 4G-bit densities */
 	SPINAND_INFO("W25N04KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
@@ -585,13 +679,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
 		     0,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)

-- 
2.53.0


