Return-Path: <linux-aspeed+bounces-3632-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476D7FCA19E
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Mar 2026 22:56:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVC6j4BTyz30hP;
	Tue, 10 Mar 2026 09:56:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773026986;
	cv=none; b=NoJLP42zCL8Gtmt9xKOoYILdRkFFUB4mw5QWwMdJ1QGXr+EzT2ALLmVsamtSwJI6hCJcJTN9POkJy0kgIs03XBnjNFl/RYg46YRwE26kaycVbeToi8SegiP+R/5Kply0Z+oZAWuvs5kAPZyT4rdRRe4tDWrnakIG4P/Zy8pUS0KNEheyfQww6qMh/+XRFzJ0sM1hQPaox9d9qSfkTUt6zeTDGhnR1lhOcTKJ75OqhlEQH6SVOyydbRjGAwAdcaMUnc+L9qvKc6V6+eISZYOBpDAml98W3EBbX5g1wsgjWAcmlSr39Aj1RjL+bbOWO8E98vw7Dr6+xImdzeyhwnnhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773026986; c=relaxed/relaxed;
	bh=vYUW9AAjYAsnFAXAucRe5jrcfA6RJusAQq56ZnZO7/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUA2jepoLlqoTBjJTweBprP0gifrZrxVVNT6YCdtLz4amWZpBcSUbwtlYGZ4OOVp7V3qXhsjjEGJ/6Kf52RpoNNWhOi9ziQaU6yUwkiCAYVj7jTYiIWY0RYLjTVV+jBzfaqEx7looeQlJuayHpHbKb6nPao+2a/tcbGNP+OOv01l1xDu0vDTvNLPXGWEErlk/1MAxphRUDNiSAewhEUu4Qdo46oTW6xur7BewOu4o7eb6BiK7l/pwajX7EK+6PkkH69cFyJ0+/u2zy04iFlIkyGnL9ga1kYO+EJq+L8ilzrJOTXi0oE+zmM6EdlSX4ToEod/fUWdcU7RuZaHdtoj/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WrGLNQbp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WrGLNQbp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTjDn6vdkz3c9d
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Mar 2026 14:29:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5ECE443827;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36793C2BC87;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773026982;
	bh=COteykeXiz9nP7yZMcSFC+zN7ElCRxjdKlB0bSbry68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WrGLNQbpzqKqSzxyhQmmZMXbHsR+aX+qSVzi2REcqzeT9AJdJk2w2ZO1GdSI62aPc
	 WeAp3PQ43j27gT4eqZG37e7w3KQz6n0Rg2gxZ/hFE4yJUop3SMlQkqlSpXFCbXXuEW
	 lC5qxnjXx6JaiEp6EUEcbe0YHSiMDDnUckiW63lG79S27Es3720q8cOe10AMRDCalW
	 iDoZw6BWN7jvbjp3Xq+ddpiJmz8UiqFUaPU2O7hUTVE1t4o/x+h7GMKFQkGVvZoxVW
	 MDMalBsRAkeqX2P2fR87IZv8YtzpIuUK86wlUxq2JM1ZYHylEXinV4IHJKj4D0TmHg
	 BIJ427iAD1HQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F60EA854C;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Mon, 09 Mar 2026 11:29:27 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: anacapa: Add eeprom device node for
 PRoT module
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-1-45092310e0e6@amd.com>
References: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-0-45092310e0e6@amd.com>
In-Reply-To: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-0-45092310e0e6@amd.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773026981; l=712;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=4aUo+I25yKcWkfZ/hlkVpDZQt+CsSEqAbr9PaSDqHsg=;
 b=3tAsCSbsPpsPhvfGTXlpzgPTJPk7d61OGjUrgblTid5E+Kh1SZMxz/XNk3I6A/r4SM/0xmf6s
 MgaiyyjUEsBAA5/RaDvyLlXQywZtYW5oU5EX5TosmnWHVXjSE5zf2tq
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com

From: Carl Lee <carl.lee@amd.com>

Add eeprom device node for PRot module FRU.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 2cb7bd128d24..680108b00664 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -586,6 +586,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
 	// BSM FRU
 	eeprom@56 {
 		compatible = "atmel,24c64";

-- 
2.34.1



