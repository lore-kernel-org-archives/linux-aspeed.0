Return-Path: <linux-aspeed+bounces-163-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41DFD75BB6
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 04:36:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv5651PsNz2yl1;
	Thu, 21 Nov 2024 15:36:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732163789;
	cv=none; b=l2TAEb5q07ykggdlGLSRAqOvJr2CUzRmk88EngyuXJUKLepKdDjsud44mlujIMUBE1KzDZbtlU8CA2tFw3H1ZYolIAZvXrO87Wl5BpF9NQBAie8gaUn5SCwqNMnmlZkIcACf85K+YbcxOz+1zR6zZdBC+VPz1Q5Zrr3ZPODSz9DaDXrD8PuCjSVoX6bIhUXVb+IoQJ+BHWMQhqyxGy6o2NkfdsDCcqGkU1o2yNB/fFbPBMgt6fmgnnenMvz5kikMXJ49HGGbZnM6medp3L17eVrSLclTO/Hkx+5mYcj1pB2DigWpwtaZ82WFQ3Ekv8/ReRHhAzPcM0OGpj7S1u7fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732163789; c=relaxed/relaxed;
	bh=gq+ad7sZfGrLxQrmLaPQvEe+2stpRD0g+Leamoq1YOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iM+a+5XiiYUsjJdjtQDKJjCfNBHXqHwYddn0RGN//e/U+fT4H4o7BeQKKQal/6LM7n3Ni4BqqA3rHtZ3uU+jxjtzPxuS18/RBaPB87r2EtH/Vl3IgNl5WCYkZq2sLEq3Gtfd1lyYQyLZ6UkCzczrYVm76WQ/lXl0NzVkEQCj00aZi7hghjlj7B4T62MNy0SVnt8/nVyLJ1aLX0PBq9iKapYdxXLXrAZmRpLfsE6zcl534BLd2Powmj0WaOSSylMPCaE12spZTs5OEmi1lnwFA95DJ/nGJgPZjHzeGkFogqyNNixmc5TMgP4MY4clm9FI7VEpBLHa/PWYYHKwmLYLnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BjoR2txQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b2e; helo=mail-yb1-xb2e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BjoR2txQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2e; helo=mail-yb1-xb2e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv56409hyz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 15:36:28 +1100 (AEDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-e382e549918so351355276.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 20:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163784; x=1732768584; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq+ad7sZfGrLxQrmLaPQvEe+2stpRD0g+Leamoq1YOQ=;
        b=BjoR2txQ7tFO6WwN1jCAH+Ax+hqGgTnUQujOBhB0TlSBUHxqAPmjeJ568er+6ZA+Gj
         /3H2Gnx6/1B7fGaCewMmX4qfmobUvNdKu7DciWM/UkdBQPx8CrIAuI8CvKITucUaMV05
         +FOiRklZNvXoDCUcjeOYhjLzSV6UeJrfpW/vbj++NsdKrKa1gFAar9JvBRvdXHHiJ+8K
         FDFHwM4kQkvuSf2/r58z/8HPooN9q2qOL1EdF9VAs2uyUzmtzwy5IDLkeaLDWtCw0rrc
         vqu5jeLf669NuNFNQ65JsKlwgx8BcRuUea3pGB2Qhn8tYIlA3ZBACRs7vgooq6Xf0zbK
         cGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163784; x=1732768584;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gq+ad7sZfGrLxQrmLaPQvEe+2stpRD0g+Leamoq1YOQ=;
        b=TbXh/2dXSI6c4O8Z9Cw3xBPUCL8nZGzwQXbW7Y79IbhWtJ1ULNxeoWAHnwiYOBXa1s
         iDd6hpYy5G5RfsoX3TIwErbpxZkjcWjGvTuU4RQzMjCXBGPWhKsFP5ZbcD2lc63OfxNg
         g6OnRxu69NRnW+qsHVH/cH6cVoD0ez/5wRz/rH0R2SnS+g2yzLvZZ3VVloqoxC6OTmmj
         RrbSjuLVyJdeAxhk8NHJXwRnTCKjNeREz7WINXGWFkXXwZ+UuFKzXxwrPc81Ro5LHdpQ
         IzpCbKNaB52ZoPRLKL92z9Sk48rytQYZ88z7eG6GEafAaFRyCAYKYYEtLZEWvCUQrthj
         Iq0w==
X-Forwarded-Encrypted: i=1; AJvYcCU8FrTU3d4yhBHdnBO87pxR1T56ah06V61Kp9oAui5vvVbAqo11sK2wluxLoHQa1TqfrkfrCa6LNB3iH4g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6PQA0o12glGyA+P7ddS8kA015cna9L8CsG47qkT3XcdA+jjEU
	TnEHhmAyGp8ewlO2k9/9h2ZVkPI0ZAIza26eUkE1eAW4XULUnTAy
X-Gm-Gg: ASbGncuuJABpmz8WoRFLnCNagAn7vx0Il7vhXYteIy88VLOPKyyGnNapMU6g3YMSDds
	CGytl5sTYYCdArWlR0NPCgu+uiO7p7lHeEX629z8g3YeZg6jjQgQS9kUfm1f4sI7A1anHwTcrlc
	Aplm+EgD8zKEtTh6+HwyTixHz4q30mDcCStW9GMGtYIPYpNUFmsJtplvM7ySKKG+PyHmT5Ad3xq
	FNjzKT9fBq9Dn+qJEIWKc61emt3BZXYVmpQWP0glVPrBdzbxcMMxitGNEDdb3jXDe7d+eCIUQvO
	LSLnEL3cZDPButppMWsdYma2ofw=
X-Google-Smtp-Source: AGHT+IG6v9ry8rNPMTv18xrWoIOcEji23ZUnLH/q33uEBsqANBSy4agWkDZk0KmSDWfSx0CnygepHw==
X-Received: by 2002:a05:6902:18c2:b0:e30:e1f3:2a9c with SMTP id 3f1490d57ef6-e38cb3cfc5fmr6450392276.0.1732163784062;
        Wed, 20 Nov 2024 20:36:24 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64e11fcsm402013a12.15.2024.11.20.20.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 20:36:23 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: catalina: revise catalina dts file
Date: Thu, 21 Nov 2024 12:34:03 +0800
Message-Id: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIADu4PmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMD3eTEksSczLxE3ZSSYl24aKqxiWGSpYG5oYVJqhJQb0FRalpmBdj
 c6NjaWgB6tcObZwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732163781; l=647;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=381WngC8iKFV1PSpDa07H1nZ9xgbAG9Xckkdyqb9St8=;
 b=h1qEWQAugQzZbGZaOABW6eYNn/tU2euJILA3NbFag8tPDo0xTstUA80jjiwz3tvv9IZAxBccc
 fZl41CP7LWnDOZrzSz1yCjzHIZR9KIn9VwTnPzNBZU2Lrk9f8nXcu9h
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add following patches to fix issues.
- revise ltc4287 shunt-resistor value 
- remove interrupt of GPIOB4 form all IOEXP

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      ARM: dts: aspeed: catalina: revise ltc4287 shunt-resistor value
      ARM: dts: aspeed: catalina: remove interrupt of GPIOB4 form all IOEXP

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)
---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241120-catalina-dts-20241120-e341b907184e

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


