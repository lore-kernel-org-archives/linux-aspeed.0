Return-Path: <linux-aspeed+bounces-4125-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A531CD5BBF
	for <linux-aspeed@archiver.kernel.org>; Sat, 23 May 2026 02:30:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMmN44rSsz2y81;
	Sat, 23 May 2026 12:30:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779503444;
	cv=none; b=M28m1iYdUVkffYTaBeZ+j5FvZmbiZ0JjxO99IH15HOtYFHN030X14ilv+AJoHC78y3OcL6IqjZgIlYRWx2O9brXBP92Kb3ZM5+avgBQ4sNKs6sdXshxFri+PBNycq+N1x8XD5hrNR640GqYJSWgwvWuj9MLYFQsQ84OpMfvGL/x2NpxOb3RzgGz74urhKV3O3/CdzBKYMR9QOFskDGpSYNlbwm7+39391ouLPwGXGJyKyr0Nm34uUc6iKUOJ3Zc6ejRbujVXdSwltEhCSc88qd+TEXzM8hNTGyXwKuqm09XRUPYAFHmSREPr8FBZaInU1JPH7KbXwYTQamG8eLtrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779503444; c=relaxed/relaxed;
	bh=uajlJ9IdqCFc/wQs8+7+c85ig5TZGgylUIfMTi3Hupw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgO2ImK/p4eTFSHBOI70O3DRnfXh+DmqSM3uY6gwS+1EidmgOO40ua+5K8KR1vOScHjpGFMYeYOsDUystpJKVp+Ie4AWT4b1AdtYsOR1Xfl0EhbvBgDbs5Kh6ZbbkIlroydisFP0CnYqLvxnKooqihyIQCsmpr5PHMJLZpJC41B/aa/0CmOBFlRoF8i3YpjFADGR4wwHqwazhbEQklFSYTB3koPYzCGqD5j9xCG1QtCpvnUy0U8B4Wg/qMwLl7roLGxRdUCfjZoRys75sODwS/B4AmEAufKqJ7/mgt6xSDeAYVg/TYljd1WiAkkLJv4UqCl5CWoGKPV/4D8yQsMukg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXNdEq/I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXNdEq/I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMmN368SRz2xtC
	for <linux-aspeed@lists.ozlabs.org>; Sat, 23 May 2026 12:30:43 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so7169913a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779503442; x=1780108242; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uajlJ9IdqCFc/wQs8+7+c85ig5TZGgylUIfMTi3Hupw=;
        b=pXNdEq/I8dLMwYw8f1fFlbFc4GkO/4ezcuv3U6/tsV56JyjtHcl20iLHLT/IUXW93T
         Hy4m3wipAjfXzP3ehQweB+yeKWJMvgD4+8yovGuyxTqrO0vI+eughJbvzf8WUrtKA9nA
         mEUyF2FXjr7c8dbPlTyu7helQ7NYnw/iao7hFhtd5NWs90++jl+Nu78GAmViJ9UdN+Tl
         Oq2OFAe2TX58bv8VjlWz8ZsRhcK9+zGB3MdKZhOR/Vvfq4+W83Q2QSx3OsOT6v8psyiD
         aBNsCOelXuuvc974e9Lmz2W0UnZMGSXOM2DXb48EbJllC9eHWAdWuLREyXpxjpNim7BW
         j91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779503442; x=1780108242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uajlJ9IdqCFc/wQs8+7+c85ig5TZGgylUIfMTi3Hupw=;
        b=rfDUDHcL+OwJy7qa2HbwNDPjqMA3NCKVUiT3jE7jx/y5+RHuU5KJ0o1aeNZ8exuQuc
         rY5Lepyr4A6kNxT5tYBR09VHQ/1tK2WOG+i2PHR9rUhU2IW9r72sLMsk+3W30x4OIRKC
         lkgVNFREevz5tRJKOJ3OowyClGd3WU3fSri/oRQKcNRcHbmVF9L24ZdD/Q5vpy6nPmzB
         7+/OTeCy7v6lN0Ae4h1V1/qCy7ET5yrY2gARgjIqkF3+oxHPOvfq+FFj50u1ReDEGAkb
         gVy7j3aT0BJVafUlhwy8wwjXm2qKfFMbd9LEoJlfjK+wCr9q05e5qFHKYRIUoIjtKlrV
         IcVA==
X-Forwarded-Encrypted: i=1; AFNElJ+K/U0iLw5kkUPMEit1u3UEdu1QbbawL1sn6lo/ejtyd81cdQTUK3QQUKPYfnYtaAVYkp5cn3DYu37Q61U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypXrGFNVk3hcvYwoBuxaA3srJpUBXa/hDGhLlwuCge2dBpjjpy
	BUevbhQ0ZlljDwbdzT+1PD9aAIwEMVNeg+Sr0BMMa23SwCCAjzmTlU+F
X-Gm-Gg: Acq92OEvE/T0FnQSCKMwDj9EcFTPrZxEPiZRtS7vVt0XNZT3mRblNiUeqJj0/crvyJy
	6cd+gtCMfQ3qup9LQQMFi4v5MZZljYTW3neX/zkWmi3Jb4WEy+bYEDXyuoXdyEi0p0QRKCC+XhP
	qvVosSNc097dmc+V8krUzPsjRimMRru02pX4lfe6Rp74Z6cI92+mSjPcvEiys/Y8hcmpjumwC9W
	jw+uAiltbE4BoOHyH7Ck/wKSreITfwCk4wi2RtILwsPMXv1KPUpz2/NkuoD+vBpw9J+V3G/9fBR
	CUu6FLUd+cFq6dTb++PECaX1j9irttopI1MnbCrVLGRqt8bj8RHEOc/k5L+nzjMecpsoPL8tugk
	YlqLcaEE1uYYhlxzh66wwwg4H5vlq5TZ2JncTgI61FoC2h/S62q92Kc7YxV7s17ziMYITIyBAMc
	Gz4/RenWTgmOwcu+TXx9tuZTmmESlpNbMqw22RDsqWTiJNso8GpMAaUQYEyT9F9/K00g3DvYwSW
	btp
X-Received: by 2002:a17:90b:3dcf:b0:367:bafd:9431 with SMTP id 98e67ed59e1d1-36a67448b48mr6109633a91.8.1779503441893;
        Fri, 22 May 2026 19:30:41 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d944c4sm3010287a91.1.2026.05.22.19.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 19:30:41 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
X-Google-Original-From: Potin Lai <potin.lai@quantatw.com>
Date: Sat, 23 May 2026 10:28:07 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: sanmiguel: Add IOEXP interrupt pin
 settings
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
Message-Id: <20260523-potin-update-sanmiguel-dts-20260522-v1-1-169f5fceb5f9@quantatw.com>
References: <20260523-potin-update-sanmiguel-dts-20260522-v1-0-169f5fceb5f9@quantatw.com>
In-Reply-To: <20260523-potin-update-sanmiguel-dts-20260522-v1-0-169f5fceb5f9@quantatw.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, Potin Lai <potin.lai@quantatw.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779503436; l=2395;
 i=potin.lai@quantatw.com; s=20260522; h=from:subject:message-id;
 bh=ab75eXWBcB5dHj/FlHKk33zIKemAgVJpWwAxAx7n/ww=;
 b=xF6jdZ4fIdGmdIfPmf8Wo8rovbwKz+ugVULJfctiEEq+ALXfJ/yVbnX1LAQXDR30lhljFcG7k
 9iKOifluoJbCZ/C7YCPnaoo+c2o+DYZKVu7o+61HIs6ONQSJUEevezi
X-Developer-Key: i=potin.lai@quantatw.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

Kernel dmesg reports IRQ #44 being disabled due to unhandled
interrupts from multiple PCA953x IO expanders:

```
[ 447.047861] irq 44: nobody cared (try booting with the "irqpoll" option)
[ 447.063124] handlers:
[ 447.068176] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.087268] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.106344] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.125421] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.144513] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.163587] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.182663] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.201756] [<2ab869ad>] irq_default_primary_handler threaded [<b8adc310>] pca953x_irq_handler
[ 447.220837] Disabling IRQ #44
```

The affected IOEXP nodes are missing interrupt pin configuration in
the device tree, causing the interrupt line to remain asserted and
resulting in repeated unhandled IRQ events.

Add the required interrupt-related properties for the affected IOEXP
devices to ensure proper interrupt handling and prevent the IRQ from
being disabled.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index 74c8c1772109..61dbef45f8b0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -334,6 +334,8 @@ hmc_ioexp: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
 
 		gpio-line-names =
 			"", "", "HMC_EROT_FATAL_ERROR_L-I", "",
@@ -552,6 +554,8 @@ smm_ext_ioexp: gpio@38 {
 		reg = <0x38>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
 
 		gpio-line-names =
 			"SSD0_PRSNT_L-I", "E1S_PWR_EN-O",

-- 
2.52.0


