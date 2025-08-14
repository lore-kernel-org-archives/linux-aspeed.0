Return-Path: <linux-aspeed+bounces-1963-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2234CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 Aug 2025 23:42:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c31xl3Hhdz3bTf;
	Fri, 15 Aug 2025 09:42:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755177442;
	cv=none; b=jdW6Yo8Iae15mMopvtQA5T87SqGlWN8OA2fL3i2X5nIxyTo/oFd1RNjPw54NPlWYCMgpmBBA9yGDXemi7ctuXm+e+jdA70AJwOyLZxGD34CZ85rLkUglARzwzJ6S3g+rKz3Uy8e7TzQBfVwCpS7mRFMqZJRZN8ROzdOhShf3mHe9Cr6R9QlntumDEh8JJ1Hasl7Slf7h0e1wvhCmcpnfAm+us4cLGiHmBl1C05++lrb9b9HihOhBdFAFHkKHVOpE9J+oQa30UoxDdN+N26A6u539mXUmokZ9/Qsl6NZBD3EQTq9pq6emM3k/kbXRrb9REpiLXB28GLkTOBg5qe8ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755177442; c=relaxed/relaxed;
	bh=mTeugc1mw8AJhG/UkyxA6QZakbeowukdRimSYseE0MI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HumI+Za+NSKY7BreuiiqxA2qln+NfWwwOwTX8cMx3az2t/Wx/Hc+nxEqRdFVNUzkJStINzTC23XElAuMdnXMxfMxAOIoJx1Dk2wOtLSuGlJ0TuVa7nlxFj7182HZGRni+uF79qGj7H/PShPqxNLbfq5ZiWFNnicdJEfmtT5EcaFbzW1+uFo2xjsfH/TLPdHHx2lfgKVf0vIyRbUU9E9l0n8qtiHwBi6qa/VBQp+th2MSCIckYVT29O7Fh7ZIKalr9Kv2exwuIs7/a42iwdB87AFMagbUCkrBq/qiWl9IEuo/62WfRjxsQbdnR0+5393c33tYaJy0slCjq8MXGeX3vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EXMHPHaz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EXMHPHaz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2m4L3Jb4z30W5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 23:17:22 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-76e2e5c0d4fso782314b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177441; x=1755782241; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTeugc1mw8AJhG/UkyxA6QZakbeowukdRimSYseE0MI=;
        b=EXMHPHazA4DdHMM7mFkQHS8sgf34U7eE4XYKi7FSM7Y3IPAR2aE2ntmd9URXDXQsss
         7tJIEzEUWq92XbMo8T0FmolSXKNSEOyykzkyaNmtuJ3pkKhCFgVRZSi/kz/3e2TmB3sS
         pg49oM9of8dcE2r7GA6FEUfuGCmb+XcDxbzO1oms4+2ONN6GB5mBmoh65beY5SB8gMTy
         jI9mV5JdRi9ccc+KvfPUzR9Cjr15MIVmdYwRSoQTwsCU3/W1z1xcvx9CBDdBmcHBG2OT
         Zxt/QiSNX4NqW0bLuGucLsqQNOLIxq4emT92mXwAgfEn99q2H0W02PZnBqYzsxm7yP96
         MAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177441; x=1755782241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTeugc1mw8AJhG/UkyxA6QZakbeowukdRimSYseE0MI=;
        b=O26dKa6xbzrNo0Qx93+kyqehR8FvRWI2tRlDTfZ5w+64+CxsVOAJ+dYj93GJF1QOGW
         L1cvEjV5jmPe0XyfAdY3AIR5oND4wB/87fX0991Rqqj9oRekdhNq1pXB0T3WG7OTjz+T
         L5Q23dJ659cgFc70/1EpA4TM7Wn1Y0OFCjJMacO6nM6ykzxfWtkV9LnFLJMLZjObO5Ac
         PGlaTKhjkeG7NhiTvT/w1rkliPHGEFW2InJjxGCqcWLw5kHnpfD5BJ+HEXQVmN62/niB
         X7GySAtGrT5VBNC3ljXhufqy+/l/1o8VMRXMkt+Uxgd2XbQxGvNr6wCtc/ZPViOvSkPJ
         IqUg==
X-Forwarded-Encrypted: i=1; AJvYcCW6pRzd0NJtTg2hbkua2BiI939VPqOZrQaJ5lcJlvKopEGtkI1KdmQT8JQZkEhFYWd1Ec5ik5n51oOBUO0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyN0QdJFbCBJT1KOVRCl4TzkkfUNu6ZYOwYn808ewRVxnxRMwY0
	0mDPo3KuT0N1fB2M+g3TcOs2G3uits+vNEv/rZFQUPUmRuf4uQckVImK
X-Gm-Gg: ASbGncv08ZpstVtcMoNDIf3K0oV+8H79bE8s2Gmwj62z0YiihVC+OKICvVafoQMoSMY
	kUNHwGWEFaLulT0sB3pAxbE85nCnqT6lcbZLmNo44mV6GaW6zaw3DMQkRodmJhPS50+riQzAT6G
	EdvxEGTVF/p5YcmaNHytnYfqK8Qmo5l+69RvL6mKKYXy6sXlNbhQTe7ww2XLONOOQVyOA0HP8Lf
	ZTPLNg9h99RExjz0L9SbR41R/XJVaznqEHVq4Ry28RBc4iqBJ3BtATDG8JKmGXNDrGONkjSPRbR
	8V2VES0901f8ggmlU8EwciVAgjd1H29KXT/grfO7ug833sHdVL9mAuAmWxl1iv+ZYG3+jWn+ejE
	ZOtr54DS5ZcVPmSbWGBxzLFhZ62EfZ2rLZZNvcF1CUAWCRZE2fBaP6dTQ0Yd8sXiJJ1ibNj7NuB
	ZmTxH76K75eFI=
X-Google-Smtp-Source: AGHT+IEi9Cd4/1A3g4Nl0M2mQgj+9WahbmP+8Rb1RXtow/Y3VwIO6BsjihtLcR9sqiy3LmjE4+Qh7Q==
X-Received: by 2002:a17:903:2acb:b0:23f:d861:bd4b with SMTP id d9443c01a7336-244584b8f07mr42768455ad.5.1755177440508;
        Thu, 14 Aug 2025 06:17:20 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:20 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: aspeed: santabarbara: Adjust LED configuration
Date: Thu, 14 Aug 2025 21:16:59 +0800
Message-ID: <20250814131706.1567067-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
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

Update LED definitions to match changes in the hardware spec. Add a
power-fault LED on GPIOB5 and relocate the ID LED to GPIOQ4 via the
CPLD. The ID LED now shares the power LED: it blinks when ID is active
and otherwise indicates power state with logic controlled by the CPLD.
Retain the 'fp_id_amber' label so /sys/class/leds/fp_id_amber remains
valid for existing users.

Add a 'bmc_ready_noled' LED on GPIOB3 with GPIO_TRANSITORY to ensure its
state resets on BMC reboot.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ed30f3bf61a4..ed2432f37609 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -94,7 +94,7 @@ led-0 {
 		};
 
 		led-1 {
-			label = "fp_id_amber";
+			label = "power_fault";
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		};
@@ -104,6 +104,17 @@ led-2 {
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		};
+
+		led-3 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			label = "bmc_ready_noled";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
 	};
 
 	memory@80000000 {
-- 
2.49.0


