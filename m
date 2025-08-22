Return-Path: <linux-aspeed+bounces-2034-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F47CA0EED
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 Aug 2025 06:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7VKP06Y1z3cYF;
	Fri, 22 Aug 2025 16:15:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755843304;
	cv=none; b=nZvi3WrjRzA7aA+p5JDnr/QgvRY1r4qhzrjV/DCCEglZ8Pw7b0RaOSYdg5yBtfts/jPBuWcl0bhKntOdnT4jKvVSD0OwHxBzyRI4WGvql6kDiASBOAfBbhNfVsemhR38pqr0gC6MwLYKRGf8cRfmCS9kyxpYkkUgO/VMemTiSI19F1cVhE3M+RYe668/l11SbDVbWgBCSIJu1Fr7xDkOesWxcE5iWzsTzwu+XdNXXFseLaG54g3SWYMC7lWcNElGwvi9BHlv9AaFRnAh+D5E2wEH4Dhmk5LdPfjMaKHTpCEdQXXdU3iN8MQUI48eeHKlmEsaoBR4BH9WUWSaRxqQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755843304; c=relaxed/relaxed;
	bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+NaXypYB2tVCGpn/VQKwY8XENuE8t8zgbYloBlqgYXUzacoabfc/kwuwSF03VtHM7sDzNdkP5A9A4aAc5jw8AuQLbwNp9wnyaxMPZz7Q7yuuAj67qy9zy2xJ+I96skQCtShzO5IlWCe92bt3R0X7sBwSXMLRGhfuOONgoaQqdFLKl1e/id/fGKPZpusIdH/4LNNZ5LfM1Jfy+0inL/rAdlR3DKz7FMWQ1///zgVZKCiQOqVUXcJW+hnKlkfvW083mVfCzqsATWPLBrhx1Eaca/d2WNkHaTWs9iLCGCP5hTCEFbpXaARfXSDKvinxMgdYs+lIdt1Hvg5aC6ucrt3sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k7iOMaID; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k7iOMaID;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7VKN1h71z30MY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Aug 2025 16:15:04 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-24639fbdd87so2499405ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843302; x=1756448102; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=k7iOMaIDdGerSLgiaF6LA/HcrsmTZz8dbImmTwW0Q4wtoarjEkJOUZbIfj3657iTMW
         ABfzC80uBnFYjGoQvoGBpV/BSUrxBLOnAMXbTZL20ZFJfwuA6DHzAUMgfo/PFlzNs58i
         AwvNI0WVk2hRRq53h4d1O/1Nggw6Tig8tLaLRNYweG7y7uKX2vEriI48Rj4va7KEU6qw
         8ETOKQd7PvWYYRvCrrIV1RrHXQlycJj+Yhzm+ctUFxOYBMqG7H1cSfIkIBVVixRPMDRZ
         4pGQqP1oKXVrgAvSXtPd2Q4URewpxMAEAAEXWO3+sQIxp8vYnDPneigkHzoOtcyH3i/q
         K2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843302; x=1756448102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4Mp9ub8voKbHs9L0zRZ9WclG4wR0S5cTRrb6q1ZcxQ=;
        b=HGezy6JUmt+QBTdqjUTWizDk9BbEAeX99d2hthTdnOfo+FOyQgqSpDkR0c7nsYJcyt
         L+u/yP2Dwt21U/1L/XBpNEJr0OWIfL3X189P9snkBYJw9xXZZztZbyOHmxePCo9bcmri
         sr0CIf/6qGUlb/dmQjhPpyxGMqwGljzloBHicjDZsOhxy/tHhfZcCzgBRKQu9VZ1mdLB
         wCgOt3WbNT2rbkdsnlxgUAmO+oBzCBTCG9qYROokxOcniH+8cVTkTe7zJyteEZw/tfKB
         KLXaRYjzoIsLoCdZVUySGGLegYblYEKpkSoMeG6WfreDXVPGjSsjHiAq0mwiXcUTEPdl
         1hBw==
X-Forwarded-Encrypted: i=1; AJvYcCVzRvdxK/BONDwfX4a21IU9jaap0bwC4QbV9suHcObp60ApJqTD9RJ/lpcmZaYL6SgJg0selsSOsaQXIXk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzHQKwx/BQK7JjFbyrOTp1wdQ/fazlxh7tw7FnEVZGAqR8s1BhE
	deNrdb1FRtM4b5ZCno6Xtx4dSUa7bp02bcL0MnEFURwzzTRZ9jXS+IxZ
X-Gm-Gg: ASbGncvi4Dvs2txMe2xxVALmgiX1NmcEA7i+kEfetbIM5O+EiI7gVX4J1qYfaNRTgAE
	kT7ydd/+O8qfSqEi2AHfJ/4HWTLnX5SPijXkYOsAcqtxmCYSv2hyvz9mseNBm/4so9NN2zknXp6
	K8IBglnXmd0djeCgVdLTho/O2eG4mwUeq/eJinmBcgVEAIkNMtETEGMwke+FluoNpPpzuc8LLQp
	S4kMgBxJ0JvZ4ucQm0EXzYONHd2jnOmw78h/9IShRAcY4DvrFYKQxlrU/nzooGC8X53qxGHy5SQ
	ZNs31w5LMpBd0mJkM/lO26UDXs/RboiCCPHsLkcm5xpXOg/2sVVDttjYbK8GUZ9WAlVUaNudMSu
	AVva202MC3QEgaxMbP/ZTqIYJr2ZYP1qYE4qCcCR4s9rS/ucj/LPV4K0XN9eqCACj60BT61PCD2
	vLL2qVopDRMbud6R3fqZSlDCNJKcrp
X-Google-Smtp-Source: AGHT+IGcphv3Y4S/+8hBXnAifQ0Lugya7F08rZBSa88ZhxJo9tLkgsV8/t8NAnzRDkBfLXViimjVPg==
X-Received: by 2002:a17:902:d50d:b0:245:f6aa:1cd0 with SMTP id d9443c01a7336-2460245b0fbmr71854855ad.17.1755843301678;
        Thu, 21 Aug 2025 23:15:01 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35d-8041-a0f2-62d1-f7aa-e5b7.emome-ip6.hinet.net. [2001:b400:e35d:8041:a0f2:62d1:f7aa:e5b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246181c48c1sm28660385ad.116.2025.08.21.23.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:15:01 -0700 (PDT)
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
Subject: [PATCH v2 1/2] ARM: dts: aspeed: harma: add power monitor support
Date: Fri, 22 Aug 2025 14:14:51 +0800
Message-ID: <20250822061454.2610386-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
References: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
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

Add INA238 device on I2C bus 4 for the PDB board power monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..741d2d9b6d03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -373,6 +373,12 @@ power-monitor@40 {
 		compatible = "infineon,xdp710";
 		reg = <0x40>;
 	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


