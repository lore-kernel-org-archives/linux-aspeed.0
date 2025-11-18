Return-Path: <linux-aspeed+bounces-2946-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E3BCF2564
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 22:06:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9zGD6cLVz2yv9;
	Wed, 19 Nov 2025 09:06:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763463222;
	cv=none; b=XJWGAn2Z68jJbsZPvQt/L/CIG8/nkOA1yJ3yxePaKvG6UTfkqtwBaSxYBVCJWnFP1FRWfQK7ERlL0COGWfqyZVuCkOjkYHll9Bfv30IWpDHhsPoEzz6gb5dSpFmkPACAzhtqWveudmSKnlraqehnwECJlx60St6ItYlTTk8xXPMpxGSCwZbE4pfCVy9Pr5F9A3gMzCuERLdYg9RwIbtoqjEtAxGSvxEVVxe9EJxJmhUX3BX9xtUgB5lG94WQKToOqC4wOjGo0LLPayoxSdqzRPSkq4lvQ9GwMjLVRF1jdBJ5XYcvyeHJ5KrSTrhYMuY4eK7NgrVCo7Gly7pf90cQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763463222; c=relaxed/relaxed;
	bh=CHVbT19SoV5m4YcosKHhTcv+qnuVQe5xO2ZctZWhciE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQYqJywVAeHmux/Nguny8wuxnuoKi9JPgebem7IHLr5ELbKdUz28lPnVyK7cVrZ5fW6yvxkdmaPdlSwo5NflYjeB93gvZMRaUpsSeABGcl+nzwDoOVdkt/m3iJxX1PzJBoBckXAe6vYCQLZ0P60kUBrMr94PxPdAa9dz9GB+GVAQwpQSXhyUy6SF4GzOx4fO6JtY25GcjMGCvIVLmqxzPUsY/GUrcp+8JNo85vdrJ8i+w7KjZ/RS7kAJCTvY7b7QAffM09g7rV9s8rB+fffmKwxaJ+szC/BsvFrXilE+u6y3/z0Og3Etxf/FLn0FC5/04ulnId3tsN0aqH53crW+yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hAulhe6e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hAulhe6e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9hLG1jkFz2xqr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 21:53:42 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-298145fe27eso71804865ad.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763463220; x=1764068020; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHVbT19SoV5m4YcosKHhTcv+qnuVQe5xO2ZctZWhciE=;
        b=hAulhe6ex/ZFVuKhTO9IXLit91O/YuXy4Rs/wjuDZPmgj2sROFd9eN3I3/rsWl7Y1M
         zkIrJEYy5ookJK/yTvyzPF5j19f026iO4o4JsREKracKI9y2HQm08OKVsnsY1Y2jXGHI
         Q6pHMfdWMUjPQ4z23H5+WXd2SICdZGF4NTRu9en+Gu4VfVOyMMZ7RxMoI+0cqqaA1/2T
         qatz9g1Tsq1noFaWhUgruBE4fizNyN87voL2thNfI5v7jebAZcqdrS80aZDsMWkyjUZJ
         yrjezLUQVP2c5m6dI9Q0ATJhyLISbZhfKOEysZ/Y89WSjc/VnA1oPPQciEhN+9WAYR7O
         xlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763463220; x=1764068020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CHVbT19SoV5m4YcosKHhTcv+qnuVQe5xO2ZctZWhciE=;
        b=NoV420OCK0dj4NMKf9yLHn81SKpnWzOELNQVWpeS57Np4wEQE8mUWMdh7J3vO5cACa
         OD+B/Cs7urQbynpQkJiN6gXvrSCVgNkihdPBP1D6SJnloqsBr9yKFJqkGk87DsJiJO6V
         0bH4IwseQQRKWp6eTTQrB9EWXLZX996LCap3WFofyzJhbQNE6XjgIcJdUv/8QbEZ8ysb
         qtkF52YoiRvT6TFj4Ayalkstm0ZB/uSW6v3b0G9di5EkyZ/YjFSbnsms7+iQyY7APW/Q
         dCSqmJGx5w1cL4iXPqeGe31Y3T+kau+77Pm9Fde/Gr4o5ehuqhPLHTbrAoGbL5n93l3a
         zFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX7Npeg4R2kHxRWEYOexK+vEApS2IQYx8I9VzE/TZNtATxei54NkGD0sBpG8PkwryNOqCRvQmggCNSfeE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzraBGDgatoTKFmyTl5bsFTDL/UvR6XA2URH5hE7O9u2iA7Evtv
	uh++K7lrdjCJNvhtvXp0wppdZyZdL0BHmKVK7tD5AhnRup8skTQEa0LG
X-Gm-Gg: ASbGnct8D4CvyloU0j8Bshvzab6B3RxL8W1ixit7kyq0S455o+3s5s5TrCOz3MZDHuK
	4L2hsoac3ED6OyGozv7hXwKJHztlNt0qenIJzL4Ry4jObWNKfD5VStJsWfHK6jcnvmY/GWDwwHP
	+d50RHGajSuKD7KrHbd59aBx+jx/WE0P6+wI9cLkhyimpRuk7FHI2tpdjC9pbEM9+Fe4s4VZIW8
	7OFR1Q28tDAMJMExj+boVNB4HAlZtNE0IcyaEHGTYWvo7KwZ3aR0Z110EemerqyQMJX9UOhJC8k
	1L2WfVrzeLEL2wPzzqPESLdRhK58xLsNMbmtJh0JYTevjkdk9knmhHzy5oTgCo4ANyCj5lug3rV
	2zH6eVa2ImWIiePy/z9gPN4a5SvUueGPsULNqNm2WY34MbUFIdBHs+TBssjr87OwJJKj6wAKHOm
	n+sMG4oKaVvrX38O9oUyRjPeG1/XRdS6Rr3pO31NgJJRjzep+u3/prV4kOsE3Vb52KGA+BjoeaW
	pJgs9OF7OqPMG2u68lTKuXH4yKWfVdUijRWTSIf2fQNnoMtHtqe/mDTUTRc8ziJnw7Y33ZNbso4
	JL4VWZovww==
X-Google-Smtp-Source: AGHT+IHtRhbx1WQdiUDG5aFG9T4qFsxGHKIp2R0JtXKiVt8V59WsATTy92beJIoZk8kXpFVbidfKkA==
X-Received: by 2002:a17:903:2b10:b0:297:d777:a2d4 with SMTP id d9443c01a7336-2986a752800mr183541415ad.46.1763463220093;
        Tue, 18 Nov 2025 02:53:40 -0800 (PST)
Received: from 2001-b400-e30c-5507-a914-c4dd-0879-41e4.emome-ip6.hinet.net (2001-b400-e30c-5507-a914-c4dd-0879-41e4.emome-ip6.hinet.net. [2001:b400:e30c:5507:a914:c4dd:879:41e4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924be368bsm16274111b3a.9.2025.11.18.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:53:39 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Tue, 18 Nov 2025 18:53:20 +0800
Subject: [PATCH 3/3] ARM: dts: aspeed: yosemite5: Rename sgpio
 P0_I3C_APML_ALERT_L
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
Message-Id: <20251118-yv5_revise_dts-v1-3-fcd6b44b4497@gmail.com>
References: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
In-Reply-To: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763463207; l=877;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=OEoDPVAl+S0COKkIlbVNnqQ2XcG7pPYJZgZLJdWqaeM=;
 b=4USKdt1HV3IaiPmMl+bPEbtszHgor0AgWJDbq4gqBruxhvUo8q11T/z4s2G7YCnQuS1soGZLw
 /YGhiMgDbX/DINgsGqQnz5J9GP4ANI7VTQb+UhQKnY16LLvQDl8qHsK
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Rename P0_I3C_APML_ALERT_L to FM_APML_CPU_ALERT_N for clarity.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 45b8ac2e8c65a4f672e64571631b7f6944f26213..060757b7211a6da777c51d9f0c886796cf2450a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -964,7 +964,7 @@ &sgpiom0 {
 	"FAULT_P3V3_NIC_N","",
 	"FAULT_P12V_NIC_N","",
 	"FAULT_P12V_SCM_N","",
-	"P0_I3C_APML_ALERT_L","",
+	"FM_APML_CPU_ALERT_N","",
 	"ALERT_INLET_TEMP_N","",
 	"FM_CPU_PROCHOT_R_N","",
 	"FM_CPU_THERMTRIP_N","",

-- 
2.51.2


