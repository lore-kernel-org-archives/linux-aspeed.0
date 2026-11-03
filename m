Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A6606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=AuN1mweB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0nt2tyyz2xSZ;
	Wed, 04 Nov 2026 07:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.25.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793738434;
	cv=none; b=i+HEWild38dHbMUpzEH2FdOHwjy8Jjyjn/Orw+oWfvXfeGRxbvN0muWCwE4rU+lZtnhEZVI7IaeYChTg8imo7RWEOI5S1VVvButKkYFPQeAuwqt5uKN7jmbfIiaJHG9cu8YYdIDORmzjIx77LRu81VrxUOpuFvJvzSBi1hnK1XcEbONKzbxDUc3Oi/m3xNLa7+7KGCR/RuXgz8finOsQk582DQoKCo9meBNWPCG+1sOurFNZMH+KWlL9fvYSKPBUgiSdneKgfAXBfV1fOJGS8d5lgHArTYu9CP0lQP5SFrk+F4dzwTJODk4g4CmnJ4jQfAY34ONPqnxG7D4FWV2nIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793738434; c=relaxed/relaxed;
	bh=sjUVdGPpRThFzw+FQF/UnfYCE/2vePJvLFuHafbyQjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRa0luEvBLkjfrYg/vPs740T9lpfFwImoOe92QZsGAoejojC+isx7c5PXuEDyRNmZV5jTc5oKVPbRRBMxPVi0TxQx6vZCaV69Z8kT8xQauwUWv3yH8+cOkqg/mjGiMXoOIB3YcfirDBh8956BMPDwyfPgZD56RU06/o3WQoyWyzppVo4HTNqdV5tazl45L/n/hg+RVmkM6EZOKoGK5AlC0zOmyXMji7KMjA+Ak2qQGWZspdS1YNKmzfUcbE7CFpXy1h+EH4l4x9GKEIv6//YGSUa55tpz+4xMev9vm7EDYIyK30iG0VohwZobzEPBaxlGI/3UtG0XQwwaROVVNskzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=AuN1mweB; dkim-atps=neutral; spf=pass (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org) smtp.mailfrom=rnplus.nl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rnplus.nl header.i=@rnplus.nl header.a=rsa-sha256 header.s=dkim header.b=AuN1mweB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rnplus.nl (client-ip=178.251.25.70; helo=mail.rnplus.nl; envelope-from=renze@rnplus.nl; receiver=lists.ozlabs.org)
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK0nn3QRwz2xjP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 07:40:28 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 3839A37963A
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Nov 2026 20:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yb00l9HLF6wL for <linux-aspeed@lists.ozlabs.org>;
	Tue,  3 Nov 2026 21:33:45 +0100 (CET)
Received: from E595 (unknown [185.10.157.158])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 39F5D379778;
	Tue,  3 Nov 2026 21:33:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1793738021; bh=wpaK3xlqbSy7BwAovXZxHl0KmlkJ7DTAtEtWwvx+axY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AuN1mweBZv9JootaBzdqVRAZ/Om8mJXHR958XTAd+PULHJt+HCJeSpSt1YajYhV2h
	 VAflSQKXHqyu6Ycur0aJVXHSLmoSw/hGACXo05pMP3QHJNzX9E22lrU0mCcEbc9gFR
	 z1BYcz6rIdWCMgSDe4Wg0lLYoHYFLQ0aKMO0bFhM=
From: Renze Nicolai <renze@rnplus.nl>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Renze Nicolai <renze@rnplus.nl>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: aspeed: x570d4u: Remove w83773g temperature sensor
Date: Tue,  3 Nov 2026 21:33:02 +0100
Message-ID: <20261103203308.54789-2-renze@rnplus.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203308.54789-1-renze@rnplus.nl>
References: <20261103203308.54789-1-renze@rnplus.nl>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The w83773g temperature sensor is only available on variants
of the X570D4U with 10GBit ethernet and should only be loaded
after checking the board variant information in the FRU EEPROM.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index e61a6cb43438..7d27833b761d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -164,11 +164,6 @@ &i2c0 {
 &i2c1 {
 	/* Hardware monitoring SMBus */
 	status = "okay";
-
-	w83773g@4c {
-		compatible = "nuvoton,w83773g";
-		reg = <0x4c>;
-	};
 };
 
 &i2c2 {
-- 
2.56.0


