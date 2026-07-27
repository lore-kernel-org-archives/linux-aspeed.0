Return-Path: <linux-aspeed+bounces-4577-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90928C531FC
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 07:30:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7qxZ6zRTz2yhb;
	Mon, 27 Jul 2026 17:30:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785137410;
	cv=none; b=lsBA2MI7FBXoLfsovTD0gcZTrgb7xcbL4fOXEEzdh8Q7/1lxSwmt4W1zx8STpl7rROHEGZytTzP5oFHCt1wHwDZgiAK/5a5WkJloz8U5gpDlH25/xSyR+u4mz8D7aivTEStZ9uV4P32rGrmXTaAlkYjTfsA/ERZE5hN6P7Phj8DNjnSf8vJDq9LLqizZO9VvCEGZV+lhrzgw4uZc8e1BGGm52cp3jfXoMjjGc7Elc9maA8D6VWFikX4DZO4UwlG0zsLbQ3/RaPTHcGnxj5YL61DWTBxRt1bQBv3mFkzIFaBiiJmKMvmF8TWdvPmoCciiGgad5n4N1/IiSVE3W36vig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785137410; c=relaxed/relaxed;
	bh=7Ly3YHLnm48uwYiEmyCIsl4iQ3O9RMhr22ExICtid7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxNzamwam0PKuo0xj0ElFRqB7wRcQt8/XBMmlLtVzEBBLM+AsfVLf522pS7XMj6g2Mfp4FM1OvzIrXEfNxWj5x6p4f6J9ANZCfhHVqKmSz6WaaXg2v7/UDTup3fT3kTz1IG7j0YXqJIDozqDLPwiDTJuqLtIWlzzDaqiILktp/Z1yL1109KmsGlNdtAONF9DHZXmqgMemNm4Xukg17cyXYlWJLQVLnga3B5jfQhV1/uYzpAmYvXBHuYuUFsRmp1WI1KiGG3JlY+8QAPhZHImerFG2qWw4cqKne67eBLNhwNIvLx8xUiSZ4pyoL73jPE2EjP/gZfqsJdNof8879pGxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=GoDX1QvS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=GoDX1QvS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7qxZ0Qt3z2yRl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 17:30:09 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4955158f26aso15212415e9.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785137407; x=1785742207; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Ly3YHLnm48uwYiEmyCIsl4iQ3O9RMhr22ExICtid7I=;
        b=GoDX1QvS6ahd2KG8aPNBCgj4sGj0cS1GfZ9MWzf9eNwfVqxxPRfsbPYvHb4KEsgFne
         R6FUOvbuqufpUnNa75bp4PjgYiwA2Re/qi8LkHBnbdewN8pSRn5ZFtv7wFOksVhrw7uW
         9fdWNMkAo7OMoLn08r71c84xWdN8DHoorIV3obmu0xvnW//DKX9Z7dYc5Zk4tNQLJcIQ
         Z2kV+j+7S+OhYtBWsOIZRYOY+qSyBLFvBsgsyulJoChXWqGVUeU9KVImA0sLDdRdXyw1
         sqoLxf1qxWF7bxmw53UHOiU8Q7q2BkuIRGd2b5vphfsleL/B6SLQq4iHOEXlXtzxba4n
         ZhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137407; x=1785742207;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Ly3YHLnm48uwYiEmyCIsl4iQ3O9RMhr22ExICtid7I=;
        b=UOwyS+NoW+/lwmYbKBiCA7kRxs+2Dk4CmGR0xEZYgtCIUcq70YX6v17ANzLrexo5sO
         loFxe0eFehgFf5Cn4A358DP2lv2kAwwkwIklxmDA7ndGny+Kx/rrTN74yqTonLdv7RgY
         S41wiSpHOe7JXVg0v9pG9AaZ49NZCpZc38ixVqt/h6fDsRRSMfs1Xvx2+dDniSNNALtp
         HmfwpGe2BSLblZjeHOE5e6cc32d73STL5OA+uhi92PmPCb+cHZKO15tvL3Yxf4EJ7+8F
         G4A9hPsq75reNRLEaF96wc9KfThnt+rdQAHoiaNPIfq/oFbGjVb19eQuRTmzAN2HFK0T
         EDZg==
X-Forwarded-Encrypted: i=1; AHgh+RqRMseCMfpOJmh6Xf3mF8yYWXiwsE1plQYHXdNpgh97Eq+B504b8i7ABRkbLG4+I14hUY5/dqZt9+0EAag=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1U61JVGO2BDF7h0R50htSIvE/pIxHX+rgZ/ysXgj/j8ATtLRF
	+yRE28iCCGxOG71gknp5XKhYi0hUt7lGyEm/MAB34SExdLm/ItAQQ/yg3U1xUfG3Fkk=
X-Gm-Gg: AR+sD12YqXaYYcHgb/TvNpIquSkLx/aIRafyQZSD+if24sEM6QbrGro0XDCbyS2vVKB
	2BOJ0ATD1i3+Q30Iy810mb6teYLkjDDJPgpOYwYsiPTVpfLf0wEUZwUmn8iGz1MLFn/bNycl/cw
	ExSWRsAtsHbjG1paWs+xHncMsUO8JVrP9WgdUstxqKKKH+Dr7EbkMnoU4wKI//MYsHKWk08izWv
	WQQKeVYO5A8G6IXfsx5LphWDZXQFV/nEGvpH2AENXS0zQWQSmnRhfLZrUT+rP4PxPSnmH+Foc37
	8mSf+C+PL/R46IQuno/M2NPHSSQDRVFD0GrC3Lm0x2Dao+V4bJbJPRKeQu+MXhC2VLvat/+j/5P
	YJW+5U+RUSe4R9Kd08t0T9mvcGWWKbkETSxolU+fBSp4YPJNy1HB+StmLnW3zD4SOcwO+BZ2bcU
	5bUefWDeAMGMuqcLVRT+7dgYrRCurjyOWsQC5SaedTbtZH5bKzHwQZFJzmVpAu/xYDi6R1b5yPR
	gIg3hAblOxIZHHo7Q==
X-Received: by 2002:a05:600c:35d0:b0:493:e79e:da63 with SMTP id 5b1f17b1804b1-496b5708bacmr90013815e9.34.1785137406643;
        Mon, 27 Jul 2026 00:30:06 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee4504sm201823685e9.6.2026.07.27.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:30:06 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corey@minyard.net,
	devicetree@vger.kernel.org
Cc: jammy_huang@aspeedtech.com,
	yc_hsieh@aspeedtech.com,
	openipmi-developer@lists.sourceforge.net,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 2/2] ARM: dts: aspeed-g6: add pcie-kcs4
Date: Mon, 27 Jul 2026 09:27:41 +0200
Message-ID: <1dac6b9ae1565a2265e87537141e46c988d16de3.1785135437.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785135437.git.gregoire.layet@9elements.com>
References: <cover.1785135437.git.gregoire.layet@9elements.com>
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

Add pcie_kcs4 node to the LPC bus in the ast2600 g6 common dtsi.

The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
interface on channel 4. This is a fully KCS-compatible interface
that is exposed over PCIe.

This can be used by the host for IPMI when the PCIe BMC Device is
activated.

While the PCIe to LPC Controller provides KCS channels 1, 2,
3 and 4 over PCI, this patch only adds channel 4.
This needs little adjustment to the driver and provides PCIe BMC Devices,
like the Asus IPMI Expansion Card, the IPMI over PCIe feature.

The pcie_kcs4 uses existing "aspeed,ast2600-kcs-bmc" compatible as it's a
standard KCS interface.

Node placed according to the ascending address ordering.
'dt-check-style --mode strict' reports no issues on added lines, except
'line-length' issues.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..c9d94c25d1ad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -656,6 +656,14 @@ ibt: ibt@140 {
 					clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 					status = "disabled";
 				};
+
+				pcie_kcs4: kcs@914 {
+					compatible = "aspeed,ast2600-kcs-bmc";
+					reg = <0x914 0x1>, <0x918 0x1>, <0x91c 0x1>;
+					interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+
+					status = "disabled";
+				};
 			};

 			sdc: sdc@1e740000 {
--
2.54.0

