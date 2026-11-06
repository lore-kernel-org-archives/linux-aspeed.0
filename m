Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C760606A326
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PwKIm3Xp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLPC5661hz2xHP;
	Fri, 06 Nov 2026 14:03:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793934225;
	cv=none; b=iTQoSpGi7fz8YbIEHjXySKXVaJeSR0pPOaULU1JfAZc/cn4r67L5MgvsVKW0Q4m4u//MPGsX1t1S+EwEaLWXn+H/ucJVRSARwIEbg2w8+hkXIR7Oihwia4K2L4QiJUwwboXUGQM8avKxEwd4eAUAyCsTLn+I8MuOhV9vJHGJAQuW4nP2lx7s9R7LRyiIPQ3Vi1UZ2hGAoONjI5FhqPCvOMjgrdel0jch3as2oKI832y5Mk4WCtWc3ZGNMPcxAAfJ7pbjZOUhrlSxq6oPLgvYD7MWwZ06XP03V/wIfZghZjHK44UA4x9og8rz63H0t8h83jYTfsTyrsHawNQMjN8avw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793934225; c=relaxed/relaxed;
	bh=vefK5FQVlJXzb3STeUejz070GYyJd6eyM7yi88g9v0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcoWp7I4ZPIMW4eqot8e1zl2MclyRHttU6ZyaZYuxxIvgfczENsNWVOTxYiWsiqdr7/tpc0VFIDRlK3bi3MYK0CITgjgXd/cZfNYi4dPY5dRSX8WgLX9EnOMVt+DblQBpNAB0EPqPjlLkenm0r2GiHw+3jNSRyOb9+lO5whOnORrdou5Kcpe9zfdh8KU5G7+gH3DFJ9kPXWxCwiOSyhzgqh1WXfZBQ+wmoIfoEoGT+l0j0WgW2WBOHjmQ0+m9GB6FvxgqZqXGW9XbuRhkrmcBcGSGlf5WFgBKNgUqak4bITYX9bCs3JVi6KE+RKOpnr6DP0bT7nVY78xzH04rs+fag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PwKIm3Xp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PwKIm3Xp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLPC51sd2z2xGr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 14:03:45 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-8a06454116eso68080b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 19:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934223; x=1794539023; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vefK5FQVlJXzb3STeUejz070GYyJd6eyM7yi88g9v0c=;
        b=PwKIm3Xp7nHQyWX1LeNXnWt/t3sGQtZW7ZxG29LcX+Mvd3P37+Dq+LMtOwGWlbvu1S
         zK2VVKpV8NHtLxXb2ZJD/AM7Axh61OP0X5ixfOD0xjkBGCZJMdASYGfK/RhbF0ELkxbC
         Q9njTLzIOeAnBBQAnQZAhDeY00NxOFX5Z5k9Z2EK/IkmOP771F/qECXfjMrxnRws4N47
         BuJbq+EOj6LQ8zvKw37AfKO1rj1SRyc+EffmKfAPB7e6Caczp/D230w2s9Xrmjpvt3Uj
         f82WozPpfbCnsCv0QF3SxED2MXQC9RP/RLAPmCVpcWIVHwT1zR2pJ2zAZ37rvqOyT7zU
         +2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934223; x=1794539023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vefK5FQVlJXzb3STeUejz070GYyJd6eyM7yi88g9v0c=;
        b=QyI44dkNwbqXboBJXkMIe4+FDnqO1ZxK7G5Q6VbsXUAmYIlN00EntKMGWo5CwX/P6i
         scvKsyiq3VnrJlBn5Vz8C1mArXmQQ+e79Feil8J4Pa5FeiD8oa3GKjqhccvFQ3WAWakO
         rjxcC3xADSArlx8S6O1ybRkF2jJ9JOecyGLZbJ3yhCcIIo7Ysu4I03yOmQWYUTg67O4C
         Jjwe2PdV9YKSCTi8P+ky/czGSMyN89v5+WdE06fi/UQc2r6PibtBGMnv9jqLCLEH0mgC
         RgGH6jx/QJ3tqW/oL3Ekrq8H1zdu5oLvHqx4Y0u8OLq+pRX5Z5qBdTqDQkFwbQYLkF9j
         Dqgg==
X-Forwarded-Encrypted: i=1; AKwUvBzm+UpW0iyBRAaC0VUmhaNMzDECBfwHcY3OET4DUp47T5gMdCxdsl27I38e/zOAQccqWMu8S3Km+IhkFAM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+7Slkg6M0lnhBbBEO12ooZ2/9biVeLKro6I7H7Ra6Ka2xRTVXA
	CmIBswIvAEXicZGqlZtHElL/cRqgf+md9nrHgwnD5yDtKVb9Jk4Iz7ia
X-Gm-Gg: AYBFou3cw98pTYy1TNMzPGdgnZcSdITm2ciVXa2XE6E77Ekd3i7N9unu01req799DtP
	iTCePO4ivWNB5jyxRmuilxk0gGpfcszaVJmjNknIzFbyz/25iQPPVorGQfHjygfLB1oH2w917ly
	HdZQ3/ZKJZ41uE/KcvgknM2IEV66JW2xnV7lrd57PP+aF/ODmchiPiEaOui1FOkR4mIfQvfGcES
	wdRtFifqcV9JZP5/okdhUiWVGxiU2+GZp/gcgNHitMJsA+d3wwjNUWd70Vlk4BgcxiEMkceSgMv
	KQDRAglv1Cxs2YOPRyCTQlgVYKy43YvRFVHPbGWXViSuntuqJiag9lMpe5dpqniQ4EYXBMQjoPm
	+YFAGyI2k+VpOaNlvaS6gttM1oFSh9mBpIDFln5eE9TTN/yChzRSDZ+z6OBxcCXAmEoso20V1zG
	AiejAkxzbedJTFYKEs/kt4CJLPYbcGulJsBszCoRDui85SU1AKMqyVowrDxa9PRsleTLByydW29
	C/aqZBZZKkBfNrH9i4Tg26+31IlHyjUXcUThgm09CoPs9pznY4JBj1z4LgFdYbGI53q167JaI4V
	PEmxHJwPFPFhRCfuGbXvokEZ96TZaN/4Ggi8TIp4wihk6/Avi8iLFor5+7znjqUoE2AsSsAsaaB
	NWyM3iixCOuyYqA==
X-Received: by 2002:a05:6a21:6b05:b0:3e2:799:f2dc with SMTP id adf61e73a8af0-3ebb2a32f99mr1584310637.40.1793934223023;
        Thu, 05 Nov 2026 19:03:43 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a04a39sm118179a12.15.2026.11.05.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:03:42 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 06 Nov 2026 11:08:03 +0800
Subject: [PATCH 2/3] ARM: dts: aspeed: ventura2: Name the COMe presence
 GPIO
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ventura2-dts-update-v1-2-b085ece9bf57@gmail.com>
References: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
In-Reply-To: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=4Jjy6nPmm/6tj8SAdf81ahe94whURxI1stwQZrqpyWA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq7USVNgrr8sXF9pbSJR2rRAI+WNwaex/opd0PN
 eMqQVHYIh+JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCau1ElQAKCRClg0K3CVbE
 gVLVCADDgwQyaqhCkNk4V4yZiqInsNBqp1YSJdRkVsxHS3sXrdepMRzW399viEf0lzpq4iLclfb
 icaA9RyeB+vGZJ1EWW9ZSeLncM8W1RQp23YEIgE1qW95PKHE88GqxSleX8lRXKSd9IDffeu+lAt
 8tznjeEnV0RdpZw+T5s3e3hpJs6wenS+z+l7AqanMVTx5ABSYWgl7v93qDJ01nxd+qfHXauz5TR
 H6QK8SZTncBv+ULDWVrKSqyshWfqGnmrC6+umFUjSecbRL2mpBu3swo2YOg0ECurV9y7ldff4Bb
 zEQN7xfd4xJMUJBFPZk0L0ZWLUfeK4OZkluS3QH9/fmXKHKT
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Line 9 of the PCA9555 at address 0x23 on I2C bus 3 is the presence
detect of the optional COM Express module. Name it PRSNT_COME_N so
userspace can determine whether the module is present.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
index 50e652cc37a1..a9c5990ef969 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
@@ -625,6 +625,17 @@ gpio@23 {
 		reg = <0x23>;
 		#gpio-cells = <2>;
 		gpio-controller;
+
+		gpio-line-names =
+			"", "",
+			"", "",
+			"", "",
+			"", "",
+			"", "PRSNT_COME_N",
+			"", "",
+			"", "",
+			"", "";
+
 		interrupt-parent = <&io_expander7>;
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 	};

-- 
2.34.1


