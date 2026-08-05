Return-Path: <linux-aspeed+bounces-4625-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F111C55174
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTys4tY9z2ygL;
	Wed, 05 Aug 2026 22:20:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932453;
	cv=none; b=fobKeSe1y7+qVpUdI44iKbVwcwhGGmHvq2qmS6gJ1sNDQzyESMaw1wo8ZTj62tjuxhsXUwasvWtkMbHUT5/UAARhhtUzDMPAwE4tRQrsNuqHdpgeTKYMAaP8DP9uYBagMCxzXNulhbtvRK2K1SUooZIopF/T6rkGLEFWnttQ3ydUYUbx9POlg2e0YMVjzGJcU99At3N1lfcYYaNuVhjzHhmsmvUHyyL5RpIDLd9zECWXAznG/xep9iEALbLIPq0Bjr0hyrThtf40rASWbWHukGXVzwmpHy0bHEO2nbCOkSRWW5rN3jIohH8kQnsn+X627HtsBah+9MfAHwpQY+NAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932453; c=relaxed/relaxed;
	bh=P/7dhBSgukk8ss4p9GXKM7Hns3H6z46vF+Aj0GzKdlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4Dq+BYscYgz7lwVAo0u7vsuexTlpoXRjc/s+SrptQj7JQE9goHh9C5h0gv8JSLD+4zA0HTPi8g8ENYJBUoz4Iyz8UtUufIjBXpRw0sXk6E4KvxxhrU+MfqFoSMS0dkEuegPv2ukB5kXyuAMBkLpiinyFC4kciDwmtUhkxniMbX+5sgEWp3Wyj7Eb2r3RDZti8alorESTCMjIVU2DUGRTOmGhjUx3liNT3S8MBAwfy90/i4yxo33D7Cl0aNc4EyJpvMQf6Jp/LLMoeuqpqqcyHW9ElXQhbP6b/H6551l/U9+3mmLeEdGqydWJ7uf0CELNPc2JoijgDWl3eJKbhgTbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BSLd3uZW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BSLd3uZW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTyr4sVPz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 22:20:52 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so7365345e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932449; x=1786537249; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/7dhBSgukk8ss4p9GXKM7Hns3H6z46vF+Aj0GzKdlA=;
        b=BSLd3uZW7eHWzQYK3SAZRyJv1/vAY1wP2lratOPth1ZKNu2X7FEoFocGogCwkKsFss
         dkwRSUpfGwwWPtxWAyavVp8o0rJevk631XVVVtAvzvjM99+gMTkPB2y/W2B/YJoMtrQE
         mEmKeIqsMI7CekPq4p6Jka5a2Ny1U8ynNFjY6JZvC0p24dj/0wTZaoXA5OxGMj5AZuSS
         LcxcbKIXD7PZKbjOvXLboEIHF8xdCl5mOgNaZo20bfqhJBQhBLLKDApRFC5LbHKmzbm2
         7RXO/n6SmxdZXGqATQKlZBYf6XI/QReF9GoYtYTb/CfZ22+G6wMbnWvxh7BvidD3w69P
         ljjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932449; x=1786537249;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/7dhBSgukk8ss4p9GXKM7Hns3H6z46vF+Aj0GzKdlA=;
        b=OLPkfNvhMQO9OLTPSiQBQfpteOcj/keR+D1f2NWiuVTJryyRallQACruZGsMk1XLRd
         /n0cqTOQN74ddVDaN9aYC2zZFmu5Wbvqh/vTagyky1Zz4qZx6rhtWhigPPBKPTmPm5Nh
         xhve1JP4sTyBxcxOIpzRmH/ACgy6YJ4oaqAv4vurC2DSvcf18kbNi0yxhzpbOcrGG2ep
         F8MNRYnuTEvoyiT0haOLoWTPpEx91Mf5zAQcNM+nCiIV33yE2k/rJ45/A/ifLlmtFV+w
         RRvKkcVSuL+88M+J21RAV7RtGujXGBQN7PjhZ4YeYPaGINSDieuk4xba+5zntcPEUB8f
         1fwA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7xofPHfyVV/NO3egXCwngE2bq+iAz69hzPgkeyTOI5OEd9wlUbCFhb9QcBTVl2F4yon7U32oq5Kxk3aQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWSfmgu2UBEacW7Vdhb2kBOi8Y6S+kswUQupAy8we+NDwYEr4c
	90cfHEWBTtluU3X6lUls0R/R8UP0YOffm6E4lQHFpNKDFu6oCWzwbarCKeFE6rZ/YCs=
X-Gm-Gg: AR+sD10zG6oWGjoxFPQVnwUE6z0fDDl8GAEznLE4D9eTKUdtZN3usADOQ45/GrknlJ2
	uozZFeao+EBpSlgS2/skVze5wBi9E2gpvjF5WVfzLY/WlYC+1//gWYmpJXrZmENCh40Jg+YDFub
	bmAeJBuBi6qQq7sOtMBfUaWlzeC8ckv4qC9PqU4XNqQm3YT7AUcAbqaw9HqiN40GwNp5ot14XR1
	7B8JV0VtrrDKSwqlc8RCXde9/nCNLc06s5ikr+EmGWEeijaYEOGiqVt+zejOMbkeV9GpVYj73m2
	Chn1JsQlgli7D1+g+6Q2OLZo84p5QtIexvEjZ/GL9RkpT1DXEe5p9S+ucuf2Z+b3lAumz6zdIXb
	3Ax+j7nInVaDVHPloaHmXlMQIO/jmK9XcdkrcHisovbaGHmeffa732Fu7v89eC/0z/E7GHA8enz
	46IZhOoXmCC4vvB6BP+EWE8hyPQCQLaEsLEcwuWAmgtxqZiztBmQe6E3MwxdfHlGJOrnx7LSfWX
	DzQggGfSfTatYwU1CDO6DvC0FmwlAyIkRw3q6bJ27laSJipxAppvZlhi6K96EvQEngY/d+C5lto
X-Received: by 2002:a7b:c7d6:0:b0:495:4b42:8677 with SMTP id 5b1f17b1804b1-4994e7d17c3mr61632935e9.18.1785932449558;
        Wed, 05 Aug 2026 05:20:49 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:49 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4
Date: Wed,  5 Aug 2026 14:19:53 +0200
Message-ID: <8d24d424b3504105394055de268e0a11515635a9.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The VUART 3 and 4 are VUART over PCI.
Set this flag to indicate this information.
Also set the syscon phandle.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 7c02633f2bd6..fbd7ab6332a1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -722,7 +722,9 @@ vuart3: serial@1e787800 {
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
+				aspeed,scu-syscon = <&syscon>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
@@ -742,7 +744,9 @@ vuart4: serial@1e788800 {
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
+				aspeed,scu-syscon = <&syscon>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
-- 
2.54.0


