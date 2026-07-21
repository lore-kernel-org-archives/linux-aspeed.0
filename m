Return-Path: <linux-aspeed+bounces-4513-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA85C4451C
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Jul 2026 11:04:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4DzT3xL9z2xqJ;
	Tue, 21 Jul 2026 21:04:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784631861;
	cv=none; b=cQKXamHgcv7eZs5kcBkcTadiEc3wezxyh+mNn5JzQy/IdZQmfKFUANMJGJzxTHGFkdwt+7yBoPWiWW4kOjeQ8eO3Ptl5+r5fNkd910eSBrhSm75vzcPVU+PGMcAIV+gq5KObSJ7+sNwJHdaP5o5bXPN1aMkEuPNumbiNXYX9vBnJpt/C2xSp/fs9fYZ3ha2N7xSYKaGFThIaSjsq/5W4bhEtN6xaDrvomoD6yEIZWl6yNd83dFyN57Dg74L75PAtFXYsA9Blj+mCLx4B6vdOScQ/e2WmuqFQ+h3NR+UdeeydzsDfvggJryCcxBFEDVDQTRztWpV0pFp5kI8snYHMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784631861; c=relaxed/relaxed;
	bh=XNgGUgLDxikpwQAtd9a8q8cPJ0Sn1o/cujVuEUBlzWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y/nxwXGG1J4FimGS45hGMhTc9QOTSvG6Ty1Cwe1TJOoEojJICZgZSn3ITLn3oCPT+Ne2zy5Exs7jZbTaqUueX1LIjm7YUSWSEGHXetf4A9Q+aQx8SZEprf5uuGJycuVljHdyao1ofZr/T5PqwoW65KANI09dPaun2KILRADnJyJ82w4Vwo8+P7HkXdPuACX+79LqONX5Xiskw7UrPywTouzuBwwj+0fhDgkyu3XKtjhtNApiURLY7zrnvdq1sraDIIplTOg43GXzI5Znk8X9XblB8E2HMus1ppXA1XKeG+Va+0vQG4Cusj4lipvd/i2DX6VW5rKQgmGOnHIiRMyYwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G+uaLJPR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G+uaLJPR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4DzR6KTrz2xm3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Jul 2026 21:04:18 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ceae1ed204so91463845ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Jul 2026 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784631856; x=1785236656; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XNgGUgLDxikpwQAtd9a8q8cPJ0Sn1o/cujVuEUBlzWc=;
        b=G+uaLJPR1ztvh8AsKPowZCvPwlzIeOjsjBsEigowjuTW/zboJe+yskr58WRC5RuT22
         tHFk5bwEUhmbim3OoVuSpnRy5XlAmafH/BGK3eEdRhIfEidcjqNOxwUnjcCklEFCpWZF
         WJrjRnXQ6uuOabrTI4E0UU5f7XKZ+e5aSykK7W0tN2u/bWXHUSI+AMjTof8orc6ImYyg
         666OLtEqGa3CVhXiU9zuyBsXCBWa7sOF6Imotx/8shvv1kxZerrqsa+YwWAQ7BLJF+a1
         K/ZIAISa6qYGWXcdGFPibOuMU8O15HaUeSoSqVkVKrNAmgip7bN9KxmgV9MVCCN1VDf2
         I28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784631856; x=1785236656;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XNgGUgLDxikpwQAtd9a8q8cPJ0Sn1o/cujVuEUBlzWc=;
        b=eBd3nu+GVGupWt2dPc1OZn+P8R41dwW/qAJy0LDcEX+v6OHtJWLoZbA51WegVgJLfw
         xYz673nuzzdIK2T8cDbEAYGJek9Lqf+iKnvgE+YigQeCdtC/LH9Kh9HuVJMXS5wx3mwW
         grYXzkNjobNTOz9wy+Wdsv0phQs50A0iy/YBlBb/QlTpKNMIjssQc9gjnCypyZvvqDJB
         UMfK7pV5O6CcK52cPC4VlKNQ473i3QF4DPP3dzj3/hrT2yh6NkszQscLHH5jA1JxU3um
         HHAzcgW6VdNjZ7xFs4ZEu+Dl/lgeVjdlPcLSN8XRG/inayVet4xmQOhcX3ZHrmH0xKEQ
         zcGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZO+Xnll6a4tXkRbpKmBdoWJzX25CZZvHdURDGy6ZQ3cOZKsgDqFyR3Tg87JH6SuEjUfG/szKr0g89ZKM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzgpu7uzMIcMZsUC5zssxN+WX4P/n0LNlJOIXvdMhRhTbvtVSGS
	WzaJa27MpYibakrk+iMLu+hWLMDHlD6EuO+Ydylv3cUPwWS6f7ueRVyu
X-Gm-Gg: AR+sD12C0bSlNTOZ4116s8xTIOTofod1KwdF9j88nDS4tLzFOVzftLL10hFuOPY0Y3y
	L+F5xwh2dRKACf32JQ6QjvzCIhBPdxTScI7+bqBqQGVaBMLut+ZSkQKf3LxQ6Tt4LUytN7dzzaF
	F9uaGjwBxC1vhP28GfnvsOmCZgkLOFmYrRWziYhar+9uv00rziuH2md4YhDUhvxHAWYokI5Gv68
	8Ebp2wK2Gwd0YCbaWR11Xysb9hdqQrjVvMjXWTzE7taUJ2YHyw2gfGafq8qi4GxvHp7aUoexg7S
	E60yA5Xnac8TYh0kpUhwVb8qd5Mi+c5XOjlS07BiT2YZwo5DSfmY8sTJy2sYnonlT0szUm6DwmY
	YXIdqIYvykhfb7lc1+bmqosVgvvYUA9IPlHCgtgUTl9IaptCaRC35r9yzv5p5ZouNQk3jbzYGhG
	/xa2AbffO96TI8kqkqbPT0xg32fBKMEBvSUv92ry9ZMyhL
X-Received: by 2002:a17:902:fc8e:b0:2cc:ed57:c7c with SMTP id d9443c01a7336-2cf349cc532mr198004405ad.32.1784631855821;
        Tue, 21 Jul 2026 04:04:15 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3474d305sm72786705ad.72.2026.07.21.04.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:04:15 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 21 Jul 2026 19:01:59 +0800
Subject: [PATCH] ARM: dts: aspeed: sanmiguel: Fix FIO IOEXP interrupt pin
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
Message-Id: <20260721-upstream-sanmiguel-fix-fio-ioexp-intr-v1-1-8245ae0ca590@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKZRX2oC/yWNywrCMBBFf6XM2oEkvoq/Ii7SOK0jNgkziRRK/
 92oi7s4cDlnBSVhUrh0Kwi9WTnFBnbXQXj4OBHyvTE4407m7CzWrEXIz6g+zjxVeuHIS1tCTrR
 k5FgE7dj3JviDPe4HaK4s1F6/zvX2Z63Dk0L5ymHbPs7MizKJAAAA
X-Change-ID: 20260721-upstream-sanmiguel-fix-fio-ioexp-intr-1f880ca4153b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784631851; l=1256;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=ZreoL/eVPuxj1oFb8/Qv2Bu+o3zQrHOp7wcZG/PkziY=;
 b=ojdm2efXwuf3QR3Gotk4btNOvBBhEIendW+qye+msS8NzhLD/ZFY6O23pbkZ1cIBBArxCA358
 7PntNXICI09CwO2hXZ8mKVYo8qzOH5Y2iXsiLLMWF5Wy7Tx7oAEFEO5
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

The interrupt properties for fio_ioexp (pca9555 on i2c14) were incorrectly
configured to gpio1 with ASPEED_GPIO(B, 6).

Update the interrupt-parent to gpio0 and the interrupt pin to
ASPEED_GPIO(C, 6) according to the hardware specification.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index d7ed497d7227..cb07c3615279 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -578,8 +578,8 @@ fio_ioexp: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(C, 6) IRQ_TYPE_LEVEL_LOW>;
 
 		gpio-line-names =
 			"", "", "", "",

---
base-commit: adcf44809e1da6f462927203b008e4cdb2ee1b34
change-id: 20260721-upstream-sanmiguel-fix-fio-ioexp-intr-1f880ca4153b

Best regards,
--  
Potin Lai <potin.lai.pt@gmail.com>


