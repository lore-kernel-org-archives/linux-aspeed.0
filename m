Return-Path: <linux-aspeed+bounces-1077-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42C3C28B30
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTrx3chcz3055;
	Fri, 21 Mar 2025 02:24:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484273;
	cv=none; b=eDGv+aIvB9tsavrSGON5HZO1l//H/OU36rh8XadK8oenF2VkXGPpCT2NZCehAcwwqYUFFdp1UA32qw0sKxHDbDC+owyP1FokqhLuJ08pYULIXVwKwZa88wlAIlCU6uFiYVoEsPeRaXRLrJWsSTxpy4hC4IS4w5EfGChJIC8bVETLcrVyemfT9ywgQ12Bs4vfYKvCMA+ViUoNVE8UFrdH9o/dmxF+SC96IFPhPTZjNo5bR20PLCGvkLnyGkcIiY3JOrneOok88ZLFXs4orMaih8j/KNoskO6bF2+acNxkWFkBDFDsxfdglhQSz7GGGRNmxEkVeba+SHYr0T6R1xvHww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484273; c=relaxed/relaxed;
	bh=xgBZ5CUSGzZQMXrNQ7iMZPeg3VKPPTQI8tLphlbuft8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IYBlyQ9ML41MLTfJMDvau4mbSDJOjK2FtCK+MW2DI4RkZ33F/UX7Gzi17c+W7JglXRmi86l5+ouEUgrjvvrnVBiR1pl5Tmn/CccMs+VKGwKN753VfNbL6ZEVgtScE0b2WhaO0OaqKi072JhLqix3gdhHkwLyYLUoJaWA91zrbbdIIxVvn7oPsasTfDbibUsJRAuao1HILzjL0qHc3xKfly9Sc6fvJXE1jl/hKSWOYq34MCyGBx4HVFVV2m0iEW2r3yIknSpL+sPyQpplssMEGqmyWe8juORXI+ktCo0Oh+g4se6rP0JcI3YslXB1X/cAL2INs7xD22ZEZjbdI+Nyvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MQJkRh/k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MQJkRh/k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTrw1h50z2yrD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:31 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2264aefc45dso26766985ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484269; x=1743089069; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgBZ5CUSGzZQMXrNQ7iMZPeg3VKPPTQI8tLphlbuft8=;
        b=MQJkRh/kloL/EPnVfXMap2Y9ykrSJwIJUr98VSL+at71RT8qy+0lFgYaOtI8/Zvt9w
         qDEu8uLR9Y2Z+WhSGTK0trYD5/EnbT+iFmHxhxJoo/sHPwL78SwylI8y1yDk5l5XIExc
         kglbNzDuj00UA6VsjcTV6foMK/F3mjx3AbM45FxdBM6tkRliLUqciV9EpUkKkBtrGuAX
         4PhkBIRjt7cUqVAeYAfhayRZc1hY1JwgPuJZhXkzEuwAQp0tTQ/GdvqWs3n4bsxNHBuv
         SW22HfiaHwMCkJvbh4+90bbhpVBvYHu9BKtm9JRSUCYrcR/lVBItPzKYpdZOMnnTMGQV
         8PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484269; x=1743089069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgBZ5CUSGzZQMXrNQ7iMZPeg3VKPPTQI8tLphlbuft8=;
        b=c94tZBZ7S92BZQ5p9k6h9cQVRAEsbq9K/QpLIrCRD1FFsURKy8QMJNy8/gJjXPrZ0E
         wVCLpRV0+klP8ZsQP7tvTptyLIaQ5JjATfbDUee3Pp6Ks0VYYQjm4FmX1b/u3N+1Ns0e
         HHSSTLEyFC6oXvH+3w3FA6zU/XpATkyZQXGcmScOxhEGzhkZR0wSGxhn469pCh3hYwHK
         rcMX7g2Tje8bTsbxzpgIIFzajPvSK5lJ8+GD02gBGtBcqJDXWHqdIYvz58eH/MfB6Fxk
         tOsT3JaxhixDEAFcD8B85ZVJVbETZ7pv1rkY8fcNZxfuZgPZwQ3yVOSUn151zRyxssjG
         vhTg==
X-Forwarded-Encrypted: i=1; AJvYcCWwFyoh8R/QCj7YwpDdJoOPWtSRF0lKXy7ebA45nIy5l5ldLbchq91vF3Z117d5wraxCD1+52BI82dsAro=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzskIJB+Bb0l6ZuKpcKi4nKZl87Vj5cfLgwZf4NhKy21LpudJp
	mCY/M3QpQV4tZDhLrZ5Pzw83o2cp94mwHeru0i0QoafAx791vrSf
X-Gm-Gg: ASbGncuECCLe74B7BqOsAALBhozugLcFbctYIn3Ul/WCDRsdfHPS5vSkmydFHM69MaE
	3bTq+MYyriPrYGPQ9jwd6qwUg7NW7ANolNWe1Cl3phVn+MvlUPcKFoBTNGmRt9sVIh0RnpXPbdL
	bnONcKaNzee/IwsDJa++H8pg+tNBpTKgk1Gb0Fm7HsWpDEIIOicxbGK42vPWFaK+/lVOK6FMMi2
	+1C5PHsKa11/JtS6IGA23vMJN1U2NsEeKqWCkPSkoxnE735URmXZ5E1RMyvBc9H4kMw11/nWJsd
	cEbCmKRLdkPeTeFCugOFJXqeblI7dBWM0IVWnNvlL/TD3mYi+igxV+qmKqBzfLoHk8BaVGmeo8U
	RfS1lyWTvrbE2s5AWAKzaNg==
X-Google-Smtp-Source: AGHT+IE8wgx82LSpjOoMcp7xMjse6vZ9j5z6ddnJQvCI/Fs2gOi8QJmpGG9UFax94XWc9AkTdIPv9w==
X-Received: by 2002:a17:903:2346:b0:223:5ace:eccf with SMTP id d9443c01a7336-2265ee0aedbmr64395195ad.25.1742484268680;
        Thu, 20 Mar 2025 08:24:28 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:28 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v5 00/10] ARM: dts: aspeed: catalina: Update DTS to support
 Catalina PVT hardware
Date: Thu, 20 Mar 2025 23:21:50 +0800
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAI4y3GcC/43NQW7CMBCF4asgrzvIY09wzKr3qFiMHQcsQRLFb
 lSEcvc6SKURqyz/0eh7D5HCGEMSx91DjGGKKfZdiepjJ/yFu3OA2JQWSqpKolQw9Dl24DnzNXY
 MTU7wPTScA7xeLJKTBybXOBYFGsbQxp/nyNep9CWm3I/35+aEy/WP11v4CQHBSWe4UtrbQ/15v
 nG87n1/Ews/qRWJ20hVSDSqQjRtMGzfSb0maROpF5JsjYbIqTa8k/RPaiU3kQQSjNfkatRWIq3
 JeZ5/AdkRxPXNAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=2078;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=cJ4PKBqJ1ZUnV8+yUZvNXJkgGfWoCnqYjpX/+o7T94w=;
 b=S29qvnFmgZIP8YDEgxdV9L8SWhKqk1HlSw3tWuB6SnfHRj8puN3OAuw4BqZ/y3CK9surBXICF
 qdFlkjwYr7QCHpzI9QI0C9x31DQb1Oc5lQS4+R35VLGiGuL+5jJF3Ar
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the DTS file for the Catalina platform based on the PVT hardware
changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v5:
- Revise CBC FRU eeprom i2c bus and address
- Add MCTP support for backend NIC monitoring via PLDM over MCTP
- Link to v4: https://lore.kernel.org/r/20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com

Changes in v4:
- Split a single commit into multiple smaller commits to reduce complexity.
- Add `multi-master` into i2c12 & i2c13  
- Link to v3: https://lore.kernel.org/r/20250114-potin-catalina-dts-update-20250102-v3-1-14981744b2fe@gmail.com

Changes in v3:
- Remove delta_brick nodes due to compatible string not supported
- Link to v2: https://lore.kernel.org/r/20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com

Changes in v2:
- Add delta_brick nodes to support PDB brick board
- Link to v1: https://lore.kernel.org/r/20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com

---
Potin Lai (10):
      ARM: dts: aspeed: catalina: Add IO Mezz board thermal sensor nodes
      ARM: dts: aspeed: catalina: Add Front IO board remote thermal sensor
      ARM: dts: aspeed: catalina: Add MP5990 power sensor node
      ARM: dts: aspeed: catalina: Add fan controller support
      ARM: dts: aspeed: catalina: Add second source fan controller support
      ARM: dts: aspeed: catalina: Add second source HSC node support
      ARM: dts: aspeed: catalina: Remove INA238 and INA230 nodes
      ARM: dts: aspeed: catalina: Enable multi-master on additional I2C buses
      ARM: dts: aspeed: catalina: Update CBC FRU EEPROM I2C bus and address
      ARM: dts: aspeed: catalina: Enable MCTP support for NIC management

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 197 +++++++++++++++------
 1 file changed, 144 insertions(+), 53 deletions(-)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250102-potin-catalina-dts-update-20250102-914b06a4bdba

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


