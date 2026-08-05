Return-Path: <linux-aspeed+bounces-4624-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F3C56203
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTyp3snzz2yb9;
	Wed, 05 Aug 2026 22:20:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932450;
	cv=none; b=Ji7N7R8jXsU7eIO/0CHgkecWvovMDxhXsEm/BkZYUlRd/dpHNWXqvu8y62WVTJ1W87uQkK+GtBj1auvMz+PEuyLGeaLQPG7u9UbJWwgK6bRqXYwZvvHkBbkXDN9I1CuOIO1BNjP6O4/z8vdqXzvQZxGsisLDm2YQr20UkxKbbT2G0/CFADRNlTKXx8uQW+xKXXjQEa35ACMQ+BG4ZCgPBc3cbbAaY570/9EKkH9FjT8XCoWX/t5U+7AleI7tOAAXTbRXBr6/67jNExLh1WO9CW6zPADtYcXiwelxIyEYyBUYgzG5WJ+8YQ9zQvXS3e/IUA2khZDz4tOATSuRxMVMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932450; c=relaxed/relaxed;
	bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXnSyR4wE2o6J7BWzD0YEEVNbuG+nd76vwdyKk682QghS9BIkt0SRMrBGB/VRLTqFOYzxpiIGk0Q1GnRNRwvoLeDapT9X91tuuVbilhX9tgxiiU0upKYzjb6E7APhSNp/8UJmzjrHkylCCPJXK2fxSK6bab+dMSNLgunD5NB/Xo8E8yTYUrsWE8Xj3qkE2B0w0x696Tq/QidN+NkuXSezsn3goAivvY9oZdQhbJqiwYzAKuIbYl+o0wsJEJBqk003FPIDBv9VbSxDPUpAzCE8Cu0tN+CKsFlnrb8BnA9H+ndwdWnF88xHaY/+TQHh/IdYlhskk7RcgYoZWsDkArT0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ISk78hk1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ISk78hk1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTyn4VXxz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 22:20:49 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-495635a85d2so8104365e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932446; x=1786537246; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=ISk78hk1rfOOoMVdiqwTzmAH5kIBe+n2o46PKo2XE4xk/cMtUWruRwUZOVl6l6hxFm
         oGNzEoyaYnTVH5J7CxzuQGBTwa3FfA9l8llVDDDNnrdUFlLEzFx0q4lutTFQp/vbRoD7
         hyi7LJgVRgh16wbNDKeqG7wZ6UgxUeo5IbT49DBGO0lAuUi7Fwaj1M7kw9qfoA27DKD6
         0Fj3aJsrqwenSZ0bxrc0u/qjLceIDZXMwVvdba8994+KXJ6HJv+SFEYgdVtlOTLMeo2P
         HTI/UqM3jj+jrzFI/1SE1pRkZAoaTy49Om7L4PZJ1CuNLdkVE3bVMQSSYE9aR2TaCq2+
         u3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932446; x=1786537246;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=E9z33QDH38t+qnDCm8bYQkgUj/UZmjirVJFa0XCxHQWrDvxqT3/IDVaBrkzJATVQbw
         b9/nLdoPa3KlcEeiGeCZO9ALCcLf+4kmdpTSkp4ynbqiXsACSYMI03o+TPjydNhUdaM6
         ENfhh/sOPY+NCwDSLhwMmT3W0uzo796q0PuJrhCqdczEAMuOibfK/YdzSw3rYbGUzXCo
         EPRAXKyDFPnuTvIGP43dOEaL1Tz7JoPLVD/5MJ/7K2jkxj/2h/PpIDDKpAut+Bo+f9Is
         Xpn0zYZCJq5cLLyB6svsC9q7uSiH6pzJ3C9EwmKKMU/euBgoPVFoImavMXmS2hq+v3hB
         YKfw==
X-Forwarded-Encrypted: i=1; AHgh+RptdEPazWNi4RFC3II74Gz0vniuyBQDZDEEh2JlHTSYkjyfdY14iZ1RW84mPyDvX5xmDtfGsyXTQfu0qdU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFgxvrmbPtpgFIBsoagenAz3ldfrNKDHYbtRR1x/AI9nD26xsL
	RTqicBNlqQdGwuKvUNAzdpzkrfmK8+s6RhSryVYPPxoGzESPn4lAqrKeEmi2wr1Psr0=
X-Gm-Gg: AR+sD127mw/u1t4Ovuu2RRvOB7dAaRCipp9sgES/Inb6V2CbnTdV4imCqPgEg/QMbmD
	f2CdeRMjL8g/Cc0EWR9OiGZWWFiq+qSvsLR0A88s8Aaec04QKRmA2GRRZKMTXCoczt1uZ23BVad
	r/kMtjACuERp7hs7Alkxvxfh/kW+HDPi6aAXAwRzj0jpHTHq6Wh9m+qHuV7biL9UI8JI28+Au4X
	taSOVU2Ygc67m7OxgVVhgjzPZqs0pF6Y2IM1xNWB7NCqa0T5pbsEGpdWh/KUUO79uk86qwDSobE
	EUXTd/y7tOy7ru7vTz++lHAqwnzUGs5VIkNHkvYXhfwrgHYgWGaDSZxNoky5jD5tiiRxS4HtAcH
	5MS+YVlcN1IBEGHA4yQj+qmPEkIrtokIWIgqBdBzgnyXJr4ykyIRFtibQf9nj6jO+1/iIVS77WU
	18O/9tMf1OE0QZYwJ73l00Kq7f93fxe1cD3yrU8x5hDlAnc5QVWhGF1/DeQa/6XGeAOilkO5aiR
	4hBzc0BFR37wNQoer7ukH+1kv6kPPjCiZc81aDGtVwdTfTJyy/OFCOWd6EhR+WRsmZNorwa2p0C
X-Received: by 2002:a7b:cb95:0:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-4994e7c118fmr56108875e9.11.1785932446337;
        Wed, 05 Aug 2026 05:20:46 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:46 -0700 (PDT)
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
Subject: [PATCH v5 5/6] ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
Date: Wed,  5 Aug 2026 14:19:52 +0200
Message-ID: <d54bfe689e6a0f318961588ab6b72fc2b09ebb47.1785932211.git.gregoire.layet@9elements.com>
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

Use the ast2600 compatible string.
Make it more precise and enable specific ast2600 properties.
Still use the ast2500 compatible string as a fallback.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..7c02633f2bd6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -707,7 +707,7 @@ emmc: sdhci@1e750100 {
 			};
 
 			vuart1: serial@1e787000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
@@ -717,7 +717,7 @@ vuart1: serial@1e787000 {
 			};
 
 			vuart3: serial@1e787800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,7 +727,7 @@ vuart3: serial@1e787800 {
 			};
 
 			vuart2: serial@1e788000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -737,7 +737,7 @@ vuart2: serial@1e788000 {
 			};
 
 			vuart4: serial@1e788800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.54.0


