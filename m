Return-Path: <linux-aspeed+bounces-1610-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A95FC83013
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 05:04:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX79W1Rlpz30LS;
	Wed,  2 Jul 2025 15:04:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751432671;
	cv=none; b=GP9azKlA8GCVTIDlNABA1z1X3Qc95PnYcv01GhxQbZoHunYThM3cNFZyhWNdT60JtKcrbbuDfaHSTdv0lVnRo6np5zGYZ2Ag0y2C8MwHWbg44t59vtiBlIuALDoebHa3/UIe6wVyq90rWqHcmO2DwKVGeWWrAD9FnLfHPYZukgGPCt8sQZ3an6jC+EYfrGpjJnCJu0QY3BcrVVYWWCz6POSP33oSRXFjm1l4XRNyn4EZ4OiH20lW49PeXbQYxu2J+jj9wdatn+rTtyagu0BLz1TXyMmVIy9ySNFF0TuXqSM3S9m/7qpD/508BW68srSJ7wZbrY+lnTbcPxRpfx2FjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751432671; c=relaxed/relaxed;
	bh=EG55DPXz8+xtKpQRKekjwgyGLv4dODZAuNPTQZ9Shzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQbGtK9xebTAEI8z1Zs8G2+AKlRPZGWb6wlFNNKteu4fdOVJjRCkfCBiLf62V0+Vi474oE238bcBxs1P2Lk712XRed7pZqtHI0NWi000Hh1eflqgm4fhf3x2CygjC3e2fYaJ/omOuYAaki3P+onyNY6+jAfF6+67IxmCwtzv5QeFlVB83lWVT7IXifpYZJmx9nOGUKnYzooSMd6p5+ynKt4fvpZQsc0BDkYF/wkXxan6KK8L0dJC3EC8t0irC32j+oOMfQV7EboqdyphULu+lilpyqYc9cskcUw3lVYVkHr7cVx60AIAPpLPaMP+AW2U1Ldbw00KTjd2ASoag2xMNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lq8ZBRak; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lq8ZBRak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX79T71SRz305n
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 15:04:28 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-b321bd36a41so3539338a12.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Jul 2025 22:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751432665; x=1752037465; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EG55DPXz8+xtKpQRKekjwgyGLv4dODZAuNPTQZ9Shzg=;
        b=Lq8ZBRakcJFCTA/RgYJS+K3MeckJGQnergiao4nPEICz62TPmigR1lt9ZYQNXPxkOA
         13Nl2m/UUnGX2QjVPxAf9s4afP2nMBCENwmZqW2GzMWohaE3Mz1dl2xMwrkb1oPvBJdB
         8gU2M2DdQEjNLc3zb9DzEFRYrAuLFeNyO39kEr8HtJWK4Cfcz/KjZtfHs7/cTdHIidWk
         zi907lLeWhdC1IPZzRTp0OhbbblgKCAYmhP6mKQkk4GbrSucvTZ9uKszU1oCFtYB0iGe
         /RsfANvCH7MSYq5g7rH4iQJDTrs7ITUYEhoNXwGvcqFSi1fCd4RE7A3n85dGP8YB71lr
         YzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432665; x=1752037465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EG55DPXz8+xtKpQRKekjwgyGLv4dODZAuNPTQZ9Shzg=;
        b=RSXJEvOouhx8Du4Zq8jtlY6h/l0aydr4zaQM2VMqEg90yisTGe4puo0vS/tncgyhpB
         QkW0GTawtNldVu273rQKKIGd8mO9NwtPaXEkOtqgW0N35FfSaZn/1iM0E8G0BoQ61Nt8
         C2IHaWf7489hUIK5ioFBub6MPjT3xrLlwybBvmXIYrIkc0QfLa1EfcmraFWeKnmRzdph
         4C7YeEHPvXG3tDi0QE7W6x9/yD8iDPV/KQ+7eJ9QN5Ij2j8hD3eFxZ16i3fuNJlwMEIZ
         7zhJGiPq7D0BIcIlenSo4yhoqSexWvcEX9j39mrhEwuHILDOkkhbkPapUO6VFL6QUblc
         UYqg==
X-Forwarded-Encrypted: i=1; AJvYcCUmMITYXm9Cjwkc/kpR89YQ22cZhJVCNgn2iVgAT0y5YEesXn/YP+asLRSITg2n/D/Y3BN89u14iqOTUUI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzvhtqVx85ZytBH3eda0iAzbD7JONWEuzV1YwK+2G5j7iBa4v5Z
	n6NFQROM0dZMoB7/cZ75qx4CoRUBDX3+Uc9cKUgddrw+JFBPH4KiA9hT
X-Gm-Gg: ASbGncualISwrg6O0au687Vv2Z5svN8DAJR7BjxYk10u9ZhjHeUwkLqM35zWk3yigfy
	pYjKO8owSxBiaZXAmj33pJ+1pS30JIHUIs7BdxjOw/zuGgeSdlvqjRir63WfDMipNc2zms+zv4v
	XEwUI+ijY3qXa6/SuFTcmH0d5VTQvtPKVI1btqR/odnuvbR2rtbzSy7pkrCV7or/oo45IywDLWp
	+WLocKzbZQt3Txg6UCIskmubAVg2tV/jPuXSXGKi6vW0fWQZNL1feE1wNlXzxjAZFiL3joK3clm
	+t6+KCFo3xcjC9WQSddE+tvCuz9oeVjjTWPyid8MJljDprPnTYuzmrDZukfROtQxEeMOD2NyNuT
	7yx+aeVSt1hcufOes7p25ikZK5MOFUEcjDxs9ZJKcXFWGp+7HFA==
X-Google-Smtp-Source: AGHT+IFAFsQgFBXHekzpj5+jLpvS19bLZNwjrzNUfqbzyt7jsiYooA3Z/RS1UmpTIK1dgo3CN2kBvA==
X-Received: by 2002:a17:90b:3d8c:b0:312:db8:dbdd with SMTP id 98e67ed59e1d1-31a90bef8a1mr2126382a91.28.1751432665347;
        Tue, 01 Jul 2025 22:04:25 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm18168323a91.25.2025.07.01.22.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:04:24 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/5] ARM: dts: aspeed: Add Meta Darwin dts
Date: Tue,  1 Jul 2025 22:04:11 -0700
Message-ID: <20250702050421.13729-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
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
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series introduces the initial device tree for Meta/Facebook
Darwin AST2600 BMC.

Patch #1 extends data0 partition in facebook-bmc-flash-layout-128.dtsi.

Patch #2, #3 and #4 move eMMC out of ast2600-facebook-netbmc-common.dtsi
because eMMC is removed from future Meta Network BMC platforms.

Patch #5 adds the initial dts for Meta Darwin BMC.

Tao Ren (5):
  ARM: dts: aspeed: Expand data0 partition in
    facebook-bmc-flash-layout-128.dtsi
  ARM: dts: aspeed: Remove eMMC from ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: elbert: Enable eMMC device
  ARM: dts: aspeed: fuji: Enable eMMC device
  ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 92 +++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-elbert.dts | 12 +++
 .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 12 +++
 .../ast2600-facebook-netbmc-common.dtsi       | 12 ---
 .../aspeed/facebook-bmc-flash-layout-128.dtsi | 10 +-
 6 files changed, 122 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts

-- 
2.47.1


