Return-Path: <linux-aspeed+bounces-414-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68759E7719C
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:46:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4GN0Y8Qz3cY6;
	Sat, 11 Jan 2025 01:46:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520364;
	cv=none; b=Yv4JRSyAJ/UsoOVbHxWoL6qsiCEke8RRNK2mugY7/37CZwkDttdcRli9zoCf2ltjptQtAc9KqgCHdyFH+7LjFF0NgY3gmkcNxR/1v34XtoHQKQvxJiCQ/OjqQFFvjuhmRcWXYYoZlHHV3GeJBlBMElOyZC7rpbF2rqlVi/ObAc9R2CjN/0EPleQAHvZ1UHp08YIxsCJ3SccgrFnlLCyi9KmrwnNAo1z3JJ9kjTr5byKsXkLfhZyZtE+t8NF8qnfys4a9bzSITV6G4vmbI/dxwYC9sJ70rt8ozXoqa890WTN+i+aFg1DbWJNBtzwiJReeNEePn1a6dApkKCdVB7Q4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520364; c=relaxed/relaxed;
	bh=+4OsasNx8lhobCm5ORTBJQ6wBy7WkLnmvrsNMBWmSJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PskD4gvmRd9pWIgSvL+Qel8hYepHAteXDwLKWh+AMtL6l4tIyyTqSNnnWFyafT/aStKYud/gqT1zr0PC6xqisuUhrg6aJE24mzXzy/zL/w9I1zgZVdpUDK4+g9us1bF3MwpYorOtyo51YqVO/kM05ciYgazRkz3ekFGKWFIJYyBJfF0Pk/RpZyQNdoaNxm09dyv0lJCO9Q1AKShRlLWFTTTvuZAbii0TleRuLBiNlxD11CgSXYBIqUk9LLtpJDVgzz4jRdLD19GSYM9dJi6/dkrh1rfTbJfzEPboEFTmW2T7Hx+sgO/fuphGyM33JXKAkO2ZOoxtxf0vGBeFwUgNEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=EHWk+4M6; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=EHWk+4M6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4GL2Kd7z3cXy;
	Sat, 11 Jan 2025 01:46:02 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF9DBFF811;
	Fri, 10 Jan 2025 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4OsasNx8lhobCm5ORTBJQ6wBy7WkLnmvrsNMBWmSJ4=;
	b=EHWk+4M6rgIucP6LYodXoQo9xCK3/SR0+tCBn1c/EVTyyIEHxnT2CLtOxB2hXbrEQseVQl
	a5Lyope540o3IJvxliwQJqLqpC1XHlvmc0EugsO1MCc2JjXmVmHKqqb0rYkJrIsfs/bH45
	6/m+6OuVongqhEYaSOu8e2tOrutlE50eiL+0zE4RtsiPUUfV92eQlpfeuHbER0i/4QvO0P
	0XzsBSy0sZuSpTF06NSgd8AqhU2vCTArmYEKwPOvqNX5Poe1fBFMPaGgZLuafi73o5zh9P
	qdQck2iy5L+7XNcrovgk8rLDyjWaP7D88bZ2cxDbsTqoo0+NqRd1Op/9UxuqGQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:24 +0100
Subject: [PATCH v3 22/27] mtd: spinand: Add an optional frequency to read
 from cache macros
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-22-7ab4bd56cf6e@bootlin.com>
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

While the SPINAND_PAGE_READ_FROM_CACHE_FAST_OP macro is supposed to be
able to run at the flash highest supported frequency, it is not the case
of the regular read from cache, which may be limited in terms of maximum
frequency. Add an optional argument to this macro, which will be used to
set the maximum frequency, if any.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/spinand.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 63c89307c86524143913660c66ec4fe4375904f8..1948e654b8aacb3d4b774a00939e8e8198f53da7 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -62,11 +62,12 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len, ...) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),			\

-- 
2.47.0


