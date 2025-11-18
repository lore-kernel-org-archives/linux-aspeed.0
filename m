Return-Path: <linux-aspeed+bounces-2949-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12455CF2561
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 22:11:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9zMw2ZqLz2yvc;
	Wed, 19 Nov 2025 09:11:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763439074;
	cv=none; b=Eh7RJuW0MPYQQAUkj/Lnda5uuTJLVXYXPn74pI3APdnq3ShdiZJ4Dq7u+LetvPiQUUvfdX1ZreR5KLW5a4nyq9ltwcrZBqKbd3tB5myxq9qEmgq0GczO2zK+YN1aNFujWyE7/y5l5z7AfSr/tBIQTCACUPhYQFb1AoB9VKe8bKnFGWvfdKv/FrJzUQ5EktX3paHTWN5o6giQ31BIjvXDVfFyjrvHgJBiThuaJYmixsJSs9xHupHA8a10/NslT6swcDjdnWPlPpiCWRk9bu7f26ZCAfzWPXciv8X3KGIGjQ6NnIww0wPJ1bAkVCzBvghTdgHQmb2Htn2VkFBC7VY4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763439074; c=relaxed/relaxed;
	bh=BDAoJsdvgOOXOBHWJUVVxiGfTHyo8kvSzyzlmWb+VEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lI1btN0fJ/kj2xjju18R1Q7EdNj9wdlzTqzreNAJPDAWA2dzCnDfU252UfClSk29AVsSi4+9mY2YoSwbojICACvWz4aEEMx05FCB9GGxiMjc0xyfovdL2jwC22W4MmHNXYiKA1OdqIMYX25yr4UXs5H0gebzeBMkA4ZYkhtAsQMHKpsoYDtQdchMBVv5zaGCpSyQ9dm9MugS4bdmDaS0ulIaMdsBCWyhAeqiMnLHylvdDMFTbAvr0Ws2m1WaLj4WFFRF9fSuNTqJqgjLMSeRhklF/4E1SIc4ePrSIgzH/ffVWjvxReHV9ENIFHb2atIcTJDmlnPf7wA6JiWyFrKPRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WHYnJiRr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WHYnJiRr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9WPm60dHz2xqr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 15:11:08 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-29516a36affso59139695ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Nov 2025 20:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763439066; x=1764043866; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDAoJsdvgOOXOBHWJUVVxiGfTHyo8kvSzyzlmWb+VEU=;
        b=WHYnJiRrJJAUcX/byM2moX0T532ad5sMt8f5n5zdqqp+PhU70GEa5PBNhdEszgCHhV
         CDEfDkwLKOJ8A7m5qij1IU2IL3K13b9ZlxKjJjlgTTKZP9qTvb7vOqkFhestatL4LkW4
         L8qIAXBynOyBetIh8vtbwrV3e4bKjwOTCaoV063aGwTiI/GLgOwlWrBDthIxxzuIlR4b
         fqhIiLtQqnA5u4d9q5GlP/AoqG3hvFpg2WxSp6rcS4lEOpU/dmZkYUg+5b7TKg/6PEww
         etK59uIfF7uAS9iVXoiBSVwCaoK2+J7gn6UdRBEPnIgShLT9gByF9q8xBzC/jCNlIA2g
         p+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763439066; x=1764043866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDAoJsdvgOOXOBHWJUVVxiGfTHyo8kvSzyzlmWb+VEU=;
        b=Dn5vopgl96ADyhM0gMzH3twDpv2GDszg00I1LuFkvOu8Hq7egle0fEcxR6B4VBJCCU
         NNj2LbBLq0HSxj2Rq/Q8UuNFxCjx4on4gSofBnyqStplhvGFU2wSjTbOHo741OguF9Gm
         a1lt2+YsRII7V0vcMStOlFKPqtegMNE49OtoMzBOEC1uyxXf3m8cAsy925cdV41Dxzfx
         8MatOZyep1TKxpqIUORdnuLAV3STg+Jg8uO8BS0KwPO/XFHRGkRstc5AOdycTDr9ofEb
         pokvU7/RdURlTquri9IaNdZ8XKWKiJZU7JnJ1kA56JCwUoQSTCAFiXTBCHoJTgWa/GG1
         ylsw==
X-Forwarded-Encrypted: i=1; AJvYcCWMEO8cpmzge/DYutEkpDQ08KJm+5OMvQSKj5pC7NY3g6atRzLccixOSdhi8HymPvr2IQfSN8q4Ng2nBEc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxx/abyDR7l0HRNNwPpcXcF78WQW7kZhDWVRXfFj6qGyo/q4wLi
	T4nzKQtA/dHqvk+es4Mt5a+WvpwucXMdXA9TAe4Jm3vQV2SevEUkp3Ke
X-Gm-Gg: ASbGnctJ/+kiysQ28YxXWexXNvOy0ILDz/7nqjv2bONa87NF0Iqkf7NlIPCLnTR0C+P
	yj3MYWm1q4VuujOs8/c1Q83tXIG5EN+WSNTPmg5B35PJpU94IPBAKIAhX5FBihlyVCgBMCK6Vu4
	Nh7tRY7C4oXxZakS9RjMJ/nYFkMhntoOS4z/sblCalUi68jehAOwod5BaBJhSDJS9rfmdQa81bx
	GAV3hubzMryQj0jAdzJDLHo6549hozKFkT5J6rJvKVpLZg+lX6Vx3pJ9U5QroiExmJv+IA7DpHq
	MmA3RMuhOCSvEUACV3K5fYgYaul+aNr8ER/arzMtHiZn5HtsZUjo07pqK2QxMiGnf/ndwagCcvc
	Vr6JExXHPbTaOmDqaTtfbT6TuEDPWBorqya8f17qs57Wgl28oWDCudV0OYlTRZx/ayQfaJgdncs
	FJRw==
X-Google-Smtp-Source: AGHT+IFWfA9iG7jd5oINwxqC9subA2gUrhWeuBi98jZqy9meWujj94Sw12xkpdJk1gBOH1qHv6uzdg==
X-Received: by 2002:a17:903:2449:b0:295:275d:21d8 with SMTP id d9443c01a7336-2986a5eb5e1mr178663325ad.0.1763439065671;
        Mon, 17 Nov 2025 20:11:05 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2cca00sm155514805ad.101.2025.11.17.20.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 20:11:05 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	peter.shen@amd.com,
	Peter Shen <sjg168@gmail.com>
Subject: [PATCH v7 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Tue, 18 Nov 2025 12:10:56 +0800
Message-Id: <20251118041058.1342672-1-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112211248.3711889-1-sjg168@gmail.com>
References: <20251112211248.3711889-1-sjg168@gmail.com>
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

This patch series introduces the initial Device Tree support for the 
Facebook Anacapa BMC platform, which is based on the Aspeed AST2600 SoC. 
It configures the platform-specific peripherals and aliases for OpenBMC 
usage.

The series is comprised of two patches:
1. Adds the compatible string for the board to the binding documentation.
2. Adds the main Device Tree Source file for the Anacapa BMC.

**This patch series is a re-submission of v6 (series starting at:**
**<https://lore.kernel.org/all/20251112211248.3711889-1-sjg168@gmail.com>)**

Changes in v7:
* Dropped the unused 'pcc_memory' reserved memory region as suggested 
    by Andrew Jeffery.
* Reordered the 'spi-gpio' properties to group all '-gpios' properties 
    together for better readability (Andrew Jeffery).
* Moved the 'pinctrl_ncsi3_default' pinctrl group from the board DTS 
    file to 'arch/arm/boot/dts/aspeed-g6.dtsi' (assuming this dtsi 
    change is applied separately or already in the base) to make it 
    available for other platforms (Andrew Jeffery).
* Revised the 'gpio-line-names' for better clarity and alignment with 
    schematic signal names, avoiding confusion with pin-muxed functions 
    (Andrew Jeffery).
* Improved the formatting and readability of 'sgpio-line-names' list.
* Removed the unused 'led-2' definition from the 'leds' node.
* Added support for the ADC128D818 sensor to the I2C bus.
* No functional changes in the binding patch (1/2).

Peter Shen (2):
  dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
  ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-anacapa.dts    | 1044 +++++++++++++++++
 3 files changed, 1046 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts

-- 
2.34.1


