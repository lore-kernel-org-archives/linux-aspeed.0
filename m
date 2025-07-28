Return-Path: <linux-aspeed+bounces-1846-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA68C87FCF
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75X2jNwz30WF;
	Mon, 28 Jul 2025 15:56:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682192;
	cv=none; b=ZZzI7KIeXVSvN1t1NrpkhopfzjhR6gt1V4cTzN9GbwY1FeoVpGv/psVjdOW7FObE35vtaFRTBHMUcWfBgdKZTESmu2sRkcAXTRs+LrrmpUCholTMPDoHaSxS7UemUjqq0kj9gECGcRThuM6+owCmu4hEjPo90Fpz3TWPjsyMr7fOtpCP33cgkbPfxn/X9thW13DNBjZ5vVLMWDp/gLzi+SSUCmqF/FMpUd0irEj6Z/qzTTaXjjh4qUCQigHPmbJVXojQ7RE1uDi/OFTJtZeFAAP6hsVE6VhVrivxT3VMub5whq2kVl69zw96fpVh4ibCHw05DvcqhM/6GRJWsbPF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682192; c=relaxed/relaxed;
	bh=mL3WUAt/E/JB7U4/txK3K9d2bFPzk59C+WVfG91tte0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGTlWMNjH+lSO2hIRLN3DBlNfawnNyqsqSfUiwkVeD91B3P8/PpEy42XhcDWZXPPIW4goV+pCrbIzeKuzjG/M0HeB1srOHHfVhuZ2/Le+BYMTpdyR+gnLqS/8fE9/lMcQsRYwrgXo5QL3BKegVf6Puv6YPPdaMUxB/15MzdTIMDyzHUMItfULJbMRVYljc0Dq5Oeiz121Jpys4dXxo7mDQpUDH2ain7Yj+VisrYFk0CO+CmbnzzJQvRgsqmDkwmoJe5434IbbrUM3/dBgohnIj+fGQ2uYNPz6I7ewNLB++XIQfYfYxXnaqiBVZFp1QaItzv3v4y7J+Fh8u+7Mz6OMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OXQ8oM6P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OXQ8oM6P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75W3nQhz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:31 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-23fc5aedaf0so10499925ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682189; x=1754286989; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL3WUAt/E/JB7U4/txK3K9d2bFPzk59C+WVfG91tte0=;
        b=OXQ8oM6PO7va5SS7WBk8vVaSKpUe7cBzx4DCbiB4Vl0rgeHAkdnVlmCGZ71BBRVPQp
         UVjWLpmP0FmyBSEfGfMuZ4SLKa7ReFfTjBkYCUWUVWZ+66+MCh6u1mtzquuEW59oFj4x
         MIWVsQ6QSC+laD7u3WJ7x8ho73wp9cSePDRfq6bBekW6Qhm0qTlabIXIyvRGsUF6BiVW
         Cs2IsdtIqEWl5V1X4hER1f5AEsH9WcU+gRNQC0BrXxDSUUT456DS/kff16x5voJV8qSh
         UQJVIJOjRVmtHaBDvrsdG346GghvvyafRDD1eGz9DOMAWgEWRIWC6AG8ByhC7k8h6uQE
         LqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682189; x=1754286989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL3WUAt/E/JB7U4/txK3K9d2bFPzk59C+WVfG91tte0=;
        b=dAZX5OFcWjkiDbeyEEP0IdHKUgUEZ1EkmpgfeSB3dss4JAn1FiaLnCS4jlmJBNh9fK
         2UATcrdM2tKXS9WCWB+Z7ISmZF3ThTtA/hMgACl2cRmrwjB8RVhFA/4SsBO8PJ4GmRJx
         tW5BsWmgC7Lfn+tFwV7usSrkPzix1YLkv6nW2ccWkanq1bKI1FxDNQ1lX6oBi/PKF3qc
         SGfZA6jzP/+g7z3WK8Pd9eTBK6cBoRA7qx/CXH9tVOpdXpyUX20SgyrvMxsgAB6RhiYI
         tbJ7t0lOjHXJAyDbUENIttkNqKMPRS51MrF8HuEJGYQ0poYVVH09XIBT0ufv2NF4s52U
         fOZg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Xk4tAW+TX8a/XftTAez76HvlJRKIQXFQdejCvPZzsPBWRNGmQCkupULUHmi21ptI+2doPHo6M8K2MzM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzmxGcXvGHJDlvFCQ/4R8wTnMXiCQhwQ4MCgI/BpQxlJXrglQbX
	v1BbS1hlKKeLXgdK8Rvs7fqLulx5wxJiAnNrRfBsq7cW+klHaABXEjiX
X-Gm-Gg: ASbGnct5pFQ0ErJdsBYvIeJCASZZ+PIHmJQfhuTDYomWx/389jYIHapdCW53DGc2CcX
	OK25gbXr2j5KAptGnL+Vd8AEiOInclZzCA6eRUpureFlp9ehtod5rL4ykAGFW6bHD6tn4739Aw+
	fy6z43z5KMB+U9o5FEmXQyRYJ2ARLW4bV6cLAA3Rj12GDVZf+iRewoWzW4AY+ugCbtxTGhZ4H7k
	rSZtUjW91IdKrHEkJAXI232/vBO75IrSZJwLQHLb0yQ8CXYamBuuyowa+swK7v7tItfgqgKWPEq
	adM5n+g/OuT7+sOfnFBoPkQIUclEPGxuAPq/YlmbTRHarp0G8KCSDVUEG0jKltpgYWDqS7iHDZN
	xf9Ms03NCmPKReX8/5H2AwOmN1GedIY9WhW/Pa++vJxgykaOgiuxNyRdvncjd2eueVpXi90wzVS
	c=
X-Google-Smtp-Source: AGHT+IFYSrKh0tfdTWTrBVWNM0zAsQJS4EjDsjvUY58SNitCxSLezcS2f29GrbOUsvr7sviStuxoDA==
X-Received: by 2002:a17:903:1a08:b0:237:ed8e:51d4 with SMTP id d9443c01a7336-23fb30b3205mr188991885ad.24.1753682189146;
        Sun, 27 Jul 2025 22:56:29 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:28 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 04/13] ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
Date: Sun, 27 Jul 2025 22:56:06 -0700
Message-ID: <20250728055618.61616-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Move eMMC entries from ast2600-facebook-netbmc-common.dtsi to each
platform because eMMC is removed from future Meta/Facebook AST2600
Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - The 3 emmc-related patches in v1 are squashed into this patch.

 .../boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts   | 12 ++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 12 ++++++++++++
 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi   | 12 ------------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
index 74f3c67e0eff..ff1009ea1c49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
@@ -201,3 +201,15 @@ fixed-link {
 		full-duplex;
 	};
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index 840d19d6b1d4..d0331980d082 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -1243,3 +1243,15 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 208cf6567ed4..0ef225acddfc 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -156,18 +156,6 @@ &vhub {
 	status = "okay";
 };
 
-&emmc_controller {
-	status = "okay";
-};
-
-&emmc {
-	status = "okay";
-
-	non-removable;
-	max-frequency = <25000000>;
-	bus-width = <4>;
-};
-
 &rtc {
 	status = "okay";
 };
-- 
2.47.3


