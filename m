Return-Path: <linux-aspeed+bounces-1079-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC6C28B30
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTs03xkpz305D;
	Fri, 21 Mar 2025 02:24:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484276;
	cv=none; b=oJCDdKFGYBehk4tG/xV2mj+9oUFGHLsKobMKkum1EOX4E838jzRIlZwdr2Rl+pQ//L7FTE6j1Bk0ytimqnNtn1m1T+YO8obe2uPGscjppSy2HBHDj8CEbV6+q2Y7Y085tCmWNJTjxE34pZ8FRla5HhwlHFJui1PB6pPWACAZiYVJEAc47JUCN7N3YG7geDJ+wJWupdwHLDbdxU0JdexjHpYvEuJ0OZfsGt8t/M14UskVkjGZoYhYIrlkZ27KSY+JuesTBey5Lj7ZZhX2Ia2YR49VV2ZIXiMMRx+nmNhf1jjmGhjsD/u2GCjgFxclm0nrO6ZtMdjfEQa0O20EHR96PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484276; c=relaxed/relaxed;
	bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSFzK2OTZt5FYjjZ6uznAuB7+HuHnfp3pAda+9UXXlUzOfh6Hf5qe9E92Mwe2LWBNERVq/s2BYWMCPHnAwGURSvdgtr8IGshZjShbriuqkf/lFt6L54kSdV20KeKBfHsCBZuPe0tsbT06rsULamoKCMhZEJVI8GxJtYEPIp1WiHB1KcQvLvpf0wRFq/tqpAUqLbv2yL5AMAKjqArqAtIKf+Tt8vHTL/Q5XziXhbwSWqYPKDcmY/k/P2XkMymIn9NZ+oXPTMMi2c+OUohkdZbmAu1NMjxoLWU8gb366DrqweohDgZGQFVx3hyGwPfKvlrvUrDNk8ObEZf2rupjwLtoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HcStSwy7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HcStSwy7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTrz6DQzz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:35 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-223a7065ff8so28667695ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484274; x=1743089074; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=HcStSwy73kkntcSTiidMX3LA/Cw+GPUsey0HGX+zgZWZ4yVnJvKMK3gQ9IFNlzNnz4
         kCojU2QXshgCVpvva/QU3xsbHDb2LGMLoo5fhUg+bbmHgOUvcfQQ9KWjT/14nqqAhDJe
         rUAcxbxnx3I1p9snSJZ0geBdpsc4zB4d2ZedGxNCBSeIEpF0Q/0KeRGPE6Cir3a/Zkdw
         QMCT905KAycapeExPU1kq4ZKZICRpCxDjS2WFJl451tohDC5D5QsjE2UNUc3wXRB20ya
         1/8FJt9zvXI4xIe5FpXbN5RfbTEIOZywkdlDKwziVlCqepTjb/z3+ayu1vIXGi1W7tPH
         0c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484274; x=1743089074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=J9jTGW4Oz5r8ecMeqFJmvdOu3D4V6Nxf7TMw2k7QM3ymxv9ALwFpasPWfBvUjOmguA
         MRss8kSwvcH0xK6cUwnxnWVMM/Qd/rqF9rxAnucPDwhrZbJXQfq5ndFCnOQbWfUOIr6o
         V32IBynFwUKDYKbntIwCxlErPZg3w0ly2xZIRucYJ9/1sq/026pUAqJMa/zm9Uca/O9A
         AgThmCrdRjmoPYz25/J5ZhBs5pw/RC9T5BbURu2CHSECS4RkRV5ILq2DCcPQdsRjhCNt
         Txr6rwwiZ8qWHqAkfOquMQLoK7i5V3xEn86MYwMv46d6awKwcs2rreWP++qR2EfNAbCw
         SKHg==
X-Forwarded-Encrypted: i=1; AJvYcCXHWzskzbYcDxF46Wd+hezXKhvKV/0yg2lER9XssIkCgAqIxm6KlPgipBuYEghwkQr/tHZyYZG3crtF8ZE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRTg1h7innFClYZGA0xq3XXY/ri6QLYsJKWSKwwlLAYI9BPC6v
	q2Zc1mqloaY+4o+WwFDT/1scIGtMfuZHMpoWKG1VIDuPcci/kOSo
X-Gm-Gg: ASbGncvIHPYbgXZba2s1d15mCHS1F/HT7znrcS46lvRgPRtQpZ51L1FMdiymkgjw8Je
	dYby0tfw6gXAvOx4T+T+GoX7k96y8H3ogBhPakWV2T+vVOkVDIIfZPidIZU7f+ZFPbOuaFEcClQ
	0u8fnEBWs/nOsin2r18nmnT0hJj8z0YdNxoNiOn5dCw1gQ8pMD/hZlEE9DoTvON77JJhGcrK9o6
	CfSSyXG5SXx0RT9ynqgK6P/L1kw6f5J/fCe39pxch3IeDea3cQqmkndlGZc/mRbKYUTdkCcp5u3
	eqirk/YaOa0S7sKmOj4exLK5myoMGeMH5oqjACSM4GaDQAjq4rgDGA/S5r6OypgOcG0eZdLPKSC
	i4mbg/gAGB6iUmLIfmsfGiM4m5A8sc0Oy
X-Google-Smtp-Source: AGHT+IE5GPeE0Om0AY9fiRC5tRfnAcMPwqRX9hgQMpQNbBBAF9NyfQrMJYuDiGjFwNp2dwrDmszp2w==
X-Received: by 2002:a17:902:c40a:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-2264981d956mr117068525ad.4.1742484273966;
        Thu, 20 Mar 2025 08:24:33 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:33 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:52 +0800
Subject: [PATCH v5 02/10] ARM: dts: aspeed: catalina: Add Front IO board
 remote thermal sensor
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-2-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=882;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=P26V4Vll3LYpWjYPKGRYB+hCja9t6ZA02VGXue+Ra5U=;
 b=/XN3QQM8+yPF6MUoJ8BkER6tXXOOmxvF1ngqIsnV8HshnT7+U5Qx3O9tBvAjElM3CeqsBdvhQ
 tNVb5huq7oWCNJUZrqPv9olH4g3qakgYuRJiGu5KgpgYker+N8TZZtV
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a remote thermal sensor node for the Front IO board in the Catalina
platform device tree. This sensor enables monitoring of the inlet
temperature.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index d5d99a945ee4..307af99e833c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -544,6 +544,12 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			// FIO REMOTE TEMP SENSOR
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
 		};
 	};
 };

-- 
2.31.1


