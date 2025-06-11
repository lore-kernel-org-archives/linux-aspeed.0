Return-Path: <linux-aspeed+bounces-1378-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2990CC61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJ9w5PsYz307q;
	Wed, 11 Jun 2025 18:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749629124;
	cv=none; b=feqWfC18drzE2rYCA36yKFlcbIcUFxf7znP7kOnLq1h65csklCNn4Ao5JeQzenVukgDBil8HzWVJkYOgNLkhdE9JhfHRM0rjiFIKLNAAGckUUkmtmw2Ln6b2BqrB8qg8KGdaIcgilh8iZwjZjVXzFwc3Q3ibG6UBHqUxmdeVUXuHSvIq8UBk/wsj67J0At2JRqiK2O5NlcfNeuXSwNGD1OBXZK66eduzm8GyFn9CTI4LOLFuVjcSO6qAyfZDFNFvliNP1QKgtVwZxIWXTQkhy8Jskzv2h6c5L2qPGoSfVYpVt73tJ6E+iTCKKz7bDz72rmNPia2wAnPuS4eJwPLleA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749629124; c=relaxed/relaxed;
	bh=dAmqS9TFfQgR6ZuXXgUeH384PenfewbVMCpyFtNRxxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaEJlHgXN0R6XGeq/cZUcvu0jGcCU6S7tUSp3i4mRpDSjadCoxBRy8DUGxdxMTeQaX609kHOxhruglRjp8hlYUp52BSkMGOM9UMuQz80y/T1leYJ+E6r71sUuqFouNhhtZAHnC8doaatjOFA0PmDbpxn4fsCFM5bWKPGLhRn6pQL8dIP/FC8iHI8EuT1si/4dGxd+ctcYxQIR14o2oYp5evjIwPHWhjJ204v2FGF2gZB/9vjxzyqc8gZGc/q2odzAW4qn+wInEkUtbhGWFTmsoFylmQ1GJmq4oDcvtuoEGlvGnYGx3A8aAk/9QBOPkOmyQeENdMxwfrFhdl8+xmqMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H3uWBBLo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H3uWBBLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJ9v75lwz307V
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:05:23 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2350fc2591dso6054955ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629122; x=1750233922; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAmqS9TFfQgR6ZuXXgUeH384PenfewbVMCpyFtNRxxk=;
        b=H3uWBBLolrjPN5fWN22V0oePYXSOi1WlVLSaOjZQ60aYBRKh/5hn60WYwCcmLlhl03
         w2fS4WahZ/cw10Oy+EIxJV41QFGwMxfV6yEEqslD3OE7c6dD2o5/x8yFXKEwzTAdqd0D
         ujH3LSiJe90wHS8fv5D7ilbTX9aGbK9JngXsfY73cO0YiCOT9FKliuU3PcunTNfYn4US
         XmVzueiQNnvIEVvHEJKXAnoNFRbwaqmoizfbnjmhSazu7x3yYPB5Own2zyTALU74JQsr
         TklFWKps83TTtrHndzrUV+Q/4BP/e/AxBiEpd4Jd50MZBU+WsKpZtotM0kAW+8ZqzY8v
         JEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629122; x=1750233922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAmqS9TFfQgR6ZuXXgUeH384PenfewbVMCpyFtNRxxk=;
        b=pBflJ6kt85PO0tz+MRaJWbuMnw3aGV+Pl4iBjA6y7ESVeH4tbk1RQD+nlAY+ztFQWQ
         krhRQRAxk7zxcSSc5cqzd7ZPxKUSsAwa29HpUUVgLPLhvm2entJamA/7AX0Gv8aNGCLo
         T1D0c0K5uUQ1zDMP73HeEXL/dOXIO9VPOVe1oa5C/4EZjam7XdtAC3361YKI8mxc+KUe
         AQikJoyiQ1CXnpL5mOc+eJOEOqMK5vCjHkRg2ABv0VNGBHjOto9K/Iq/QrGJTPaGeX1Z
         gP88c6vrwJwDUa6y2KHmjKXgTXA7pkdXfq6FoVyTY94tgahvZtGBKStql0V8uNvY1RKJ
         fWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTTGY2WNFnFIEo++la1iTiqLzAsAMSSLr9oR+R0wbVOyBjkoGpL5p3sOhHDbC8pOjkDnRny/v5i3cjqHg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwEPkAaexzzXZ+tRn5iEft9uZnvlMbnsfNkad0MOEAM15wUnire
	pn6w7/qLEoOf3n2wxk4vCk8TsCb9WHNvFXecpvzNLRnFyw5VZG7lOaHL
X-Gm-Gg: ASbGnctqGZN2JnaTXhtZtiqIR9HO2Pp7U7Zq5Fe42keR/oKGBXPSG5uH7m1Z20N/gWC
	pqGuCsA3c1qEKCxALYeBxrllkOday2O/MtyFKjrwRPEYdJi71V5rY4HxKTSDqcMRr0v459L6mvt
	LlKaZR223Rop938mPDMVLqrOYVrouC/a10JPBLn2HO+zWHy43Cype5EqXdN8te+eEqlknYb3Hjn
	ZNZRNRIh47rzPUjxgmnNm5h2sr3nBT9VlKuIpPRVMmtxHFt3Z8QOByyuZf651ISANDzf6sTtpXK
	O2ltRi4IbVl9jocIyyT341r/ieXb1tuZ0fOUPpqCmEdRy5UqJd9hxWqxNhZ3xdWYmY2gGJG80ls
	9c+YWIYIRd6a0sPy3CHBtA2H0ymKK7Uw/ZIXjXIoDTq2f/8uE09uXNTQhSOCoU68wHvF7d2cONz
	9u/fF8xhr5uzNPg+k2
X-Google-Smtp-Source: AGHT+IGDGJ0np861gl/BsOafO+Lck0L1DptXpwjhh1Oi95aNBuT054cfghigc5NOLUKgNHLq69TOBw==
X-Received: by 2002:a17:902:ce86:b0:232:59b:5923 with SMTP id d9443c01a7336-23641851c95mr37292345ad.23.1749629122052;
        Wed, 11 Jun 2025 01:05:22 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e357-b8a8-7759-271d-6134-9aa3.emome-ip6.hinet.net. [2001:b400:e357:b8a8:7759:271d:6134:9aa3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2363ad90982sm21283835ad.220.2025.06.11.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:05:21 -0700 (PDT)
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
Subject: [PATCH v2 1/5] ARM: dts: aspeed: harma: add E1.S power monitor
Date: Wed, 11 Jun 2025 16:05:10 +0800
Message-Id: <20250611080514.3123335-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
References: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
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

Add the E1.S power monitor device node to the Harma device tree
to enable power monitoring functionality for E1.S drives.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 9cb511a846e3..3a215bb1e220 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -354,11 +354,22 @@ imux22: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
 		};
 		imux23: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
 		};
 	};
 };
-- 
2.25.1


