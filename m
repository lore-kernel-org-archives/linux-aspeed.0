Return-Path: <linux-aspeed+bounces-200-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB5FE77180
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 15:55:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8H9H5k7jz30WR;
	Fri, 13 Dec 2024 02:54:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734018899;
	cv=none; b=U7luwgey2QWMJJbL654rnykX4q2gITFgbMWgyUOvJ0rnHq1naqLP4S0fSl8UB+OgYLo7Vs6H9TX8OMb6rw1hgvcdxivvmRoOcIvsT/BBAcXwSqHb/6bQzeTzmBwKjI4TOEQUYoUMqOtigcQeR7IVJyTSiIJPJDzUYg62sOSkAK1tw72soQ93/bgunAJC49TWRbb3MoQMPmrvZtKvKFMDE45s8AdYwX4D749B/vBh6PeDo5n0Rduf+aOCUK9P40VPHYD85DZrBNHNOu/8yN6kP+/uBXBtw3wLzf6phkLstaov4OiiDqY9YbmARy63NNA2tqwwCjpKMSOrNMW03zA27A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734018899; c=relaxed/relaxed;
	bh=fsgIyyuNQQmHaNkLRcT2eUdPgUHi+wEuPOm1VPLeACA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWgym662sYcJNAU37AwOZ1jjbPEwLdv6TbgGpqc7vlbqmT254xVu2DQbyPWvCzDupQLxq7+0wRkGZhpXKD/yIcfew1DfOYdgezKgBDHReY56S5Vz86UaSeTuYK6zvnGtXrgGCi1OQrayP4RQ6cfGqwc9WZQeqYnZPIMWotqSOr6QZBc1+632wC+wwGTrBxBddbL0IAnaZwS3vdUlKgF6v8lRh49YweH2esV+M9eta6vDiGRQCGmNEV/r4NHwrv1ZwMv8P31hqtiWZfTTbGnaPdobS1QGM508r8hvlAsrT0mlnYn5RnOg1mgfb5+KxKy4BuCgg/BUcl0fQuyPwTYP3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (unknown [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8H9G5KBMz30Vq
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 02:54:58 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:41 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 3/6] arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
Date: Thu, 12 Dec 2024 23:52:34 +0800
Message-ID: <20241212155237.848336-6-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add ARCH_ASPEED in current arm64 architecture.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 MAINTAINERS                  | 1 +
 arch/arm64/Kconfig.platforms | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..c6d04cea43d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2261,6 +2261,7 @@ Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
 F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed/
+F:	arch/arm64/boot/dts/aspeed/
 F:	arch/arm/mach-aspeed/
 N:	aspeed
 
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 370a9d2b6919..894b80434776 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -40,6 +40,12 @@ config ARCH_APPLE
 	  This enables support for Apple's in-house ARM SoC family, such
 	  as the Apple M1.
 
+config ARCH_ASPEED
+	bool "Aspeed SoC family"
+	help
+	  Say yes if you intend to run on an Aspeed ast2700 or similar
+	  seventh generation Aspeed BMCs.
+
 menuconfig ARCH_BCM
 	bool "Broadcom SoC Support"
 
-- 
2.34.1


