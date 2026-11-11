Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3D60A263C
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUo+Fw5m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPY6r0hTXz2yLY;
	Wed, 11 Nov 2026 17:11:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794377460;
	cv=none; b=UfVco4NHxn4YxNtcOA7v8JYPtuO6H++sHIBC8ZMRJw02RaP9hJgUrs20gZ9DJ/nSVel/HkMpbE40qje44YWdkRzyPWd5Y7+lSpJdapw7LYyDGbyta/ihc4EydyxVGMO/AJdp4bDUmEFEDAmbG/5HWxLhi1X7KM3OASI41X09fZ8xtfnamRzxfAzNi/m9Wd9CAoYcOIYsc/DGUFVQMUnc5snASs0jZSxHhriSWmldu/nnj8aVo0fm7z1WPtG885aJnRQCK8NajjEdbEHABvDH2Y4/PlCJRyymDOwEvQeNZLaMuQh+S+K6FUjjgHhGFBILE7BIn/2VpyFw5OP5VpX5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794377460; c=relaxed/relaxed;
	bh=fK4euQL/sXyPal5+J+hrdUFIpsb4ZufsR9tCvoLGNPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=og2ziiFH1/W2ADuPCQCzYSmSW1fGltpY1xlgZikmN4yEbluQ7XHzwMJXpGByFJEVrzoPT2Hi37haY8M/+myKHNvJyOkYMhToqOdKbHzyNwYkVK7yjxkFG8RAaPmEcp/+EoLvN/dufPmdOBl4VhPMBW5QTuH1RtsMzbr6dbwXLEKor1CPua9hXvxHbskvxr30PhQLD5t8psD+3NmqRucVrAXc1frt5duwdA/jCuJBArmDkeGqMQ2P9c4/9bdsuBsIEB7oi7xa4mqYTX1ZWGh+6jySKVjFfR7Vpp+gjul97ww5THyr62ko4wncNFF9jZfA7Ua+J/HtQP6bKFbNLdywAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUo+Fw5m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUo+Fw5m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPY6q2sc8z2xGg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 17:10:59 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1626269a91.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 22:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794377457; x=1794982257; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fK4euQL/sXyPal5+J+hrdUFIpsb4ZufsR9tCvoLGNPE=;
        b=tUo+Fw5mnbwCDnfFN+iCjIWPR+PNFYPXgelZH8kmT2FAQfcsDr7rst1cT/LAGkhxug
         j1JrZxoYpt4olqSYCBwoSb+WDq2LGVyaslRQGnG66xQ3XYiJl87ZON5cNW7+6h5LpFsQ
         LxZK8piF9fDVHNS3b2I8Oh7S9N8kmyIPoGkYxb6HUN8/0h1oofM3o/zDj421+lo7tLMb
         BbTZE/Z2G5ZrwcTDVAoJX6WUosmG17gr+34XW4S0Pa/GTQsi3jB8dE+dHVzBkug7YC9a
         jmCu5ER5aoDZsBWzvPVqQaZuTkUmlG7pDGw0DrQVJh5h1bMGDqgls8W6NL0En30e5W9i
         vHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377457; x=1794982257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fK4euQL/sXyPal5+J+hrdUFIpsb4ZufsR9tCvoLGNPE=;
        b=tFdrC2Ww0hYLu4vr7yTDldfgE5hWMu3XEayMaNqx//RUt5ngGx6fnM8wkfAdxNHK3/
         5t37bdWceqPsHQnkDNBvvAAdHWr4TqmGPqJ150d59klBizE8JMhOHtdwdFB0mfDlCC7J
         QWUSuM2itWrAM1hOaGdtmGi5sizM6gqalP8sPhgcNHeafEtKXJ3aQ5uVa3UfIreAJEUE
         KkyNLg3tNqDJ+9Y/XU6a6DZAEmz9R1WWxAx9QGX9WvDq7lVsBjppM/VOkQRuUOHIRSUD
         a/aCT5SlQjv5C1EzYgbpQ6rjU7M+vN9OA9VPBYpqsUHwZKmOZN8yCPNro40xLy2sn/yy
         Zb5g==
X-Forwarded-Encrypted: i=1; AL+hErHTA0MM07lVuKTS88rR/n1WpfkoiTNTN+Ovg8Yiovs7sn/Wncp1yfRN8yBfth0sgBu8bHfUQ7kbZiGvvN8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+9jhaXjR9K9JIAiw4bQeTQqvLK8zUPloLoAltcqN2NM5dFGN9T
	wBeOwrel/CSEskIarzOa6o2NB7qTT5r9+6uK/8uQCqNi6ISlT68x/q2i
X-Gm-Gg: AYBFou3d+eYTIpxyzzr77b5/BQ2tkcwamsFsO2nAO9hJ4c/B0U0JB3It+AVtgz2Z2R1
	8CUWVANMYuTRgbG8mnAeAxPnCD6pABAQYOveohHGTuPpUsSEYhs98eLqq6twBgmOTAQgNX0eGkd
	z5b3DPSkL9qDrLmAFt3E3XHrZKSyC7DQhKtdNqKD42xPBdf7wzOnU1MqUjsiExTGs+PCSKft4g/
	DrpKUlBcffnM25s+ov6xBqNTRMFawdpsys5CNOL6H+Am7+vKJ9pdY1+ml51qgcaUBlS3ycYuLxx
	7ayYs0ch/iycV+Q3KM/L0pmFvQvp0GpDbxkL9BOtnHYUHlWYArzBGdc8fsoa07HuD11cqcdyXPW
	LceFX6rnR0Hcrhls2a23bd7he0PQp8Sg8UXS08s0C9SBgq2bPpLo98lN+l0j/GycB0Ngh8zhSQI
	U8zGhng5TtqYRU8HJAD6yP8RdnJ+RoPyRuLhwzBhQ6DbKFqxMJJcuSTXK1RBacu8xQwMFRVJukk
	HVvd0oouOBFfRQMMWw4EIe278bIv/N5F9htHuUf8lQug91vlzE2aICAwJwam/dVl4M5eGcKoMfq
	YtMxqv8RHqCoyDk+1bCkdrOigcyWpLmidlhQjzPzpF2IuvGIx24ucJwTzhu0f1hP/OD8
X-Received: by 2002:a17:90b:2e46:b0:3ac:aa8d:19eb with SMTP id 98e67ed59e1d1-3b182e0f256mr1318971a91.3.1794377457428;
        Tue, 10 Nov 2026 22:10:57 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7e8b1sm2978557a91.12.2026.11.10.22.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:10:56 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Nov 2026 14:14:46 +0800
Subject: [PATCH v2 5/5] ARM: dts: aspeed: ventura2: Name the 88E1512 PHY
 reset GPIO
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
Message-Id: <20261111-ventura2-dts-update-v2-5-bce5b5dafc1f@gmail.com>
References: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
In-Reply-To: <20261111-ventura2-dts-update-v2-0-bce5b5dafc1f@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=xxMp1/Ez1x0+u4gEwcM37HZ9S+6j5lTG4LB8OtJfTVM=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq9Af26OzcycIkzFNsHXF4FJMNd5XIH5LUASwIA
 6mD6yK5pEWJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCavQH9gAKCRClg0K3CVbE
 gTq3B/9YCHNGgux2LFrmmQhjhNtjCf3sYPpiQCl+wbB3hl5P18p1+BE5tmoWffF8zEbIEKFp1Hv
 Muo+kaAZc6Thx/QsJRcIw9MOsWo1b1WSIBjmYzbdc3uw5wB4s3hdzNqxyZVfKShvw6+238sUSyh
 QLYHpqe7rTQJprLHTtyA9qKJ7EYSckZwx/D7VkPys1Cn3AveHyIChLsITJ/cmhKUFI6bTMTt+J/
 O1SAOCk4wMJHgCLjMaTptjyC22H+MA61k8WCHvULsm3WWZAz1zWZIOh9hdBF/tegK/YTW29XOY3
 K8jE3xCp+6coF8UfdN3+njmgO2NoCDOoUYBXeOpg5lxz76Em
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Line 10 of the PCA9555 at address 0x67 on I2C bus 10 drives the reset
of the Marvell 88E1512 PHY. Name it FPGA_RST_88E1512_PLD after the
schematic net so userspace can reset the PHY during network bring-up.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
index a5e6cc94b280..aa83233f1710 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
@@ -2486,7 +2486,7 @@ gpio@67 {
 			"FPGA_TRAY37_PWRGD_BUF_R", "FPGA_TRAY38_PWRGD_BUF_R",
 			"FPGA_TRAY39_PWRGD_BUF_R", "FPGA_TRAY40_PWRGD_BUF_R",
 			"FPGA_ISO_CARRIER_BOARD_PWR_OK", "FPGA_UART_MUX_SEL",
-			"", "",
+			"FPGA_RST_88E1512_PLD", "",
 			"", "",
 			"", "";
 	};

-- 
2.34.1


