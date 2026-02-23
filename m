Return-Path: <linux-aspeed+bounces-3544-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D6EEC2A9
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:07:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKc1N2fr2z3cBx;
	Tue, 24 Feb 2026 10:06:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::641"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845482;
	cv=none; b=l0itH8pJ0y8wANBoPpX95ZqNAEmKx6IKp9YOYQ588p8dXJVmZr1c5KnK22dhx21BHOiNp4jvsbsiQHPcsaqCFP+UEHGpnLPuvN+w1mFGJ1WQ5uz22UDUtIs9Uj3hPQs8P+oPIHrDaDN//w2lPTnQE80LV+LGl51YUTiT2ky4+auYRFkFY6wgMyGxpbeUAMlqU9dofv/mPmgOpbilmUXxs+cPC9JO2JkpsSWWTCP40z3Ijy0CsTOw6StDuhko6RBDHbmcHKiyVQS3oxkPyEb2lVGmw8P0lnosXP49UZDT0Px6D7HrxsziVmcA9ythEvEpRIn7osIPk9BFmH67W3w4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845482; c=relaxed/relaxed;
	bh=DDyXUHId1Z/nYWBwHmfSalP2sAsbJktA9TnrtpJPbyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keiNz3V47yxmZsgA6BvdDRpv2ETxBLXkjy3GzWdwLBDQCBUNz0aSM7K0vuxwyDsSWvhKq5xsq9gifEa1OW3sMLTRuNBdIfa/IRmDpR9UJOJa3yheR+wGAJWxAScbKWCFlWg9IYj1NQK3PWAQEPFgEupeRCMXeCf7T9zn1yTT2mlP1UWjuhsqLuSm+mH4EqDR+3aH1+yXBdIT5ZADw70Z9Sye7ojTFc0cJQBNkJQXmLkJA7/qsVtC08+unAEYQCjaHooM/deGDa8ZGYq7Mgl9UBvXo94jCBM7DV4MPn5QSPDJFN8fobgo3kC4EPWTifWBsRz4a/M2lU+zmAIOGTHwsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=D4SgxolO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=D4SgxolO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJHZ23Nbz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:18:02 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-2ab46931cf1so31585065ad.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845480; x=1772450280; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDyXUHId1Z/nYWBwHmfSalP2sAsbJktA9TnrtpJPbyI=;
        b=D4SgxolO3OxfRbKis7S4WzOUeEPylXhEIkQiEzbSzOFihGSuJ2hmdWDEHr3y0JIk1x
         qv6tAZbePvCF7HwFuss6yAyPuZAd2I9kgx1X6VdvEZc6Yai59rjBj8tcikmccanJHE4v
         7uuRFwAUvxeS4d6fHU5g5rbCVbUdCpBk/He3p2Nwjtml0MstoLON7mRwRT5nJ8NvGPAh
         F+qmu276zR4Sgt0WYZAdXmuM+jHQxZMU6979l7MTPKDnWfHrhr9fdA4oArWbDO03DKCg
         XrXaNRUVhfm7F38aWbSPk+c9RhPDrxYqUBWv7pJQdgSkYm9Zb4p88JoklWPFrnwcvfn9
         zbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845480; x=1772450280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DDyXUHId1Z/nYWBwHmfSalP2sAsbJktA9TnrtpJPbyI=;
        b=Hg40XzISHvtRp5Nztitiv30DUnA64hFu75T2zstedLao0LH0Eiwmqt4Fucy/Cgpq6U
         gili8pmy+x1prxe3pIza4xQrgwNKXbAqM092erRjvE8t8+lGpSanbMx/mry2qT3r1kvX
         FjM1aQRCcNV008LJN+hT5BAj4do0Klk2D+yCnE7JjRe8mfnSKMzBmRowJ9d51yA7y8nx
         TAr1AV1zqkbSlGR5yvCpU0r3GsIPdeyeilzKiUQPdNCLv01HkY6a+ni6ngA3E3AuQH1R
         K+XLAIlkfu0HHNo4wL0t8dMah8Pv6Ofx/dYyOP8oELNMrXEZ95ZIHW5ajX5b3jNn+7UA
         YuJw==
X-Forwarded-Encrypted: i=1; AJvYcCXz9BZxGUW/JDB1Lhq/Vu8M9KAW5+3eSTLx4HJAFloqSSP56RtauuwEDZOnkMH7v31yk9wJTVZDDMib98E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhtP7LrYjABOCIF2MWOGmoAgHi5lfeKzKZcM+ekRH93RTKvmV3
	YbI6TZyZ41H8Ab6N5XVp9rITRxoLV0vBJKEWqEgAbpsp321dBDLji3Va
X-Gm-Gg: ATEYQzxWR7UpKVi3d5gmQk72kT3WIokx99bGJ3/otvKY8gHIvK0S98+BT/VaMea6cPB
	q2264mjFbRklyh8ozJZhhiU7Ls6K0jQX88bUbk3HIMTDj6pXRhtfUBV2aEpuzo/iHBERDF9o10O
	qsnj0lEeHGhQ7niyuFO00KFhMW1jN6x+aVJcTCyyq3pR69AcGmgLgInQ2eDjrlexkJHS3WFfvlU
	UAD9Ocng6qXXKg7LeP25nKRs0v/c3v9DKsb+Dqtk89JjsrvhMUydl0qFTF4DF9P/5AozdIgFpTG
	umqwU91Yr7Rb9xxOlol5Knjmp74RNGslUVFvCg6ckpBNYrOkTbv6R3wKeqCUSnhm/bJwN6kvM3J
	t5pgrydPb3Hqp7oOsK+oaV3PoL50S/P4nEmMVxHVR3qPu67jgVLMU0y6QN0zcdjQWxv22v5Q9AP
	yic6sIwZgvMSv8Y1dale3RSn/PeR2Wlb1yjRgj+l7fA2EaWdfVVILalb/oHKPC46BNzMo7qYGLf
	jhmrS3O4GHev4HbpBSyjq3f8MW3prdZlC5mh4uKPzlt4V5DsXqj//uXFWbzioDspAEfyNnvX2mn
	+vRUsqouHD3GnIdFM1N2yixOhMvBr5U=
X-Received: by 2002:a17:902:e851:b0:2aa:e238:e20c with SMTP id d9443c01a7336-2ad742acbf0mr72695315ad.19.1771845480316;
        Mon, 23 Feb 2026 03:18:00 -0800 (PST)
Received: from 2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net (2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net. [2001:b400:e3a6:b683:40b:c296:4cb:fbc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm71799335ad.0.2026.02.23.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:18:00 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:17:39 +0800
Subject: [PATCH v5 7/8] ARM: dts: aspeed: yosemite5: Add debug card bypass
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-yv5_revise_dts-v5-7-fc913e902488@gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
In-Reply-To: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845456; l=1580;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=qeVbrH9h2lP2i/7VhrZSt6TtWWoZ4Z6EMuUxjGVFuDU=;
 b=mtYdAN+CZ0MwbFt5rxjjKWwOf6MvRuhPUHRoV3l41gXRNKMx2aSxbUh/32XmK+5CAo20PK5fo
 UkRZzzPDHZVB69NS1UQa42rokr1SCrzd+oEjqC0iUwPy13XEEn8Wneh
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

On Yv5, the SCM CPLD bypass OCP debug card commands to the BMC.
These commands share the same I2C bus used by the BMC to access the
SCM CPLD for firmware updates, which can cause bus conflicts.

To avoid this, the SCM CPLD provides a bypass control GPIO connected
to GPIOO7. When asserted by the BMC, this GPIO isolates debug card
commands and prevents conflicts during SCM CPLD access.

Add the DEBUG_CARD_BYPASS GPIO to support this behavior.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 30fb41fdaeb7a2276cdfe98654696a16cf1de5fc..f590ec6e00c48afe4ade1fb98011780ac0570e7c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -166,7 +166,8 @@ &gpio0 {
 			"led-postcode-3","led-postcode-4","led-postcode-5",
 			"led-postcode-6","led-postcode-7",
 	/*O0-O7*/	"RUN_POWER_PG","PWR_BRAKE","CHASSIS_AC_LOSS","BSM_PRSNT_N",
-			"PSU_SMB_ALERT","FM_TPM_PRSNT_0_N","PSU_FW_UPDATING_N","",
+			"PSU_SMB_ALERT","FM_TPM_PRSNT_0_N",
+			"PSU_FW_UPDATING_N","DEBUG_CARD_BYPASS",
 	/*P0-P7*/	"PWR_BTN_BMC_N","IPEX_CABLE_PRSNT","ID_RST_BTN_BMC_N",
 			"RST_BMC_RSTBTN_OUT_N","BMC_PWR_LED","RUN_POWER_EN","SHDN_FORCE","",
 	/*Q0-Q7*/	"IRQ_PCH_TPM_SPI_LV3_N","USB_OC0_REAR_N","UART_MUX_SEL",

-- 
2.53.0


