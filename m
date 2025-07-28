Return-Path: <linux-aspeed+bounces-1842-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91560C87FCE
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75R1dLqz30Lt;
	Mon, 28 Jul 2025 15:56:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682187;
	cv=none; b=Olmn3SqlBraESrACaGrbsoCw+gP5/UVCgh87Qfl3XzSqagu4lDPZw9VR8/OEm5KtSGcnhUy//Wqx+lSnwR1uVyuTyBxstQQJo8CDVVig/4f+wEzNGBBKF6L07dIgQF8YP+qm4dnvhLCCrp6/KlkksvGwci1DwKalpwCB5GqoU55mbreC/mzu8iQ1FCRSkKgNM9JC2OBlPbjV+r3DHKkzJgaLE1qEOb4LLLzKEJF7HEFNLzsATyQI9fKJ7t5l3a05q0kMGviFp4X7Qux9BuoZb3m43rTymtm7wQnU2VwdQUoMlRp7Bo0+yft61jeNhhblXFJqjIx0s5RSqIJgl2zecA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682187; c=relaxed/relaxed;
	bh=AfBX2Dn6gQHlMzI4pjH3b2TDwu+3+H5wPtDXO245HqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDTad7ygxLV41K46csTZLZY9EVFoYPQypMAjFiukdH6f8EPW3Ps96rHQRr/ZQFxY3FBW3a8P9/PnFMQ69aOU+sviXkGcHsvPhnzkiSqUuQZmQO0ySbXlEfHS1vLd37Z4GEkLQB+wP8yiy4Gy0wFl/94sT5djiuBpYCqCSR2zOgVUPN7qDQihTVfCrS6Yf0LGs8Yftf1Tc4Ce4KMhRASjOMTc0VI2KZ2J1OHyNOneeiPwrGr0kiV5mFsSsAr1A87eihkt7YIfaRp8kcSsll54HW2eb6yUBYSe67jZ75PZAu/HSYtB0/GwirOL3+2D24uQN9ldHjFyHpx0AouP3bxB3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LrRlvZCt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LrRlvZCt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75Q0v9Jz2yLB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:25 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2402b5396cdso3504385ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682183; x=1754286983; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AfBX2Dn6gQHlMzI4pjH3b2TDwu+3+H5wPtDXO245HqA=;
        b=LrRlvZCtTyrFKcSgobFrqIILEDrvH6y3MjbVxXir1lCo94rE3XRqvMfXY1JXIkIYJM
         T55VxDj5mf+RltHGVDytxdliDR9wzih86QzCukqT64hB8EdVK9cv2eYkJfNGIZGO2r+t
         CcyteClaSDezjFirWnT6oCOHiZAbixC9whAEsl4fpc4v41J9NhNXOZy1TnPU9dn7ngDi
         YWzv09KcDLbIOpKfVObyeqXRxyjAu2yThiCYOdZFigtDb0X8Zn5jOujt+N7VvzL6bWIJ
         miXUp9riXruNa82PuRLGukokQxpTTbhbZ55oqCphh22WwGkuRo1Ez94tqEACw6hSKKPI
         Nllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682183; x=1754286983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfBX2Dn6gQHlMzI4pjH3b2TDwu+3+H5wPtDXO245HqA=;
        b=tskJefi+zQIItn1TB7dFrvRYuJG4UgDq7zfM1QYbrvbR/hEC77qTAE7dBf4ge2maBH
         KkqeGB3I+OEmhgcsHFChSplKyLeS7ltg3SUM2c014MIfmsmaVoWWtpriI4T0oh5nJavT
         bIB2L4I8Kq3NczQ8yXqeKWxXXqxlB8HaluqiaG1q//L7W12qS+MPLeS4O4EHUQ/nhm/x
         886eoKhKCSYXeuKk1AheMmof2Q1aU/ssPpYUCaR+Fih4X461rsyLvk5JzPU7sqM+FbtM
         GADn0ra3CXFXqQs7vidF/aioW3m4rMg/w8qCUbSIZMTMGhaJDstQA+g5hHES6uTuDz7/
         QMYw==
X-Forwarded-Encrypted: i=1; AJvYcCUwGmqs9q7qpgMQPU1Q4rjcWL1zChRxkPb3++sbswvmjBZM6FoSawLIlnwYyD18lKvtUvNCjBZgz1LDvM4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwO27jdO6ykxaJC3LhY9iQnRrzynW9eNDWc04vJ5XbA/BQexhnN
	3+aiyDz6i7Aia5mPWpBnIS/qxnYMwwQzX3zJk1J+PK6d6Ab7KawzvTft
X-Gm-Gg: ASbGncs/KL2BGiCQZCEL2K6igtyQRCPa58UitvBJzsPrBeChRq5Pev8S/dfWot2ekKj
	P3VJx2v44Uf/4ytraSUm1hB4kGLuag8bRwV9z1Ln9mQy6CYoZGD3wxyD3EVxOtlLqLjL9dsKMY2
	6hGH41KN3kI2ZKdKnpQmqOe/aca8LKlEg/TqlwlGArov1JbEdYU7KfCdNUY46ryTG9uWXjmQz3U
	IEj1D1EbuTTgNbV1EnkkL3OPt1N9/AqqU96jSppjIm4wNjbvvzjzREaKc/ljx9q3eR8W3VKzKEb
	n1NWGPP4UzKFwR30CF2yTQtBi2c1Y3hguhdoT+vL9sC2wHuFhINHGgAc0FfDMt3sMoBnCzxD/eb
	aw+BcnQ56dTqialsNwgVrTi1TTQMgxTfmVSlYfdak4WQv19RnwT527uMRc7gAWGNQqL15OvobQd
	XPOKYUZC+6gA==
X-Google-Smtp-Source: AGHT+IEAtZDtFkeJNbSH5GWI9Ubuq7ax/Mj9S7hmCp9fOAX7SqKDyq386D0ys1EjsIruhFyyf9MRaw==
X-Received: by 2002:a17:902:ebca:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-23fb304f9b5mr141625795ad.6.1753682182526;
        Sun, 27 Jul 2025 22:56:22 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:21 -0700 (PDT)
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
Subject: [PATCH v4 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Date: Sun, 27 Jul 2025 22:56:02 -0700
Message-ID: <20250728055618.61616-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The patch series introduces the initial device tree for Meta/Facebook
Darwin AST2600 BMC.

Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
ast2600-facebook-netbmc-common.dtsi.

Patch #4 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
each BMC platform because eMMC was removed from future Meta Network BMC
platforms.

Patch #5 introduces new BMC flash layout with 64MB data partition.

Patches #6, #7 and #8 add "wedge400-data64-bmc" board. "wedge400-bmc"
and "wedge400-data64-bmc" are identical except BMC flash layout.

Patches #9, #10 and #11 add "fuji-data64-bmc" board. "fuji-bmc" and
"fuji-data64-bmc" are identical except BMC flash layout.

Patches #12 and #13 add Meta Darwin BMC and updates devicetree
bindings.

Tao Ren (13):
  ARM: dts: aspeed: wedge400: Fix DTB warnings
  ARM: dts: aspeed: fuji: Fix DTB warnings
  ARM: dts: aspeed: Fix DTB warnings in
    ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
  dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
  ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
  ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
  dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
  ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
  ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
  dt-bindings: arm: aspeed: add Facebook Darwin board
  ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    3 +
 arch/arm/boot/dts/aspeed/Makefile             |    3 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts |   72 +
 .../dts/aspeed/aspeed-bmc-facebook-elbert.dts |   12 +
 .../aspeed-bmc-facebook-fuji-data64.dts       | 1256 +++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 1245 +---------------
 .../aspeed-bmc-facebook-wedge400-data64.dts   |  375 +++++
 .../aspeed/aspeed-bmc-facebook-wedge400.dts   |  366 +----
 .../ast2600-facebook-netbmc-common.dtsi       |   22 +-
 .../facebook-bmc-flash-layout-128-data64.dtsi |   60 +
 10 files changed, 1795 insertions(+), 1619 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

-- 
2.47.3


