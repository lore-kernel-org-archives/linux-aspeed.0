Return-Path: <linux-aspeed+bounces-1844-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C69FC87FD1
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75S6rWnz30W5;
	Mon, 28 Jul 2025 15:56:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682188;
	cv=none; b=Vyc1xZS+g09+8Hty+/clECrvMLINTmSjFGulttnrN/g1cy+KB28HI7/HFQePYXyKEVmm8ctEsc4dZwGQehdNBaoJXYU/Ep7o+fIPSpcPTKmAF6sr+X8MpTKupXIg2xuQGLrvhI1/hbKf/uZapjlcXPHpCt1WatB9aYDFNUcOryIy6wNq9wBpOLBmDugC5KKEDg7ShGsFH+xoY3QFxcwcGWXBrkyex/GJgCfq80Jm5wSgge5GBDWPAv/+uhL8yk2oi27JZKf7v+xFWfsWPGhX9LkiInGZSDTwLqsD23enY+Hw8NGAfn1PZSZV7AraYcBg3TghioS+qOiTYbwDRIkrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682188; c=relaxed/relaxed;
	bh=0v1yUQUeQEzUoSADn+AjVSEy94CHuuV2CUdJl0yjuIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPV8zyqfatWuqF9hJH25gSuxhLf/YMx8CJnpXRN4d0NNhfObxvgpd5WA4EQXnlvwSyau+k9k9zroUMDDM0hmrXccPenF6TlgQqcGwhLPs9kj4u8FLkWMDO52vCoU/XTN0XLuHk85NEhbU7Nk5Tr9b2tsZfVWrfIREpcYOnLRA3oo/ZRiY0ABlfuAl3X3zj3Z6fyjWu1uWHoc4N4n4To+vBUv/2Juaytw+scPGvtCe87vGG/tLfzTDMayIXh3V4lIi+pkGPZGV/XOX8CfyFw9DchAhRIGZEu5KuZulNeVO4D8uLK+AXkDSUO6OHZ6fau6uRX4fz/BQEnwMXYxGwPyQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cJQEd8VO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cJQEd8VO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75S1QLSz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:28 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-240418cbb8bso925595ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682186; x=1754286986; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v1yUQUeQEzUoSADn+AjVSEy94CHuuV2CUdJl0yjuIM=;
        b=cJQEd8VOFMUkYmzIY1h3aACwsFyEuvRyY+aqIyvFrpJ5GiYQbZdkZ8v8XMIWQyDC9M
         BUcUT07dCYDwbyFjMGQDqKFJYQXWj/tbSsxKm2WEsU8d/4Oc5od6CRL7WMedE9UJfdaQ
         I6hHT41TTINRxU7Hq1caTlTfbFhsJqS3njRzL9bTJ75e9bffKf6VNpQ2ziO7eWTVklEg
         YdqhR0798hVmEbLviBGsu7k8L5D7Uzy/7OqJvHMO8GDUKUOsOmqE03wN1ItGbkgPjWHl
         i6CnrDG5hgkHHK5oBDscLeIZ1NM8Sta2Qchz25M3UpvkBLHBVOD7IJzoLwZ3zLoPNRfy
         OYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682186; x=1754286986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v1yUQUeQEzUoSADn+AjVSEy94CHuuV2CUdJl0yjuIM=;
        b=MtwYGbQPZPJdEN2mmYa02QH7ed+Kv7qCjMb3XvDjpmru9KRPNhjwKYsQ5tkn4W97GP
         XG9xtF8pVFYjaBzIPKmgrf5PN+b62jXYAzIw7B1KMWSONn0ymCL2RXcfYU4YKx8vQ/dG
         gthDNo4jZ4hFgYbidRh41jXUSvrZK2ZBMd2K6LGAfolo6QzFDGt8tv3OBKiYJ/toSWRU
         LS4Abo3KaCjTcxi0leJLAHZAXx3IWoYVLBOFMhZ46vICy8OcNyZYx7qlmF3ud2m6gin9
         J0cE2ngUajv+fWtrGQqE+YURnQ8SK2kLHLoKpkzC0NPjzJz4F0sPTZpPdMFcc6ALlii2
         6p/A==
X-Forwarded-Encrypted: i=1; AJvYcCUuobYUMUikKIDyl8LuQ+NjL6p4I5+O84WTfUP1jEY85uB0iLCDYWGfWDiE/S2tp99JEw0CCXgV07rSGTE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwD2m0NCzOg7wgek9YAhR3cbWgtvNzdeC8RjpeyTMosMztgaIpA
	siKJhzSYKhXDZYBjfYwQrpiDjljyeGSO7pFA6k4fnu4EfINMq6ifw3Mx
X-Gm-Gg: ASbGncueFhHuWg/UItTvEfJvwECvdvUMm/EWdwDEA0MYXpTOo0k6fH4btF3X6n9HKmZ
	VBlb9ZkS9WVvgCLkxg+9FW5mOpEKcGwlFsR1cUwWzxcW5yyafkVGdOqyKWI7RCOE31sSLcAYHTA
	R9RtTdldWQmDCvzwAXnQ0Ww2bo+ki+t75h/njwDAVNcXU2uTH/+efl1MdixNKPHFclBU23YQmri
	A71WleagEe36Jo+KPstr0l21SsWo2QP8hxLfhN5ssPoRQNX157KF110DFvYRZGs+AVJNFz2Qx+K
	YpafFDB5FxbCl3VPOGG03ZTI/DL2NgVvN70ysxhL9cdBDlhJwYCSj2fdColdssAoMkTHlzZcezk
	nzpNLJ2ARjYSeUTkNXUOAE2Fr+1oSTxm0g+WHbMJWVs5FGyQoH1iWKHbABituwt6hWEJOhGhIVJ
	9B85P0WpGt/A==
X-Google-Smtp-Source: AGHT+IFHEC7n8+B8Tb7wSp7/znoNLEQy2YYidfHzQJc/uhDuybjOx5iseDVn3XjiJ1+k5dNKflv98Q==
X-Received: by 2002:a17:903:289:b0:234:a44c:18d with SMTP id d9443c01a7336-23fb304fb2bmr160718715ad.22.1753682185872;
        Sun, 27 Jul 2025 22:56:25 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:25 -0700 (PDT)
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
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 02/13] ARM: dts: aspeed: fuji: Fix DTB warnings
Date: Sun, 27 Jul 2025 22:56:04 -0700
Message-ID: <20250728055618.61616-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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

Remove redundant adm1278 properties from fuji dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index f23c26a3441d..840d19d6b1d4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -248,8 +248,6 @@ imux16: i2c@0 {
 			adm1278@10 {
 				compatible = "adi,adm1278";
 				reg = <0x10>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				shunt-resistor-micro-ohms = <1500>;
 			};
 		};
@@ -577,8 +575,6 @@ imux67: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
@@ -648,8 +644,6 @@ imux75: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
-- 
2.47.3


