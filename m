Return-Path: <linux-aspeed+bounces-4211-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E74BCD98CB
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 02:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZq5G40rYz2y1Y;
	Wed, 10 Jun 2026 12:11:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781054450;
	cv=none; b=Lf0oRRLvptwxzKHWgEhLvZnFAwQFPNPgmHYSzjgRGEV/lczPTBlrET07ywuuuRxC7pCWVnIiR8ieufNjRf7wAISkuwrT8/bhlQt4rWJ4Dt3lYCt75TnG1IHHbWTr65bld4+r+Qw1whX7SldyASvrcTcztGpo7IjcHyJ2WK0Cw6ycidCPJeKO/aZ8a5YdMqV4TlGfaKvIFwEMuCn1dXwjz/xMhBo8w9/prAlh6COzNZ3GFhCmIyy3fNy3pnKtJyFhjLoTOEkp2Wx+4ii49UiDk8jUwFAeh6SUXrAVGIjQAJzbZkQv3UZSxhp6SlGULSW5NdRr6zEBmSqWK8DSvWLxow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781054450; c=relaxed/relaxed;
	bh=pUH4vpTTcuqb8I5puK3jULXEG1NkGmpFTMLsVnbq6C8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ASCAS8+UmKrRjT/puVZx0hwWj4MAD8tq3DZTdac+OIND1JmNqeqhZrY6lbM6QBqwiuahuUjgo5QpNT4B5pe3mmz4K6w9HimRUA26ZCkBjlZJVPG0neL413iHn+yZ0eIlUAvInrN7cmh9blf4jiX4wPkamwD/SjhsLkbFY+zAswH2Rn3OYodM5I6UtG04F/WTdyj6rXCYgmj2YuAAR86jyldqZwMYZyZAcA2Sy5MyWYE32FLAIcCIDTRG8zhCXdYK0w6dE50isjbovYCm6ZLtcpKhjaj2ljfmk4SmHb28NyF14u1u+NEL1R/qVfSFaN/lVArWVqvwbECHuJTmDHSQ+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljfnq8aN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ljfnq8aN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZnz53L93z2xjN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 11:20:48 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c86214eead7so1429768a12.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781054447; x=1781659247; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUH4vpTTcuqb8I5puK3jULXEG1NkGmpFTMLsVnbq6C8=;
        b=ljfnq8aNajk/+/ls+HY97YqKcbm2/LwTY51qMI2xgK/KxtDlSUmLOU4BdG9C0LrLEl
         jQ4dfOVziw/2PEZxo3QLO4KppCfsa8ysmqAnOgCA2bnbSP6+ANMzQ97cysNAGhXCKO2p
         1PQqVZ7AX+uxGfbGOmD4vYAJ5IDNafze0HYlz5GLXs1euOlwcVJBIrGiVCHJIYQydkt1
         6TYVvNkJN4g0iu/BojRnipNA6gNEbrqh9vKKfnYsqrCkNVeWe30cMfZaYJCjUHwY2kUs
         0cHVoCDlHZOTmNQU+arD6pXZQhwdCJcDWVf3om92U+BzGR/YJp9/rc84Mk8lFhe9jDM6
         1dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781054447; x=1781659247;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUH4vpTTcuqb8I5puK3jULXEG1NkGmpFTMLsVnbq6C8=;
        b=Nigma56znc0vIq7H8o7AW+8esxvYt3+Ztz35KvKGtTptIumcrlHje6WPYNbzJx/OmB
         aNCZqNIAPXOYesMihWHNyKoF2ulcfrUaTOwnMy/k6+raXBRUJoIjVe7iIG9hDqFJ+UOa
         aH98SVb4a0RkO2KwQTX4hOePF3teNOFAsc+tUshO3kILWWvSbIBjSGDiqTas8gb25+KM
         2LtvaMRdGtn1B/YzZ9Wqpq7FAtfS0WiUOSmwrRQexyoW71+206yOsuL5hxwxFcgP7Dhf
         g4P8ErqeCn1p+8G8bUQghVRj/AjgmSi9OMFFri/zL5yNRrtel6RpYLHQzjqt73FkO50g
         qxcw==
X-Forwarded-Encrypted: i=1; AFNElJ+tEQvZI1Vldxc5BaGNlANnrhhJD1a7um5dfWrb7sBovEyl7GPVTgpGAp5NkQntaFFxMu0MfK7cnnmFFYw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnHYrexuWWX2G4Lmb3AuCrFzGnXQUFK3Y+n6Rc23fKWii7lfKF
	yKifxGzaRdKbmDoXXUHImJlGSYLs52cJEt7CjJQyNk0mV90vDNAsSZP7
X-Gm-Gg: Acq92OFpplYwrh+7REN6EGesxTWVihW0czMwBmtBC0SNWMhcLaZFnQRqtEmRM871j8V
	bp1Hm7hlia9mJbNjFUIDPPE9j/LwbA1EKDvJ4ubEelJKemGR3yESUCxLGQTyrj6g0nRvIQYobRx
	NnPQ2Z8AbyLrUFvhYgsQThXHHiTyoEa79L/5lXlGEtW6uv84PIkNXHlHNRwR7Gq2mM3VcYoTStM
	m/RsjPWIMZj6vMI5CG+IKbVhwHCmWKR5RklWmdOndsuzHHiHAewJIsbpyHaS5ttyQKTZ8c8iy3a
	TO7QIc8y+jXr2pcIko2rSn0pzRBhfj5xDkU6vjFPwTzjj5jY8B05fa0toCP/i3sCia3CMnQaBun
	7b4boYXyP5mObVIVuGyqNoyIDGoPYKaK6IKG45PUKgZlq+DeaXFoChINctrrg16bz4f8WJFChcW
	/kbZTizVKwVgRIXOCO7FuNBjJ+0EIl50ugGGOnCXPri9h5ENXNM52oMrYb8eQME0bE1dQ7E1LtH
	Q==
X-Received: by 2002:a05:6a20:244c:b0:3b3:6db1:5986 with SMTP id adf61e73a8af0-3b4d3d5e346mr19126727637.30.1781054446615;
        Tue, 09 Jun 2026 18:20:46 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm18858370a12.24.2026.06.09.18.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:20:45 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v6 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Wed, 10 Jun 2026 09:22:21 +0800
Message-Id: <20260610-ventura2_initial_dts-v6-0-375d8e9d7ebf@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAE28KGoC/4XOwWoDIRCA4VcJnmvRUcfdnvoeJQRdNRlIdotup
 CXsu9cESkLK0uM/MN/MhZWYKRb2trmwHCsVmsYW+LJhw8GN+8gptGYgwEgA4DWO8zk72NFIM7n
 jLsyF96L3CqwNiIa11c8cE33d2I9t6wOVecrftytVXqf/gFVywWUSKBEH2zn1vj85Or4O04ldw
 QqPiF5BoCFJ9so7E7SwfxD1i6CQUq0gqiEQfAoOnfHaPiP6jujVT3RDOoFeiOi0kvoZMXcERbe
 CmIYoG6PxQzKdx0dkWZYfJ2EQ1swBAAA=
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=8Jq4+7GVcOBKAyUmh61mLdl1eJHUvEKS8qVvLj4xWJU=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqKLxQz5qAfvzO4jxu9b6YJUKWGKm/aRg5aCp8u
 B24zB0LZ3iJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaii8UAAKCRClg0K3CVbE
 gXYOCADIiQLAI8zfQcQ9SBWy51b1ync2ztOKHBSaZME7sVhPCmByKYs8LY3CDzTSVlLjgf4+07P
 0dejRle1qw/DTXvsWMNy1XKmjAK8RxF6OvS7xY8nKJpefUv25ljPLNhIxo/tbDBMlC1Lgk3eoyV
 9+TL/dpe1mYVCLQ+gSy7tav9nxr9lorGts1jZ7fQHN5l/qDIwQlO9+LyEVTE5y7TYdR2c5gDLg0
 mlyfNzrGq71+yok6pbaJUrvLxoOiioP9NoXCLhlsXx1bxR0ftMQUTmotM7p0+04DPevQ1D4c3gn
 AiJGC9aObJLixyOcBY1unRxYKQzQDGNaFD5VZF0Nf3sGsQ0h
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v6:
- Addressed automated feedback from Sashiko bot:
  * Clarified comments that io_expander0 and io_expander8 physically share the same interrupt line (Wired-OR) by hardware design.
  * Removed leading zeros from unit addresses in DAC nodes (dac@c, dac@e, dac@f).
  * Removed unused properties from the adc@48 node.
- Link to v5: https://lore.kernel.org/r/20260608-ventura2_initial_dts-v5-0-37ee5bcf58b6@gmail.com

Changes in v5:
- Addressed review comments:
  * Added comments explaining the necessity of 'legacy_' prefixes (hardware label collision), pre-allocated I2C aliases (future expansions), and the 'ledd1' naming convention (schematic alignment).
  * Removed the empty `&mdio0` node to comply with upstream networking subsystem guidelines.
  * Removed the redundant `&peci0` node.
  * Sorted `&kcs3` and `&lpc_ctrl` nodes in strict alphabetical order.
- Hardware/DT alignment updates:
  * Removed unpopulated sensors (adi,adt7461, infineon,tda38640, ti,ina230, ti,ina238) to accurately reflect the current board population.
  * Added the secondary flash node (flash@1 labeled "e810") under the &spi2 bus.
- Link to v4: https://lore.kernel.org/r/20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com

Changes in v4:
- Fixed capitalization: "ventura2" -> "Ventura2".
- Reordered I2C child nodes in ascending order of unit addresses.
- Enable PECI, LPC control, and KCS3 interfaces for host communication.
- Configure MCTP controller on I2C4 and enable MCTP support for specific mux channels.
- Add Infineon TDA38640 and TI INA230 power monitor nodes.
- GPIO and Pinmux cleanup for PVT:
    - Aligned gpio-line-names as requested.
    - Remove unused or non-existent GPIO line names to align with Ventura2 PVT.
    - Update specific GPIO pins to empty strings where signals were removed or consolidated.
- Adjust SGPIOM frequency to 200kHz and update signal line names.
- Enable UART3 and add serial2 alias.
- Link to v3: https://lore.kernel.org/r/20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com

Changes in v3:
- Add annotation for marvel 88e6393x
- Modify the gpio-line-name
- Modify the node order alphabetically
- Modify dt-bindings document for rmc instead of bmc
- Move the gpio-line-names to original node
- Link to v2: https://lore.kernel.org/r/20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com

Changes in v2:
- Remove unused mdio
- Link to v1: https://lore.kernel.org/r/20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: arm: aspeed: add Meta ventura2 board
      ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2891 ++++++++++++++++++++
 3 files changed, 2893 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


