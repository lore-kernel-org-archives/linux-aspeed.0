Return-Path: <linux-aspeed+bounces-3637-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233FAFD88C5
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Mar 2026 23:01:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVqBn1sQFz3bmR;
	Wed, 11 Mar 2026 10:01:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773136192;
	cv=none; b=m83Vv85extxH5IuI/+9sYzMCDY3+W8Jyaaov/MKNaPgtw4+NKu7qP9+WMQS2GN4eM3USfJTgKVxBe+P8K6r//5kSBpS2IWN6UTk1uwYpv0rDNEGqkoLSC5HEB4qPYB+LKhEZrPp0VKa4GKdqPNQP7w39xTmDMK01kC4cdKJh0hl9oGfWODZ3CdgBofGyZzBoJg8anBTKAOJnaCUGm2RX6cxsVJBj+F9LmrSg8uiAUWaNt2x7zoeU5jZvZ6M4/9HwMB1ZHzA6SyA4TEnKI7/bpt9r9tnO9/00rm0ouE56qx1TMPS2AeDJWpcDtvOst9id9Ud8aM6FyEmQlhusvYXzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773136192; c=relaxed/relaxed;
	bh=MNOZBfqr2lnHP3ETayFOjn/FEBqearsn/ED3lU7TMb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juJMSWNnfJw2b41tibYCxs9HSaVcUT3XK491EEP2rX5AGm1lrs8sJWkmfQ9jMOvab9zuulsUrfY3GL8rSiNWuIHh6VC/fP3eI2956f5Kr7nB0MO+wicLh9ajivJdMkBK1wCI4p0m8F0Y9zeJkU3dO7Z2YSootLgx+zeDwSaFqXgQZDM6SDvTclP728lRE0+judOyOmnbXfP1c8ZZUvVCNIR4kOgp1Z6vVIKKs08jd8ITRVyOfn7/oze+vRGMp4WdGLPChdVcoB8QcbwbxoOjLEoIZV0ugKxgWjPS7xNrYT3v4CMQlmCpWYoQnbXcaNgqDIdsDUp6YGl8Kj0nV7AYUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fz0ka3I7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fz0ka3I7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTcw0TNrz3cBG
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 20:49:51 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c739e680bebso1030580a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 02:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773136190; x=1773740990; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNOZBfqr2lnHP3ETayFOjn/FEBqearsn/ED3lU7TMb8=;
        b=Fz0ka3I7oOMR6e/Zt6WZownx3fEnhJ65JMIIFvrJ0v0RrKKlXk4j2HxWRa2fj9LNWH
         88W2qcyxXZ9VHPX/hu1HoRBTkWHe06e4mh+e/8Nbfb/Dt717fQzMwXXYowOtgeytOicw
         L7dq1AHXkTSgLVtxbgN0D6ttdpPnpFcOIpny1KezOT0F5xidmlnCeA313DgQcbbhcTUE
         BpqL0MXyb01foeoDm8aGI4gEdyCDfHIFWc7usiKf5+1vP00nRHTId5qIcauYqDLaYHWX
         HxdjZcZzraiW+CR90wDjyV8BmFyvWujd6NSEgwFWfeH9oSQE2uRHcfr0rLkcU9tNJJti
         7bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136190; x=1773740990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MNOZBfqr2lnHP3ETayFOjn/FEBqearsn/ED3lU7TMb8=;
        b=HmIKV4E/T14Ell43RZazQJ/DpwTSPi+x5w/r2eQxXgq9HfXqmjHk4jClQ+ZauFF7OU
         GFxG1UnoMeRVTAF/xp6+ODrCGzeIRx4Aah/rzCnMfGf2x04IfC3b7Xt4oQEybiv5Nowm
         jfNd9/isJ7Ub46kRKkIZapQDS15QZZdW+pyJAN0BUO6OXxi9hJynX937zW+IooxWOxBh
         lF4L85oTqpY1B9SDCdT7fHwkbg2Vft1NEcKGCd5DTmVSDtxKlbx4GyVMtbtxX4sx9/Kq
         Xh+vgSJHHPGQP+FwqUXEGvLDbphVnNVqmi0tXx84Dvth1kWI0mA2ewyEcjSPNnEQjmgd
         5xnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVraBwnOurn63TNk2DMZAVfG5VHvTt9YBMkESt5zNwd1BUCicYPQPZvJolhQ4l8xbxEA9EtaePhBc5bvro=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4eKCv70mz1iB8WsTDPSIqtGYLVS4O20A13zJk27d5mx1uMzk1
	22ynSaC1UaHtoXz/gPci5gelfm/srxt3+4XgAodZf7E/BySvQtm+AtHi
X-Gm-Gg: ATEYQzzVwDp1qxzZooT1gek4MWfrlgRIowJAWkbOaielYnNBd4sMUxwnmF26f6GgPrF
	z+UX7aD+dSgY8844r9/8c0l4CHzbiUlph8yjBAfCp045vL1nyWKPbjVLjIWTUW9XE0K2vIsvSAu
	UBcRqgGIWts06ysYabd1qWv2Kc1ZjpHEqFDADyMSD16h5pmzxD1KQt9SOfALXbgFdayZYqoLzDw
	zYjb3yJRG0wOwLf2t3KktQ7y4EvPeHZa8bHG2fihrZ02IoSZvQjKMm3+1nlUqfWtmy9lgwjum5A
	uVfj5xRjoU1WiAesqcFRkK1UhRZDigJHPR1XyUqoegi5eSwS/Uhd8YFpXcFU9UY7F1twVGV8w/0
	ny75yVgE3IF9UXYGlMP033tP7vf6Ox0lxOgtl4MNeJnxjay4yoah+NxPFgjvQ3XhwALugQGhqRY
	Uqeyf3IVBTXDU4FSRUjBKPSl1Dyu/VKA==
X-Received: by 2002:a17:903:4b4b:b0:2ae:4aa8:cab8 with SMTP id d9443c01a7336-2aea1cc7a8cmr26099295ad.4.1773136190120;
        Tue, 10 Mar 2026 02:49:50 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a67esm199459775ad.61.2026.03.10.02.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:49:49 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Date: Tue, 10 Mar 2026 17:49:35 +0800
Subject: [PATCH v3 1/3] ARM: dts: aspeed: anacapa: fix SGPIOM0 GPIO line
 naming for RMC leak detect
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
Message-Id: <20260310-anacapa-dts-sgpio-v3-1-12d9b7f1202e@gmail.com>
References: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
In-Reply-To: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Colin.Huang2@amd.com, Carl.Lee@amd.com, Peter.Shen@amd.com, 
 Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773136185; l=1183;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=rM1a3/U5nmwGlIwi6wEffz8sWYF1jFlqAjBK8RCzM+c=;
 b=/SkyG/rI3p32n0sdU9i9f/wiBX7Kg0j7iOXHEq5CkGxm3tJbqZMGUeyODhM18MHMcvQlMumuj
 xH1TzkeymrGBPmYnlXV/UAu8KCqMPPDrerCRNXkWJk0iogVaIO0fM6f
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

The SGPIOM0 GPIO line naming is adjusted to correctly reflect the
RMC leak detection signal position.

Move "LEAK_DETECT_RMC_N" to the correct GPIO index and clear the
previous reserved placeholder entries to maintain proper alignment
with the hardware GPIO mapping.

This change only updates the GPIO line labels and does not affect
the electrical configuration or GPIO functionality.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 2cb7bd128d24..3e297abc5ba4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -880,9 +880,9 @@ &sgpiom0 {
 	"Channel7_leakage_EAM2", "",
 
 	/* C0-C7 line 32-47 */
-	"RSVD_RMC_GPIO3", "", "", "",
+	"RSVD_RMC_GPIO3", "", "LEAK_DETECT_RMC_N", "",
+	"", "", "", "",
 	"", "", "", "",
-	"LEAK_DETECT_RMC_N", "", "", "",
 	"", "", "", "",
 
 	/* D0-D7 line 48-63 */

-- 
2.34.1


