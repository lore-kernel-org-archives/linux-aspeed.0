Return-Path: <linux-aspeed+bounces-4538-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01B2C4453C
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 15:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4yVv27Bgz2ydn;
	Thu, 23 Jul 2026 01:15:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784733335;
	cv=none; b=B+YxPbb542ESbxM+BBZliLEahXR1vob1WTerYQ8vQ10+dhCYUOANzFCNtOCAv7hOg8qts880mnZqWkiGtAKN2qkleBrpFFUIookyhfjEKyM59hQgvcaGQHawVWkI5bQ+pV30Vrnl1ypqupaekCk1GgXJDzYW5APvQz1XMNt272MaG0Zw6r0hzeVAZVqu7lj3xHayDnTZSX2EjlwC+Xwq81fexDFkYbEEbNBqvNa/mDOrgKckwrpAOj8ehYEQas98LQX85IznKrRnQ5wV6TY15AOn/cX2xRu8/7vjry9eBTmDSHPO2EzScUFFw2ug0BZIbgIESRtfx0Su6T/Rix8lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784733335; c=relaxed/relaxed;
	bh=zvXtHoyutTzc9UQI/R1yf3uc5dETK64DOW+MCP8cwFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd3UZb8Vlr0vExLBLcio3Z3aCGNWoRgohWcVFCLGGuDKvfLWfXZhtfUN19miHKtYyDbN//Qa+DUzvG/uxYiwgofB8BAcwSbFY8D2oPJqCC65h8BSddKuZV/eKEDhnpHwHzr5UxpnUUsgBzAVDV7xklC8EhOok9pAHlJ9JWrff2lEy0zvh4mew64lHH6h1vfwqBzzYUaHOJHiURwBHvbrft/Grl0dyYn4oZXF9gGD9IWp2/7413DTiyqG20EkQcGWkIkS31tGQ9G8P+AzQNpM0ghvMFOkLgUrM/9y4EhYeLeVhcqAWpIQxawYdyRKkc62urm/8tWV5rT32dF9ZDll/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=hGsdNpnm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=hGsdNpnm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4yVt3yDhz2yFK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 01:15:34 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-49550ec592cso22401715e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784733331; x=1785338131; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zvXtHoyutTzc9UQI/R1yf3uc5dETK64DOW+MCP8cwFs=;
        b=hGsdNpnmDTspeg3Jfci8wdgbG+O1TY1O+imlm1TkCnicLjjrwfXz8ZDxq74zaUKSSR
         AOBvN2tyiitQfCFXyMDmGUoIzY/fKW9/899jgt5gFlquR3aIK46szWgAoPpfUBG7l+9v
         lumSjxLGaxurk5suXCvwfzU4JdFixRQ/VegkyFjTn21WC8v8iQ2nlwneZ5Lv5cpbTmvI
         Z3UmV6YHkhG8LTWtjGwhkizRCijsctME2E7cj2X3ET6g4hFZye1MnPJi1LTcryT64g+1
         5pTkyf2/YEkkKFormtbEYiniQGlsfhBLY5vzdCn1UsRy18GsxNORtbfiFX/YnkruHV6X
         Gibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733331; x=1785338131;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvXtHoyutTzc9UQI/R1yf3uc5dETK64DOW+MCP8cwFs=;
        b=WdItwtbh4zktlztw/dwGJrWAGEp3lJH2XUml9soEjwfzRh5O/4qVPSiSpCGJ1Y/k5y
         zGW0BEg/MLKOtXpz0Rl5wMSCEdQTl2wUFxonCyoz5lczurhbUAKLg+6WIa4pNtUaj1hS
         0acOpvnSLVbEam8pX7BbB8yRz7t76eyiZaccVZl1njkvHhoFlKhg97b+QOj/ARNbh3Og
         vgMzDD4AlQV3B90TyvruXDFtzkUOumG36O4tCzbyBtCaFuHz4hk6QLzH2P/wXsCH5zZm
         Tm+hdkW7rfr6bMuiqIfyFZKhI6eu7/YyH/3afokHwoIJFFAKrD1yPXxHhuwIJ7CRx9Uh
         Rhwg==
X-Forwarded-Encrypted: i=1; AHgh+RqXF/dj20Nepg4io7eaI4SQX7EM3ybJu0JBeqMElP6g06Qg6D7+QauFp18hHEDdZmJfXgrxem5g9rPD2Ow=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxQfKBOkb/+NNfHYaCzf7TQcFhV0w6wvcClzLZd28AU3dKCcoc1
	IB7lOWcJBiq6R79YBp8S+9hzk363N/J7uHJqFy2gFRjcdaQEMK2s/E6CyDznqy4ML6s=
X-Gm-Gg: AR+sD13D9zKR5/FA3YV54AM1W8fnpg79EQLVjJZZ41rYgo1zTkPEJy5fPLFATfakF96
	NHg87NfhK2MSMng6scp7H0PbverArH9deZoHgDtNtbS1CRxHKqC70Wpdqj4EeIgyU0gUvMA3jJN
	ed0rNcba8H3/uQUNbJfTper0SowqNaac7FNxLxKrOeF7qHoqtKdxuMWj9Ye1Go0fYs5Zfi3cSfO
	4aewKXbj8xd6vF4yW6zH7cJKpiV4FRqH0ybdjDzJ/g8uAWMoIEBXIBT0dUh82qhQa80Os5nIK1o
	WE1izSrwH/CHogBBg8P1yh+ALXUxQBzXhorwSOFUHaPK+okbYxh8ZiAYJEqWYKfma3k2v1fyeKu
	a4jj+LER8eQPiP1sh0ZtpxCuckFmjtxKwXAcW/mOfKk+/qk6NZ1JaXfiDujoegFikeU5d5Er9+p
	CVQPUj98iiwXoXwajjjdG08ahiwraP+VxkyvpB110WDjmdNFTcmYs/+tqu95aO5yKJEOsr5ZubC
	4I4H6ckF8EbmxmOsg==
X-Received: by 2002:a05:600c:548a:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-4956a4ef5d1mr47012145e9.6.1784733331147;
        Wed, 22 Jul 2026 08:15:31 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a500dbfsm70595615e9.6.2026.07.22.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:15:30 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corey@minyard.net,
	devicetree@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v2 2/2] ARM: dts: aspeed-g6: add pcie-kcs4
Date: Wed, 22 Jul 2026 15:11:58 +0000
Message-ID: <0b97a66762efc05c9073c14112cc489624871947.1784732161.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1784732161.git.gregoire.layet@9elements.com>
References: <cover.1784732161.git.gregoire.layet@9elements.com>
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

While the datasheet provides interrupt numbers for KCS channels 1, 2,
3 and 4 over PCI, not all 4 are described in the "PCIe to LPC Controller"
section. Since only the KCS channel 4 is described, only this channel is
added.

The pcie_kcs4 uses existing "aspeed,ast2600-kcs-bmc" compatible as it's a
standard KCS interface.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..a93fa4cf5d8f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -617,6 +617,13 @@ kcs4: kcs@114 {
 					status = "disabled";
 				};
 
+				pcie_kcs4: kcs@914 {
+					compatible = "aspeed,ast2600-kcs-bmc";
+					reg = <0x914 0x1>, <0x918 0x1>, <0x91c 0x1>;
+					interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
 				lpc_ctrl: lpc-ctrl@80 {
 					compatible = "aspeed,ast2600-lpc-ctrl";
 					reg = <0x80 0x80>;
-- 
2.54.0


