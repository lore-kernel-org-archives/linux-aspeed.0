Return-Path: <linux-aspeed+bounces-1886-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D2CC87FCB
	for <linux-aspeed@archiver.kernel.org>; Sat,  2 Aug 2025 03:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bv7HW4CfPz2y2B;
	Sat,  2 Aug 2025 13:15:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754036603;
	cv=none; b=J71JU3QnX9JUmlGJqzV/5ERuEUMdmfUsUOI+JjyIyn57pVq1rd8vEaTr+tELUd4lcCZ66haf/8sbDCFJJ28uWVhMh4GnlbBW7ODPuHAI70aeV25Ln2LMZ+yI/27K1YcEDoOhW8MLry+Onwj7L3MuLcRmNPJq9rdN8lOcJvjJwXxCOcV7UTzejENe2ADirStsfT64IybYEgrGc3OuCUwyy1rVXHAO4vmAl2ekyKI6FKTMIjWZVaBSBt+7WI+z7sUr6EOpK1z9RFaZtMtCU3iBX4DyoBx+znQceQPquoU327PxNIQGdajddsQc4KB/0d+qMgcJcc747dp+F+FQlQ5RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754036603; c=relaxed/relaxed;
	bh=QrW+x1kwa+TliZEBde/ju7PT5X6BHW9feGK4JCdzymE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8AWw3BapzEcnr19CmmWC+CSCOkmooH5P07j15VD6IGX1FG02DFvRH5M5f/wLFEq8QMqy/ESxKV6y/Y3bTRbOQiCt8LP8/AY77spqLKxRSKrsPJJ+zmaG9v4KJ9UTD8ldHY8y+ckswRHOwRyj2FsnAdfo44EiWuRDq2dMQKpXNV91urJId+Z5Dm9W3L62O+CJW3OdQpMuWlJnfB8/o+P2UcAFsA8U9dJw+aVrNcPGz7rP6YsghK6Bj+QC4M7/AXHBtezhC4AVFuwWXsivinRTKcdflUdflKl43tmNUd9kk0vdkGo9xDm17lXxawAEl/BKAHORGMrOgK5IMraLNIRfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L0UrFZjc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L0UrFZjc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btf970q1wz30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  1 Aug 2025 18:23:23 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1170891a12.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 01 Aug 2025 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754036601; x=1754641401; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrW+x1kwa+TliZEBde/ju7PT5X6BHW9feGK4JCdzymE=;
        b=L0UrFZjcex+Z2g/Vphv0kmSktHVYI/nQxdnH3imzjgCAKU8QByk2pIBQdwPBWrCjNV
         Rb19yFQZtGFyleuSsYOQdKU1hedDKvgN+mGnu+YZiFQST/psgxCUMHb8kzuP1scfhwIQ
         54FdBZIosazD5df5/RFblzVkHpr+TL3ZLGbxREaL5J0JjL11t55IHo8B1gCSQa+jGWuX
         /jfAVhHS81962pGdBnzl9LNTwhm7ScSfeBUFciSM6iGpD63XvAjhDOa4Bc3bwTJPmsqK
         /4u1nWZNjexPT+uMUgJQ0KtGheelixlQH9oD2Z6Oq59L94fUNHpUlF2aT2PCmocjWW2G
         TFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036601; x=1754641401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrW+x1kwa+TliZEBde/ju7PT5X6BHW9feGK4JCdzymE=;
        b=hFy+VdcyAy71Ytwb6NNKtMtuLdIkCNBAPRFD7iDD46WJdrrjeyuf26ToPx2qQQ338a
         MZChxCy8XnmkKJfK7L95Ri20nJDtmElPx8faoAUKt/LTn/i/D6EuQD3Gfk8xui6ehpgB
         aCSy0S7R3MUws0gN2gEoYyTFdyIvnw8g+3GtokNSyDCkKI4H4LzKkVW5mWnVrLd4uNRw
         FkeQhC/3g3Hr2PUY9sNdys+/TcC0a6uDo/fL2DnG4ApOT3cJSprTFk6EMnxbx0WBA7ty
         Dxs9mQ1L+kzu4DmRbEowwzW+wOjzv6ZeXjDd1OFZf3gB4omEYacDcu5UcC4RjDcseIhW
         Sybw==
X-Forwarded-Encrypted: i=1; AJvYcCXVwawdGdQDJwpbAx+kUwkMP1jK5kKKn39IbxtsFBAKve9KZTOBF1QKqv7+nXA5ieUcwsO+HIWGtpk/Af4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1H3tXy0botuNWskoM7FZvsfWYa5/MCnXbPq0JhRqtZHgwpbn0
	4tBPi3gualf+7uK6QSf28xzXxfpkBOpyu7o7z7axFtfaVDqowAsKfIOD
X-Gm-Gg: ASbGnctRmaEBXA7Gt35HQ6a7p52QtAg1SHch9XwafBhbO8vS9HZt7XUHny2FyYCxpsm
	fNFdBPzhb5siL7/4djKgNk3WbOiYfooLgKeHvBAQF0R/E4MyoxAatyyX4JdrsSgSwV5rjerHtld
	q4Jr6ZSQXIPARCu5KhP60jtY3pVBRYoMK+Z/Rch+vxYeVpRQYlX/zpAJ6W+XIoeIlOl/sJvVg3r
	Vda0wi2hhzmlJQVKZmxl9TzV86YSqJn6f6D4rgzWHIVg4A1lCuOWiktdXcemQsWe9w0dEryV8h2
	iBUQrOV2kmhB0XlNCGr55m0Tg8Yxx8ZQBLqzX2AzG/ozk3N9Zj8iArjkUsoStLpOGe8G+XZBzDY
	RCocMqJO1VnuYph4rlVfY5JDbWLyTfStEYnhD7ARJ0FsBb97iifK7c8bKPWIe2fnVkRI=
X-Google-Smtp-Source: AGHT+IGiIL2eH39WyYmfW50peWzdYWtx0H5u++yPtj2JON83tXPpf3wufQnRVFpTduqX8zM5mjgdBw==
X-Received: by 2002:a17:90b:388a:b0:31e:f193:1822 with SMTP id 98e67ed59e1d1-31f5de4a5aamr16005459a91.28.1754036601052;
        Fri, 01 Aug 2025 01:23:21 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3209a850417sm3992725a91.35.2025.08.01.01.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:23:20 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Fri, 01 Aug 2025 16:22:49 +0800
Subject: [PATCH v10 2/3] ARM: dts: aspeed: clemente: add NCSI3 and NCSI4
 pinctrl nodes
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
Message-Id: <20250801-add-support-for-meta-clemente-bmc-v10-2-c1c27082583d@fii-foxconn.com>
References: <20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com>
In-Reply-To: <20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754036588; l=992;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=0XkYbizVBKY9WI9Q/nF7gZY7Z8IkaJEB3NQ1RTG/C8M=;
 b=yT4zUHaZRPVLgHM5/hrcwMugrlznwdbZhwsee67hhcUXifJSdMZLLxnZUJ4mD0vXlcKfTLteO
 f/3PIDkjuklAKPVwCn+AUPDVPBhMj6vPhHZK3iE/k848ZOE/ZZexxd/
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Add pinctrl nodes for NCSI3 and NCSI4 to the AST2600 pinctrl
description, enabling support for RMII3 and RMII4 interfaces.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
index 289668f051eb4271ac48ae3ce9b82587911548ee..e87c4b58994add33938792f732420ade7ea5c23f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
@@ -412,6 +412,16 @@ pinctrl_mdio4_default: mdio4_default {
 		groups = "MDIO4";
 	};
 
+	pinctrl_ncsi3_default: ncsi3_default {
+		function = "RMII3";
+		groups = "NCSI3";
+	};
+
+	pinctrl_ncsi4_default: ncsi4_default {
+		function = "RMII4";
+		groups = "NCSI4";
+	};
+
 	pinctrl_ncts1_default: ncts1_default {
 		function = "NCTS1";
 		groups = "NCTS1";

-- 
2.43.0


