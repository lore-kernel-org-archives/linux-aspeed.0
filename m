Return-Path: <linux-aspeed+bounces-4486-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4BBC4450A
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 12:36:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0bJn4K1Vz303X;
	Wed, 15 Jul 2026 22:36:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784119001;
	cv=none; b=fVFCYlbGJW8NIpDb4ZmfXnshhkPdkx6mTGBYmx3lhVJsi4swW2ILPoqphFVk+yveTpM9Ym3INJNwk1+hxj6ehKdPx1INj0LA81KqMBdyn9znBNO/Ci//q8eDmbzTcGKzcpeGMnWY6IzerV2/zC2iuac8YKx9jkzufxb2NdEUDvX6Y9Ec2jWUmz8RbqAH/ED6id2WguhPwsaJ2Xargch+EJAAFV0fvuA5XC+BrOXtngu4ABXGWeqbRFRscvwUYmy2qP4t/Bc1kWVZ3c4tZXNUpRIN/0nQVzfYbApAq7EWsk4soQfvPrQ0vKSuQcrs/IhyELS+IT0nzaH9pWaM0F+3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784119001; c=relaxed/relaxed;
	bh=5g57A5VbRGUC82ryAttIcVIyb54fRoQlQaSUTrU3GWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QsqaR+whFdGWjw25yC6cKA4CdP2waASHSxYiPb3d2Wv/7ALykWGffigA26tK2JLqL925lNxXG8pmGCD/8/q7RldG5qTri1scViVtzlBaPeWRkhz5dVSSRX/K4I0xpyuPTKrsnRWcL95Ba9iDKjGmseq3u6SWe7ehyx3/ZxiSr6AP+KKh7xw/3g0H0DsbaFVIW60sUIo85D+8Hl1VEouKcsh0DLreEbp7bEC0HPSLYIR59kdbI6M09X9xWAmAnHs+OLIMB88HghQWVYidZiVNSeA1ReYU080ksfPw/M43qIavGIyaqHN/0lqXnL3kvf7ZpBpYC6qB/qnCIOmd+HK29w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NwHXZqSR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NwHXZqSR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0bJl5zf1z2xC3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 22:36:38 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-493b27c7451so7719415e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784118996; x=1784723796; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5g57A5VbRGUC82ryAttIcVIyb54fRoQlQaSUTrU3GWI=;
        b=NwHXZqSRX/KnD1d33bP8Py+50LShJZFrxJNIm3DFPTZ2zIXYDWADcmQZy5kv9c6YE4
         nXiy4PXKFqFx5JECifhClATxyqijLejrzhAXdO4RnO31Lry4q0rq6RJEENkX8cHi30Dm
         fz93arPzUpeIa6t5SHJxjYwI2BChLAHogM3LcGL+P+mn8eE2IgWnQ+67+TSG7KmHFCql
         6RxVo/wV9JNb9hXPr+S8NkbCEUM/vj+6kVjkdOw7+wVSwX9j+RF2FwPeoP9Z8WI3vt5Q
         DoBDzqo1fSL5BpOXlC49NgxSNZYwb9ebFthSjli4epH5B6nqk6hKCh7ZYT5ZtNFdSGIL
         kOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118996; x=1784723796;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5g57A5VbRGUC82ryAttIcVIyb54fRoQlQaSUTrU3GWI=;
        b=nWsGhZcxeBgbu9Gb7o6suUS8tVJktqL8qvQdDOUbHdcLMGArKAT7FfJ0SUZdLFThwQ
         NFqCE2YGe2Iqrr8daQYk2sqFC06SWPtb1Mn/WSwxak+5K+788kog73IKoAAksAcw6+JT
         HqR5gBd1aZ0v8IGBokXKRU5U1jXRKmUIcuDKQ81vQ6lUJK0/YL4aIwvLgneGAItgD/+S
         dAmbjlJ79jtaY/75JSW7RDvIm0bnYda+oqBRhOnc6Le1IWzdribQ7SnexEnDRtlULoMr
         kKP2xaWFcgHBpEUFhA9oYKAJJQMx4m574CJRS1fLv/dfjUj4e1cwAQZYcCJIlW77azIf
         NTgw==
X-Forwarded-Encrypted: i=1; AHgh+RriqDMxKMZz6n1iYBlH8tCg7nYzq+7iocQ2MVvkbRSbjdP9Pu9kQseINI1STJxFXmxMXAwcT3Yp/goB+dk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWKzpslp/mNbUXfSLERAmM6YedExMFj6pdBBkgFhoZfTjAU6Mb
	DzXIv3S9gq4dRga7npcgNFHANusGJHLrJiHS7QdWXou9rgByF3ohB+n6ugLfXLv4k6M=
X-Gm-Gg: AfdE7cmOayt8LvGWC2/o93yhIxsaadxRyql/z5DZCx7hDh79ve5GAarfHIAde7QBS1u
	fw6ewvYrPfZWbzQ91o8qVB/RIQqkxYfiIuzri2IvIz4aNjNjfHx/zUf70XljYdpuu6yI6DjLMXD
	h8CdzWuAf08W17xdtZ8BpW/iCakqP9mfBiIRtWMp+qgebVH23Q9MUWxF/HhKPXtTgkHqGX0hLKM
	crlJF5beio6g0JgN5Rcjkr5USXljMp8Uw1hWyT58FkVEOVDMmmVD4qXJJA7jdzAydq/nqiLhkRc
	/u63+yxDicqPK+ZyXiG+p8UYBx8NsZgQFRBh+ocE14YHqvHYGvbDdL3o/DN4RpFYjx7JODI3hEy
	90XzJOJvIcS9MrvIahbTi+XqSzbtimET92ad4YrzQia8pKdKLDd9K+qN6VdxNHYy0sGUUoUbck4
	hAtex92FqVFv38mqIBpKcOMXuyjOw5lYqSm/QwhMp5AwO9gdL1zDpLOLUmebjcuxDXTk89qrWJv
	5eC1jBf8wv+80NjABT2nSvkybVj
X-Received: by 2002:a05:600c:e557:20b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-493f88d2f66mr125124155e9.16.1784118995937;
        Wed, 15 Jul 2026 05:36:35 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c599049sm44497075e9.0.2026.07.15.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:36:35 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed-g6: add pcie-lpc and pcie-kcs4
Date: Wed, 15 Jul 2026 12:34:18 +0000
Message-ID: <de49f2032f5b1f170161dcd6191c0daa48f0b0c2.1784117715.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
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

Add pcie_lpc node and pcie_kcs4 child to the ast2600 g6 common dtsi.

The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
interface on channel 4. This is a fully KCS-compatible interface
that is exposed over PCIe.

This can be used by the host for IPMI when the PCIe BMC Device is
activated.

While the datasheet provides interrupt numbers for KCS channels 1, 2,
3 and 4 over PCI, not all 4 are described in the "PCIe to LPC Controller"
section. Since only the KCS channel 4 is described, only this channel is
added.

Ordered next to existing lpc node for address ordering.
Use existing "aspeed,ast2600-lpc-v2" compatible string.
The pcie_kcs4 uses existing "aspeed,ast2600-kcs-bmc" compatible as it's a
standard KCS interface.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..ac351f01048f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -658,6 +658,21 @@ ibt: ibt@140 {
 				};
 			};

+			pcie_lpc: pcie-lpc@1e789800 {
+				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
+				reg = <0x1e789800 0x800>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e789800 0x800>;
+
+				pcie_kcs4: pcie-kcs@114 {
+					compatible = "aspeed,ast2600-kcs-bmc";
+					reg = <0x114 0x1>, <0x118 0x1>, <0x11c 0x1>;
+					interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+			};
+
 			sdc: sdc@1e740000 {
 				compatible = "aspeed,ast2600-sd-controller";
 				reg = <0x1e740000 0x100>;

base-commit: 03f906d8f5541e8bb741035981304feceed5993d
--
2.54.0

