Return-Path: <linux-aspeed+bounces-3406-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B531D2ED0F
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Jan 2026 12:30:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwRVj5G6xz3bjN;
	Tue, 20 Jan 2026 23:30:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768912221;
	cv=none; b=UBl6Ti+WO5fo7WannUKseIHwUpN3VhmyBHvMNs21e8L/5AInzuMAcdpmj1ImebWg2u62lXv0BxV9xW1cNBQt1Xv94clJIp1VHmiNBfOJ+9Og7LenHf8eGO50tDknTDiJcnbHJAV2s/960UOh/DXJKBRQejlifJeWCluIfJrCaVNKrxsXpaYyjMwGOh9l8gjCgNa7qUr1SirkASoOTgznsGZas71z/Eo3tYJy44qCJNYZJ2HnCpVcZtkz3lzizOzoYk+Xjaz6OdH4uFgVVrp7pfi6hPp39ikTW8Mnt/6PMS1El20qQDxRE02+C6TLeij3FlrZC0MrpfgjVsY7JzRq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768912221; c=relaxed/relaxed;
	bh=DDksfQrsY3g2XAa9C6Rs2i6hobw1pNmsqvxtNGtaKvA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtB7ElUjg09uS0FyXLBhy993vGHGYbZUdA/q6jCL5Zb3oQaZG0bj9J/5paHWvoLzIY/Ai9T8C5SsyLhqhpMoJIml2Jj56FN19eZtf6lvWtWNmXtX4W3FAF3VSKuatjHweishOtgH7IKA3oDU8dB+WbCeBe3cjN6gAB3EuX4O+8XSHgY75BZNzukijVFKhRkUR51+oLksFsx2ML9KipjfrGCAt08C1mujIixTtQ41+ScRiWToe+rDBiFZfJ5rJMRQUwnYyWHMiClIm5dIcrehTju2+X4IUggoa+LNBHjQlEMd0GRjEcHdYtQyWDhpiuwFt/5kBRrhC5kx5dmErVjhYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwRVh2lgCz3bfY;
	Tue, 20 Jan 2026 23:30:19 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 20:30:05 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 20:30:05 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <boris.brezillon@bootlin.com>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>,
	<pmenzel@molgen.mpg.de>
Subject: [PATCH v3 0/2] spi: aspeed: Improve handling of shared SPI controllers
Date: Tue, 20 Jan 2026 20:30:03 +0800
Message-ID: <20260120123005.1392071-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series improves handling of SPI controllers that are
shared by spi-mem devices and other SPI peripherals.

The primary goal of this series is to support non-spi-mem devices in
the ASPEED FMC/SPI controller driver. It also addresses an issue in
the spi-mem framework observed when different types of SPI devices
operate concurrently on the same controller, ensuring that spi-mem
operations are properly serialized.

Changes in v2:
  - Separate transfer_one_message() function implementation into
    transfer_one() and prepare_message() in controller driver.

Changes in v3:
  - Add testing information for both patches.
  - Expand commit message descriptions for the non-spi-mem device
    support changes.

Chin-Ting Kuo (2):
  spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
  spi: aspeed: Add support for non-spi-mem devices

 drivers/spi/spi-aspeed-smc.c | 134 +++++++++++++++++++++++++++++++++--
 drivers/spi/spi-mem.c        |  11 ++-
 2 files changed, 138 insertions(+), 7 deletions(-)

-- 
2.34.1


