Return-Path: <linux-aspeed+bounces-4283-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55A2CDB479
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Jun 2026 23:53:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glMNP0jvNz2yRC;
	Wed, 24 Jun 2026 09:53:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782225006;
	cv=none; b=jxwlTSHZH06e12DrmxZqaeyXajdAZabW2OC9htBzazvx0mC6nsrivVF8NY8QFo9n5f/AClcFYQy68YgzHKjLZr7m2fh0+mTZAI5YZ9EJe5Iho+M036l3JPW7DsBb5wGctFcC9MYrsK9aPyQvAedX2U2FHZZtDPwdaFscvE7a3n/HHkJR0RK6B2/ghshY2IUyp8TlxwVZ9k58824WqeSzqidXISQpZ3iCOocNYY4afcH8k7+JLsD1YPcqShAUDQuzWT0/72s/pJe2uXevGtV7BTkpV1wBLJ0p2ZK6e9KAyOVg213bhTjH+RVstVSqlTPacSil426/QM5HYehlmxM8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782225006; c=relaxed/relaxed;
	bh=E7ygF1/JVCediAjvQA9d7z/Koai/OFw+MbowQK5OiLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeSjAk+vhp2eZSX6qFkgp1YuL8j6KEGHnhzRiBGU6qTBREjWgvz3tqs+BAdd4aVRHNWRuXwyHmUSdAF8o4cuO7oDtAPW/BdmX1iYmdA+a0rPQH4Pz5WQDRd8VP0brusIFTGt7Ck2negtNmGWEMgsYkShUgLgz2f4nFO38rO0zPSCP0KoNBNvR/FtQbBYawIcPa8Rogkvppf4k//FbZIXed1f5EOAxHtSRi4v/QWeBBI3EeX6qNJNDpQBjsVKEj1lptKe/tyU3ONzQjyGeyH24wszsroPmySEHFZFZ7mh7xWAzruQM1hm8hG2aiioNEYFl+RFJyk1mPoehuKoZn8c2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Vj3FgUL9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Vj3FgUL9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6sn1BNQz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 00:30:05 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-490b613a17bso47854075e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Jun 2026 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782225002; x=1782829802; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7ygF1/JVCediAjvQA9d7z/Koai/OFw+MbowQK5OiLM=;
        b=Vj3FgUL9ybBwDLwMSavvZFGhkyPgOAKHrq97UNHZAlWsxg2HEMWGPZ0sQEgQOjUe1t
         3LiokwYynMte45E2nj4NMZxD3991IJAUTPLIsCNjhS9BQOkdHV13gGk+xbtMWhE1U//8
         Ky+HImrKzGe9YIXm5OgQdFnlx8d9KAdgWlVjyoNaP35aq5mFQDMm+YyZ3iTW/H3Llxn9
         EaYaTzCIb/i9OdCVJUqwMs5k9OMnjCt+HXlaTLnpBLytcHGbKFaHSjIz5xXOnTmVjGUA
         q5v/9nfDUOMcV8+WI8nyCdtPVCnlOSpmHvM/XtO7tKun2R9DlcE5MiJAVDS0q3yV1Ldz
         13pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225002; x=1782829802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7ygF1/JVCediAjvQA9d7z/Koai/OFw+MbowQK5OiLM=;
        b=Zse7PLbIqDwpYFXUxCXIviPa3QSpJ2BlmfVF85CCcLzrcxxQXRXWktYn7Axlqa3nSE
         6Q1IkoOr+3jXJqd84nDN4wd68CGoLiSPxPTlxSFaEXTab3EHOVc0Oam3kJ9iwN14jmU4
         4C4TOTLUiPOSohQCknc9zY+iO7cJR2jzmELDc7J/Bi+euF3CGWIXMHBBspL7uv85IQPC
         OhpPZi1cusmx7eUPWjzmLRAOLIPDUGsjslgyB8Pwsk0PrsF+SWfqUWtDktr2igjSQ7N5
         yWeZl9GH4pxNAEtYc7wmQo4XIEbOvbQUu0UKinDq6RieWDZM3ec9TFBUdsiyZr4UA5xn
         rrrg==
X-Forwarded-Encrypted: i=1; AFNElJ/PxBP3dYAuZ+Ieh2dDGyCuQ7DXY4I8cSIy2VNdhIbdNMBkC3WW0VfvdG4V+pGvQ56q1NxL/1+dUOEJb5s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKN00eMQ/6ZhH5AWz3JUeirIrQ7JQg2shLz3TKrUaHKS6G+kMK
	yxogvWE/KmL6xOnE3lSAehhbOcxeqTdAGVGbc4LLSpNrbj6TInVggHyqoVvn7VuXpKY=
X-Gm-Gg: AfdE7cnp5aLTm1lR1XyM4wx0S74HqaLcoZkUsMn/qK0WwMGwtVyPUnuENXmC5aVW928
	zfHhCVJhTXr43Eny0UA3r6ToGk1gcDA1wHmdlg+h/cTeWbAbhNmmu/Zbk2W5pjs9+uvO0pm0MiS
	LvNylizrwniCilhPlbuMVifvzJ1oYH5PCjl0BUlE3mshiqT+1Q7HsjUOp7STyoVh2W30sMZ1KGu
	MXdwbhE1n7wicBkBuGfzdifDy1t+nRnLBRH550Zf+3i2Gn1MbfV0pC9p4tqxp2hMa243+Uz/XfW
	WaDv/hjXRN74yAPId4wIpcqzem/HOCk9PkoCQxePkG+7ZpcykbP70KRV9i0YMUjtucM/V3YIMA5
	jyJPunERBsAsRZRdAIATMUZPcsE+5HmRk6GmZzCGXzf3o7yeHMD2BqrDcxK3H9D97k/2FG4E+iA
	PuIT5bpyYr3Ba3lw6/5F6RdUuh4VIMGbrAyb3EUVHT2Ssn/tR6XOcVBZTZ3PQL8j8Fd1RUB3UbJ
	Abb9LsFN5+nT15jsOl5xXk7ZMbw
X-Received: by 2002:a05:600c:4691:b0:490:b9c3:6c48 with SMTP id 5b1f17b1804b1-492490af5cdmr215448425e9.29.1782225001894;
        Tue, 23 Jun 2026 07:30:01 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:30:01 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 7/7] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4
Date: Tue, 23 Jun 2026 14:25:45 +0000
Message-ID: <86fc0b2a105a16ceb301ba53fadd096877455bb8.1782224060.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
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
This flag indicates this information.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 7c02633f2bd6..2a19463b4c21 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -723,6 +723,7 @@ vuart3: serial@1e787800 {
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
@@ -743,6 +744,7 @@ vuart4: serial@1e788800 {
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
-- 
2.54.0


