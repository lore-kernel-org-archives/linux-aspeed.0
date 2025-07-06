Return-Path: <linux-aspeed+bounces-1644-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D316AC83F0A
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5D35j1z30P3;
	Sun,  6 Jul 2025 14:24:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775856;
	cv=none; b=YLQuAMmX85zMkmm3cicy2DeC4sQ7QuYALYh/p4ZBsRVyE1xUD+l8RtdcdxcSuh489D2BDEAkFjPWj/KtnD/K3gEXQ6XVJyBWd6fOlsfcqd8c03VFP7S1Ipi3brjsTnRTEKzZ8NHsX16QgqCECQZN5Hf8W9WqLciUtIOAnheAM+6c2ApstZ9W/9DFngPQsIa00OzahlC7hOeisNLc2JRKqEcduQ9Od1Rtt44DI2HdhZqCGsIk4vsRNX2dpfmTW7UUW3r14yxZhHpIBO4JHeKWmjYp7snaXrOX+BdKyZjljULwv76k9PE7TWT868F9tIp93MoeG3HwElrZxAuGZ4oknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775856; c=relaxed/relaxed;
	bh=1/nsEzkMIZE8SZ9hqeEaMWmjFodhjCqtmCwZs7Lm9Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XboC2MHW+ufWGsyv5tDR2NdGQzTSs1r7BJDxAzM1QCElpmFsCta6hJmU+nK2BXnveFSz6dkWzvjnDGKDTQhrBpwIbnhSp5Nx0JGgcD4DKZNUQp43WJ14QZkViHe4A9+M6XPLNrYDftSFcdlL3v+W2WiW+F/8sRMpSN9Sb41jLgpn3qZDfMTpJvNEtpJROIApiQQrD+O0b742dggoWlktW+IYsc/D/klVfz0iQXT5jsejXBm4bdy6qir+k0rFCk/eApFe12Ncam5pmAvBEHGF3ZxcIYU+7Fed2Bxkk7B1tt9FAc16LEr1q2dqITaQwZBZERfl6POCxY5YbBKlB21pIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RJrjM6Ne; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RJrjM6Ne;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5C6Xxhz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:15 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1474337b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775854; x=1752380654; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/nsEzkMIZE8SZ9hqeEaMWmjFodhjCqtmCwZs7Lm9Pk=;
        b=RJrjM6NeaJ0+b4MiccjuhVtHh7DMSSLg7y7CysVCvvVJs41iWNIlVuB35WCqOjKrWU
         rs/EJMtmpjTTjP7R62GQG6/5Q6yH99yz0Rfzr1jf4oXNohAAkBuTn3+WvH7WzOtZYiBk
         a8dk5wW/uDd8lR5Da4U+x6CYdXzgSD85kCNszyDE4CS4vmBbvXb1lFyPKQufdlkGnqlQ
         iDtDgjS8ls4TA42+eAsPuidUQaw07eKG+SnaU2NcqUy/N7xHe8FUw7NIwa+Ztvws3GyO
         /cRTR+dmQsYlSHAP2pyg55YMbT1t6HNHiqVjE3aNF86Oce4RuvwOBiHfPo18oZrlR+ym
         UGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775854; x=1752380654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/nsEzkMIZE8SZ9hqeEaMWmjFodhjCqtmCwZs7Lm9Pk=;
        b=F4C5CnRbBg2Cj+E77X+TQF8dKH7ccwNCCU28JBFZxyeb84BIl/KxpLWpOV8FwuDhd6
         zmBwBvvvJnrCoAQzIwwf4HdYQedg0o4FOak/3pr9kFn2JESNalvx/bbebNQb5ot5a9Fj
         /sgIG5FCnSffctDE00kpIzrCPeclYtoFEthJYdK7odrO+07fUMrE3IvK1h7qTvj6imCW
         bcpIyOR0FsoYVkeMkOtYHRx+HkfO9pgTORdi7RxxsG9f1k1Ft/tyzfxZ+XeZDpB64iq+
         kVDEqlcJKKKhS6KxqT6bqM69cJyscjTGqoe8De6N0pn+NtYxoCd39vJf6OTgtuhQdJt3
         LSsA==
X-Forwarded-Encrypted: i=1; AJvYcCXBJFh8gG74zXnm9prPxS1oaCqT6wdpYT+btQKBW6d4sRTo8onTa+gw+TQvx0Qkd+FZHl21yQGrz7AayIw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxoRCqnjH9KqS5Sy+ofXlHSPIRvMur6zEnCw+KgSQfVL5OBnaRf
	bUu5xwCuAkvUJdZNWavn3gCHPhSin7Xn20VkvvQm16v2twWpy/+PnYdN
X-Gm-Gg: ASbGncs1FBeGuYrE4Zne2/jYO5qUw+Yq/Pe2msrjS/1Jh/iMBUhRj2hr3CjaO2ZNIWc
	Jj+QY+6Un72ZnjEhgEZx5N29/rp917msZP/CV68nRClJCrNciQhKzb6B0Q6NbWKa4mRJ3p4SVKz
	55f0NAS6LE91cnLRybTnxBuz4dmGtXrSruZ8vZt6ze2N9xlA8J+EbQFN9cb36rabKn5wCkXaaTy
	rBQo8bRR6Od5XmfbGwPUghB92Tk+9hoLifHzI3XUOcM5xEyKeJTG6cQEzCbSLTWME2TtLK/OrGI
	w/V5A4Qkgiooc6BqEMOhCeRYVXSakEDkYvVX0xtATt/fF60mB7Kv1TtXWcpkXQVIPq1o1NWq6G5
	lEoay3ma3x1UPv3d3/GxlWhdv36JvYTB+ZKqi4Ao=
X-Google-Smtp-Source: AGHT+IEjl+yr878AvrYNBjUfIgoQ/EbccqkuBkxrKmYuvGD506F5090znUS4nJqBcY59mIfrNTOXHw==
X-Received: by 2002:a05:6a00:2e21:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-74ce65c5262mr10425610b3a.16.1751775854164;
        Sat, 05 Jul 2025 21:24:14 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:13 -0700 (PDT)
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
Subject: [PATCH v2 3/9] ARM: dts: aspeed: Fix DTB warnings in ast2600-facebook-netbmc-common.dtsi
Date: Sat,  5 Jul 2025 21:23:53 -0700
Message-ID: <20250706042404.138128-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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

Fix deprecated spi-gpio properties in ast2600-facebook-netbmc-common.dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v2:
  - None (the patch is introduced in v2).

 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 00e5887c926f..208cf6567ed4 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -31,9 +31,13 @@ spi_gpio: spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		/*
+		 * chipselect pins are defined in platform .dts files
+		 * separately.
+		 */
+		sck-gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
 
 		tpm@0 {
 			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-- 
2.47.1


