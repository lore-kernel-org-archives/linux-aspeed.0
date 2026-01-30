Return-Path: <linux-aspeed+bounces-3450-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403ABE65298
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V570sDz309S;
	Mon, 02 Feb 2026 09:41:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::441"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769761239;
	cv=none; b=Yb/QcHlvqei6Asa5l+Q08chydBaGueXA3755oaZhVd3x1pV9fK+MxZ5kEj3Gqbu8AQlpgsO2TkbJBckTzd2mr44Skeqsb86hxy7pS0EGi2h4PKDGLwlMwvReB9IhbQ7z1CspEsDriBaRSkT/ExzLOnaZ/gNZWr/6tyCt5EqHfD9gCAqcx57asb/W7Uzz84yqalzf4N0J6vJyOdwjYpwvpM5egRMT788hADzI4oLX96YE0wR4Zemxq7UmYR3OQ6LDVfbJ5sy4QzHZtUDwxvvwx1u4dRh7qAHg/xFW1vX3EbuxYKmcszldIYE64M3ozWc+y2p+eGWZLYOkfUGZv9p6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769761239; c=relaxed/relaxed;
	bh=Xti7XG40UH6O6PxwKMMYsKnB+u1Uo2o6K+zvBRm+Q+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6TMkksed3lKcmqeTTW1XlLA86t8R9/ZlRQ+WOekRFNzqS8adJTGQzFGZqcGF6UAVQnmMsilaRbpXSSR6rLfbaIVVaEfRA/qwPao004/B94c9pK9fuh/Iing0JTvWQiq9YGE/KtZD90qQlG1vICafTE+vfHrTN1vu+GPmAG0P4YBep+GqATEbJVbAWaqVrxy5fNrtTUYWZxSZM7fQkoxpQ9wN3BoqeTjR8pB4qjxIrv8Z/9y3G28YslYpSg0YliBc+yrqqxQKF/vCIFPQ3o1YNomyEdYCBZbUHU1+5v2x7us54O9eLZlafCkOnzSi/0IfPbpapXEwhcml+1uL2zVdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hb6hQAZb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hb6hQAZb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TTy54QGz2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:20:38 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso1153954b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769761237; x=1770366037; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xti7XG40UH6O6PxwKMMYsKnB+u1Uo2o6K+zvBRm+Q+0=;
        b=Hb6hQAZb24HyN0LldGgVB9GJsiPpH+cY4vde7C8u1bVl1mQx2/l7iMsqdQZcikH8uU
         OVsKlKmfuumyzT0JdalOWAQbkD3ppIIc3gxW4BnHRJDsej5BIp5WBbt5si2kHMp8BZFo
         CiIShmhFzBKFpCLXlrIpu5FnobUnF/prVH/DGikcY56i8YB9nXRkWbEsRUI+2A4GxNfR
         5/2XGPa7iC+TX5atuTbZ/Jsl0FyqDe4C5mDz9y1OU+Wi/sLdN8W7IFqq4MITL0InuF40
         S7WcekD9ytdsiWm1o/W6j9lqhqkems6kA7+1E6b3bSnLljOXD/uMgdD7uAZSDvwtC96B
         FUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761237; x=1770366037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xti7XG40UH6O6PxwKMMYsKnB+u1Uo2o6K+zvBRm+Q+0=;
        b=mOe6lloYZyg+Men7pthMAkXQ6Xem9QlpbmEx7iCQKTvNo7lNihFfgljTgTSLPsnzvE
         m74CX/oxVmVsnFqlHHXLwe51qAg9fcMc9oYgQpF1WLRa8u+bjYtTATh13ZUTjC07K4c1
         paqXMRQ2g/j+wZFZ1kxNAwo/PNioJwpIiWuGbr/TOcyh/McaDfaxEFbhNauui760jxNk
         u4hhiWaJN+lynN223/ays3kWHVVYRM4bP0nuGEkJsS0DigIWAshuR+/Qx9eGPNiH91Af
         Dgc4AEKWnaOlTndGEKaEvdOqvpMZxa4e30q1Dsq0o1raMwm38FBDSH5+YxeEqgsr6rca
         bd3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcz7zghHmfgoQT4oVuUnrjtehX85QieegK6cXKD+5Ms0NwuuNR4ATax33r/PgM8Q5meSWSQmOynVnCkBQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YywtY9HQTJ26MV6M6l9cVyqv6pPkIINnDPc2drkwTMjfeqBkY3M
	3NPtBFD8xcTnC7QqG+AFXe2EEwZ13ITH5FrX1ZFHjs7tUGomeDTwNcHa
X-Gm-Gg: AZuq6aLu4LHfZXb61Qu40mahCIStXBhuCB9eEi+9Af2Xgg127z8uzEvgF6wPpFfaJpe
	JFy+RjxDDUyt6jJFWJhugn+r+lOOV0jpIksF0t77WEL8pegrxd2Nsw5FmlIGxCa21nnpA2VpD7J
	1FTvdBfKsF5VYxU7fv/U/OFBC6MrdsKgv+RKmSSpF7BSMhjxvTO9oPNRjvWYhbMA+ogmPQAg5Fv
	Cc6S/8sOVuiQx6bP14ekbeT5yB/xm2ytyUQCz2iHbOmYwigEqwlMQjWikNIpVZeKpYW94gOeFaQ
	YCKJU3PqQ9xM8WIx28f70cEsk2a3lbs81QdEhHYfJHFjjcJRjA3Gh9Ed6llXy1xQtrlVXi4gk5p
	SndVGERHk0dqaiqRCOeyIl63PJDHqgqeLTMXpCnj2GttgI+PK2F5s1g5f2CTzmQ0dCIT2w0A9H0
	Nk36wYqYe7uTp7kw3Dh3ByTY+B6h4BK69FV7p/h8TmakfskuSPI3y+tZ22la15OqQypLFraWWWN
	0jLi3n0vvBLfkjjCMNuEt+VrHSNbro7TMFCAeUpiPRGQpvs6w+6UU70TyjB+sf7h/yVbQvSlfsv
	aPA8xptQvssd
X-Received: by 2002:a05:6a00:8015:b0:823:1570:1e81 with SMTP id d2e1a72fcca58-823aa931c1fmr2112930b3a.53.1769761236703;
        Fri, 30 Jan 2026 00:20:36 -0800 (PST)
Received: from 2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net (2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net. [2001:b400:e3e0:2a58:5bcf:a65d:c80e:2087])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm7866018b3a.40.2026.01.30.00.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:20:36 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 30 Jan 2026 16:20:15 +0800
Subject: [PATCH v4 7/7] ARM: dts: aspeed: yosemite5: Add debug card bypass
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
Message-Id: <20260130-yv5_revise_dts-v4-7-4d924455f3a7@gmail.com>
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
In-Reply-To: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769761212; l=1580;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=e4DAb0AqZOq3AWW4s/35NURRVqdT9q3pcfBbOpjvHRI=;
 b=yNNqOLbWXzjovfNGoeiqX69Gh4ImH0IhqpGS9SQJLT5J8mWHP8GLT7wzQeD3n0ODQnXvqfxFA
 zuNXkioHV+6B/q378yqFfgfHcbHvMvs1UeN6YOZWw4vWEQGt3bxi+b7
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
index 48f864b52d1a22b12f8a39ba9703a90349ed930d..61e78d5e712ff45e1a0691979b9b36408404cd2d 100644
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
2.52.0


