Return-Path: <linux-aspeed+bounces-4753-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9231C5DF80
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 10:32:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQx91n8Cz2yLG;
	Tue, 18 Aug 2026 20:31:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049117;
	cv=none; b=KUjDf1goFU7UUV0ogOvFdctY6dWkEcF3+RDWu2NI6DMUElTaJlZb+ZEdynMZd+g5VkbmLHmJyJivncnr6KdzX5CqA9S1S3IzpF/KE90f+QYCnZsD+qO4VlPPDx25pkQF/SgCNtLkHT7nx4GPdysalSLsOZdQe9LkNOASniUxxP7kvUId6SmPME/9y2AehmciL3hYLeK6yVpshd0SPzHLFXkl+bdVQYTIFC5JrjzATclo4YazDP5EGtM3fAMhtAykCmL2Zk0phn2eM88EOSy8PktcLdLxT1BNz3TX4yYOCxsKdI4y117OwaHYsQFuC0eCezhkIDa9X23upu3QaYUTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049117; c=relaxed/relaxed;
	bh=shnIdCEg5h/jv9ES3TNBugMx2+hKBHKqFcN0Zurfu98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IU0A26Qj9IKZUV76HknTj84hiWYG9s+qkmx20CDdlGLvLZmPKO2CZ3b7kYb4ff44rB63XUqX/irjwO5EOabfKysoEpyxnATJ9aDvXG2F3LmkGsbMshbC2poxmQXLgF9jvWd2ayuLZW8HofvATeclucsNr/ljkxZbzpQpM8I5LHXfZLG4U6IKK1DzYzlGMGBlM2pR7EI4LX4uNaBUn2y3e9W5VUvbLFc6P03jqrKCFnurwNUqYTaZpzeiIdOPpytfjLjcZRo/5gpsOWh0ms+AD9tGlhKpS3dYF/4j6M0wwPXZjTq+mPFdJuJ+kPgL0OX2PpIGZ35CrhsoP0gYYDZjfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gid/ecYF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gid/ecYF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQx82NPBz2yFW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 20:31:56 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-49802c418b5so48114615e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049113; x=1787653913; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shnIdCEg5h/jv9ES3TNBugMx2+hKBHKqFcN0Zurfu98=;
        b=gid/ecYF7lz4IFC5BufS/6VRP9kNQ2PpapX1ebMDdTsrg7+2YrXX6V/IxKmmJQnh2R
         6FoTVxaHoJDSo08eURNvvUDcrignurNglERf7kkBsVMHrLQSIFSFrKGC0IuJvMra+1au
         e2PUquhEXkNriIZafuV5uJY5AWs+iK9Djm1/PASakOS/Z7EMKEga6/jftNWKPmgLjSLT
         GddXdsOPbMhAZYpRLra2TtuTUAM1tTcEKwL17BUm1UQ4vYSNE1wricfuAuCsErgHD8YT
         S9018FdgAOxC2dLs/cmsO7ITUtPQsTdVvcILRp6Qu5CJy9/4RfKTakH+c7kUQwM8FxpC
         G5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049113; x=1787653913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shnIdCEg5h/jv9ES3TNBugMx2+hKBHKqFcN0Zurfu98=;
        b=lEX8MUhUvZniLDHGCVIqaI/4PgiYv2N82OpAqgi23WxXbALCj8k2o9EDIt2whGUxiK
         viu0tsJaONa9/oe+mZcKdWhub6y/Ye752YeAnd9X1GoP7hbMXLby4XMa5I3yLLDFzi3a
         WjZNowsxtSh2HbDhMX5dCuaTSyKyGoo6WC6hgUZOB9VgeNZD5nYribSGui/sA9dS4iFY
         y8ceMqLqRJcBngwSvsgiSKIsfw+rdlVPz2BU2xD/EBm67zk9buCr8fzqf2UtjPxLpGhe
         Cn55Z1iUUw4xU/RMMhrJPY5xgz7EpZ7mV2d8/kRzXCm1yeR9WItSAY+jV7r9IYlGHiIG
         Ev3g==
X-Forwarded-Encrypted: i=1; AHgh+RphWtyDMHKI5UuG1uE25E5c5hRfN2YubACLQTtbJKIKbvoDbUbFTSpa732/KskhYOU7t3uEwiQ5A5UmQ+s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAazCvbC3Gn7wK6ed0rwekr0k4DvoTt+Td95OR2Tb2smg7bpgE
	mqrqldnptpus514MMXt/HMmhK0YTFgROlCPCYEjxOVvXBOZB+in7WDg2zEsSw/rWG4w=
X-Gm-Gg: AR+sD11VYSKez6Ly456ruDWGI/M01ebUL+g+w1zmtpjc034fnDcVno1H2L+nDU86RXO
	GUHutgO3+excVMuGQUDwr9JsHozqhsCWEoUVYl1ShxasQToembe7LQKWBVSuKl4Dc4xskBiLjUg
	Jw6Udmvk43vsvJ3J7Z0MVeMZgZE2SX8YzP+MXWATsrW+82cO/5ib2XCIF90pHsu6R1u05+x4ArD
	wmSRd4aYA2LB4UFVpGRm7Mz8oXpgY0hevqOepMLw3C5bZrAGV5aMLmsvebznJBBCh3RqZmko3Bq
	mWI6CQIRds3HE+7Vl7OWqYkcR/dEksvE08iA1MqHDtWtmZHVqDJVvl/KPzd35wLwEa4RcTvwS0v
	ORKXvehLEZjnrGiHIObx53yzDBjIfPkEYzIcBf2hnHSs0zwydNotoEFbU9zi4kjQHxzXoU4bhEy
	h7dtAlqjhKiciK/10Q018PHPXwwAti5VMFaU6YYu11jTmnbusqE3x2Qu5QVymf8DCfwNnsMMM4t
	VUi4ZZrOf0may7KWU68accxsBtS23JbwkADYyAnViDOGvLIsU9Nl+VOIxh0
X-Received: by 2002:a05:600c:12d3:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49987980889mr317588565e9.10.1787049113006;
        Tue, 18 Aug 2026 03:31:53 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:52 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:19 +0000
Subject: [PATCH v6 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci
 prop to vuart3 and 4
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-6-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

The VUART 3 and 4 are VUART over PCI.
Set this flag to indicate this information.
Also set the scu-syscon phandle.

Added lines are compliant with dt-style strict mode

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index c952e2075b4c..61cdca0b3ed7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -723,6 +723,9 @@ vuart3: serial@1e787800 {
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,scu-syscon = <&syscon>;
+				aspeed,vuart-over-pci;
+
 				status = "disabled";
 			};
 
@@ -743,6 +746,9 @@ vuart4: serial@1e788800 {
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,scu-syscon = <&syscon>;
+				aspeed,vuart-over-pci;
+
 				status = "disabled";
 			};
 

-- 
2.54.0


