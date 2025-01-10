Return-Path: <linux-aspeed+bounces-394-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AE0E7719C
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fh49wbz3cFf;
	Sat, 11 Jan 2025 01:45:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520328;
	cv=none; b=SPaqwpY6msEeTSDSsn/ILM5sPnzWGvKhMJGFApkSexyKCrnpjiWo6uk4sDpPF2KF/ZkWDFX/tGmbWBMMoLIf7U5Wx6ORdI1D0723peFpQWq1QJu1iZ4wVeKI87+b7ftNzXNyp457QAQoQiVA9wLhvMqLrEQd7XHuTW0f3z65kXKX6onjmKl7bHzD/EKVWKH5HMBkVC7lIoTkozJSXR5hjkF3O02Dw5VspsmwLkb6y8p0tVxM6vyDpEJiUAcpWuNadgrFzUZtIvmd0+NnOVYiBkPaqEKsEKxBh8OEgDceOhmdQTH1ZNhRLIFBA9TSVM5ypVK6r6q+t5/Xod34/xwsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520328; c=relaxed/relaxed;
	bh=bezjIfKOhlEJE79cO6ZVpXOH6/T+183qkN81Q6qLp7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g3dmFjoj29a+DwRzj+MSfUqmJEnsgjzFUwwC4btR4Fb4WtAH14BJYePgbFvmb60FgYn+cui0l8jwkiCgDGnqWvwHidqHQn7dJ/rL6xlOY10XYhVVfjsykHc7cLj9ljy08WpUaGOr5s+DKVFDIEDwYLWmFQix6Hd/yns00WGWYrQ5Sph0tHEIYEQKTUM8pUOsvfmAJLOJqn7uYvor7hT04jt+5rLKQRMNDCVPaUArug8C4dYmI3By1GnybwJpmmGs/XJs+jRTrlUJeKHlmzIdW8aiqFd4FHpr3yplSioDBZ6z+WYnVvDlfnyPSvOIjB8aLNWYKwRfgQ8hnJiU+s7Dow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=RbLkbagO; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=RbLkbagO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fg0CLwz3cXQ;
	Sat, 11 Jan 2025 01:45:26 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71785FF805;
	Fri, 10 Jan 2025 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bezjIfKOhlEJE79cO6ZVpXOH6/T+183qkN81Q6qLp7w=;
	b=RbLkbagOqMBunaMN2YnZGz8JsuiihcjK44O9gcXrDXaOSpGj9LecBmMp+KB2ELkudoPqYt
	Wteh4r4LazTg5RTKap7aOspopZKGe1jYNRi/d6AMySaB64R4a7k3SvPucgTT45G72I1a0A
	KhChutdGDp8rCVf3bOJ9dsAEIQEUXstxys6Qx1hEmZ1mjtuiISzkB16lZJsj2weAgzPptN
	7zlh6/0hmBjbz8hgOws8vE9W4eC84DkgYPLWsD9p6+yays2TV4Se9dpVedM43wyq04ct+5
	aGc7ZwnDsdFUvUudRDRIyTNtab4yU14nycOZLIxMRRYdpVsOu26qtFIXl8uZ2w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:05 +0100
Subject: [PATCH v3 03/27] spi: amd: Support per spi-mem operation frequency
 switches
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-3-7ab4bd56cf6e@bootlin.com>
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

Every ->exec_op() call correctly configures the spi bus speed to the
maximum allowed frequency for the memory using the constant spi default
parameter. Since we can now have per-operation constraints, let's use
the value that comes from the spi-mem operation structure instead. In
case there is no specific limitation for this operation, the default spi
device value will be given anyway.

This controller however performed a frequency check, which is also
observed during the ->check_op() phase.

The per-operation frequency capability is thus advertised to the spi-mem
core.

Cc: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index d30a21b0b05f96fe5361d16a1fca3467260e0a08..485ae1e382e3eb8f4d72ebb0fb15c51b9a118d3b 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -479,6 +479,9 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 		return false;
 	}
 
+	if (op->max_freq < mem->spi->controller->min_speed_hz)
+		return false;
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
@@ -676,7 +679,7 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 
 	amd_spi = spi_controller_get_devdata(mem->spi->controller);
 
-	ret = amd_set_spi_freq(amd_spi, mem->spi->max_speed_hz);
+	ret = amd_set_spi_freq(amd_spi, op->max_freq);
 	if (ret)
 		return ret;
 
@@ -705,6 +708,10 @@ static const struct spi_controller_mem_ops amd_spi_mem_ops = {
 	.supports_op = amd_spi_supports_op,
 };
 
+static const struct spi_controller_mem_caps amd_spi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int amd_spi_host_transfer(struct spi_controller *host,
 				   struct spi_message *msg)
 {
@@ -782,6 +789,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	host->setup = amd_spi_host_setup;
 	host->transfer_one_message = amd_spi_host_transfer;
 	host->mem_ops = &amd_spi_mem_ops;
+	host->mem_caps = &amd_spi_mem_caps;
 	host->max_transfer_size = amd_spi_max_transfer_size;
 	host->max_message_size = amd_spi_max_transfer_size;
 

-- 
2.47.0


