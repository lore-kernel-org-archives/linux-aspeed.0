Return-Path: <linux-aspeed+bounces-2246-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE7ECAC598
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 10:18:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRZVQ4Xtmz3cYg;
	Wed, 17 Sep 2025 20:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758104318;
	cv=none; b=UU1AncMMhSlTX9S/giipKhMNDKrDEJY3ezuq5ePVj/eUdCPdloT47u+GiLQE+B868IB/4BjE+SoAPJX91e4Xr5pnZ1nhEsqnNXUc+TNGObOJjYeOzKS7esyfOjZsD9+4GHcrhUbslL3l3yyB3TIDUDstF5JvAA27dc4eH3pnDR/7VCAHKWIZkABDUVj8PGjjrMVD20nYSmiaHO4dv8Q23cEXKFv/e+SBLozZFsX6dU0rujOumbkbGkLWIVf0CHUtgx27YHSFITr2Oje4VWuED+puKoR+HVIVUtLs6lMF/H7DJZpYla211gLIIN3+ISbw2gnj539+zHbXaf/tHmfTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758104318; c=relaxed/relaxed;
	bh=+kmbJPIKT2sQhA/vxVf0N7X2Z80CDuvnn3C+ZX1OUAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kebS+rvWVjzO8Kf1VQw7R8o7YrmPYqtoFGIyH5TD7fY7Lr554smMO4dO7AjQj1Ehi/EXC6tbJU3b8Ufs8UeYbZawTrRldXNGWBwFmpO+2sbDlyWBfee9G+RF0hM2sswDFrkZ3NuHau1VpPZWwfq1kWbSrqwryExatIOrgieJJhjbdRtURdq4eN4xp2ttZ/+/DRZYb1qjFB5RdniX8W2EbVyKPzUQ5jpCPcKdMzVn74WNiNMDm7oyXIbXMAUUQWeOdz/9Lt/+gkHy6mX5Wurh91g1YXgVtlpOkIPwTHtu8nL87KY2dr5TR7tWUFjiH2GUcXwOJWa7pCx9fKCSfsGgPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RXugBehZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RXugBehZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRZVQ01wFz3bjb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 20:18:37 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-266fa7a0552so29865055ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104315; x=1758709115; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kmbJPIKT2sQhA/vxVf0N7X2Z80CDuvnn3C+ZX1OUAE=;
        b=RXugBehZ06aSVNp3herXacWXQubMK/SFx7Tx/wg/FsKPHoyxNu9hv6jxhGbkRJVgQb
         g7dkj7WOGcEyiMAwc9snhWnSCKRht6GHlXLjXUzXB3MenwVqP52l4N8kZr+FGEAb4mGh
         54yq+bwDFJ5ds7ck1miW028Ti0K86hvf8gG+idltVo16gbqo2K4BM+s8wDIT6FKOmjF8
         1KtLM1kKp0D6/Qat3/XOYiVwQYIUI4UXuMHSgFnQBUJKYHCaR0sBFzEajNH4mFVaTSfQ
         f9IKHWCq2kYHt7jTFp/HDJMfI+XNQx3hBXvKzAukOJkybcjR4WSk4IC65taiXaLY551J
         eB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104315; x=1758709115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kmbJPIKT2sQhA/vxVf0N7X2Z80CDuvnn3C+ZX1OUAE=;
        b=izX2yj6KE5ijgM2tCpvYqMQsiw6/UPFsNzRSWjTzvvuuuh/g2QH5mJnaEPSwRRwqV1
         Kp2r/4FEIUYdiKYaX5jk+fy5J9Kjsu3a55MczZIb8AKWJIBU799BRS4dF1N0jScWwbck
         KgVQINBW5XSTeSyG1eE226rWlSkRh0f72vaoW1kNVBJO/azap9BMCvGtjem5TBsipjzQ
         /JR0hBlDBnMf7VMBQD5tYONzR6vmsr0gUijdJTnXocKZMfcBI8zoPEd2oRW0FNt7UVw1
         A78V3wrldg/rdX/1DiGuYu8VUyTHoruxVyTw7REQ+a8jfJTma8/m4CPl6gZQDhUdXvjI
         Y4JA==
X-Forwarded-Encrypted: i=1; AJvYcCXnBao+Ezd/LAtyJq7WTrZvuH5duGstRC5HhNPWZBaJ9gXGGHxaLYk9Uxob7uvcFMWNn22h4WSgCY1OXW8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6ngYC6oin6brw5cuZBAKAYJ0TozxjxgkgSqGavZFGAuRZrL6/
	6rtUavOjuqqU89uZ/5J34tY4K3wxcLGscKOHjBSquTydjR9ethsdtNTQ
X-Gm-Gg: ASbGnct7tFPebtcVrFnMXQijTUGWU693CMoUSEKfKcwG+3Evk0oCKQCPe9UVg78iEbN
	sdQgiG1I8LE8E6nClXd7NI4uMO0jJ2PpHN7CDtMPdfqXVT2shl+dp9dAnfaOJeTpsEN86zBo7iX
	Kdo3KxuYngIyKlp6XXzoULZI6+XXsmJTfehQVch17skpYpNTCf5A8404AN4aJwFwXPRZBWEM6Er
	I1UZbdjx6oX89B2nmI3j+jzdE7dj4+kZ53eUaCYhzJtCMi6UmGpkHpyi12OnXgKnApdG+Uei+tr
	+9DBn9XSbR2XshNg3rmwcWXg2Zh6FwWf99tqVQ4f/2jtTk+OMVKqKdugoWaUBw8YD6w5z0V/e4C
	a7fJ3NvpybZ65GA7MF5AaWhvGrvOzDeT8NCUTs1G3JFBcC1up/sDzaQGVvUl7QlNOtdDi6b2oes
	6kTcQmY0lWXTWSzPR881Dtp/gcBA==
X-Google-Smtp-Source: AGHT+IFiUe1D2qnklzbedzK9Brp0DgIaGignG75uAoJrTAq+Wmo3K/I8sMVvXmtJYvF52h0HPiTMlw==
X-Received: by 2002:a17:902:fc86:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-2681390307emr21798845ad.42.1758104314805;
        Wed, 17 Sep 2025 03:18:34 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:34 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 1/4] ARM: dts: aspeed: harma: add new line between the child nodes
Date: Wed, 17 Sep 2025 18:18:22 +0800
Message-ID: <20250917101828.2589069-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
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

Add new line between the child nodes of imux28 to match DTS
style.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 23eaf47a38e8..41ae86180534 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -524,26 +524,32 @@ power-sensor@20 {
 				compatible = "mps,mp5990";
 				reg = <0x20>;
 			};
+
 			power-monitor@61 {
 				compatible = "isil,isl69260";
 				reg = <0x61>;
 			};
+
 			power-monitor@62 {
 				compatible = "isil,isl69260";
 				reg = <0x62>;
 			};
+
 			power-monitor@63 {
 				compatible = "isil,isl69260";
 				reg = <0x63>;
 			};
+
 			power-monitor@64 {
 				compatible = "infineon,xdpe152c4";
 				reg = <0x64>;
 			};
+
 			power-monitor@66 {
 				compatible = "infineon,xdpe152c4";
 				reg = <0x66>;
 			};
+
 			power-monitor@68 {
 				compatible = "infineon,xdpe152c4";
 				reg = <0x68>;
-- 
2.43.0


