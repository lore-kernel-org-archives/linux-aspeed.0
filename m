Return-Path: <linux-aspeed+bounces-2986-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE52CFD365
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 22:41:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFglp2kFVz2yv5;
	Tue, 25 Nov 2025 09:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764019280;
	cv=none; b=PhZzAz0wGbVzN5Yza7maRAkEeDit/M6dDqj7eVzwI9MG/TwmbrwpbwEmRfnW1O0WgBP+64Qa1wATYigKM1JTpL7uwS0/uk52lZCFwpLFoPV+3s8/JCfIVpd/3XGRxbUpgCp35eHzxU/CyqfbvMbE/sdHufZ/jw6JEg1wNz3Zb5k89KXMAjW98yhM1nnyYWXU6gtt0CTOsENDfIun1YdDtcj0pnladuiipdeBqq6kxTVQdXDl0XDI7YrHYRyQtSyZCOCzeoS6my+40tRaWlziLEw61AEv/juocOcgY3wYv95pCctrKO1pLSD+rSgYJjgJ4/7AjO4Jbr9fWgARoa5k9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764019280; c=relaxed/relaxed;
	bh=/9QGz46UYtLMXI1pmFW9bRaeIDfyEN0luwe8T1UQhkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKnlWXCOv4pI9IgniUQ+/74pkcIt/41v5JWapPgmFwyGzQwvNIQ/RfYH/6OKF+ar/BJm/CQS9bqX9DEt/BtSuZpxkzmW4PwnGzcKrw+9gITuzFivuvLW3XIGu9FwsxElDjvb4RTGuh4rOsujnMeYIrj2sNaAnFOrwkf9VYNtitBWjU4mQMuMiIHOXhivMzTFvVlQr37trYkM7iijFqre2idhwtrLFBBBOqTRls0CuXUcTH0+9gmgCZwwxuqZzxCIq1CulHuu/AosdQMrJjLrWurtfMrhHIp+RwZS6+1L7PeXhFAWnd3Re7KBDCzdz0gto8q73V94ducOJ2zdgsm3fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J16YTWxq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J16YTWxq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFdzf6ZbFz2xP9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 08:21:17 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7aab7623f42so4956397b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Nov 2025 13:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764019275; x=1764624075; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9QGz46UYtLMXI1pmFW9bRaeIDfyEN0luwe8T1UQhkk=;
        b=J16YTWxqR9hbgfzyDnwysI+EZxoGTUm39oSpOpzmi4sv9pAChJbR9AxIqmRkClBcsl
         puuEJfIYIDzQbq/fDq8y8Zgx65cBXmsOsU5VXBInwGS48YemWQ1bOYIoGJF8jHloxn5V
         4VZXW0jqLFA8Qa7VjLz5hp9Dm506xxS8w0oAFOsIa7H8VicJl+Zd36KGYEVTHaNhqoRu
         V/38cawNBUjlY61rFSM0t/edM3NbEaCWr4SWK9g5gKjGtmlIsl0/2m2B6qebN0jgtByT
         +4cbilyy9RrGrgKs3jyVA8Fj72egIDOcbb7qoSk72mvYxtH3Xpp34KIAF3DBaQfZThVu
         xp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764019275; x=1764624075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9QGz46UYtLMXI1pmFW9bRaeIDfyEN0luwe8T1UQhkk=;
        b=Zkko3eCm69ox+ipPrsaYk/aTIm67N2zGkfu6VPL5cXQbFBSMjw4buVe0Mthbt6pSOh
         JnrGHvAEVrh5Zcj66rx6N2pSL1q+x2x3eFiUyNI/ota8jKjrjsbPAoATjPtPzUR18f3V
         lWJ028gWX9sI45ReUUKcFGUmzTegKlO4DEKKyphJzSHqUPjL5dbQG/OBxmBnTxI+Pkh8
         h/ZB125sYy7g/aV8noxI5BP6gSCOBQwpkzFck1Ph1uKA2F5GTZYjc+Fc8/IWGkiDXUxI
         CuTAZMqNEAFXkBtMO8AreqZyBGcuSlpBOHzclQE8/W24rDvxTlOV1kKqXS4m7NPYAr+v
         Qjzw==
X-Forwarded-Encrypted: i=1; AJvYcCXHsopThf5Ld7H48kTpkmgF8rBmnTDlXp1TS9pceLYg8gw2n7YW4Q9XMzwj9cuUmg5BB9X0+/2rOu2uxeU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwdHOZL4vy/URaL16MORDKR0OGU7EUYU9QM13qmPy648TcsnF4W
	uSJI3h4zw6xd8sB2yPyQLpaIm8PRbmXaUU/cq58+BJqh6iAEDAjmqsDH
X-Gm-Gg: ASbGncvgRb9vqfxLhwMROFY5Tdieo39C1qtr+Df+UxvZbE5wjBNLxOqQCJOOYV6NA3J
	avuGor/LNey7WoMg5I6d10TRTrxs6XXmMeknWhsjKAM1RONsd0EHayF5EOxfdJPAFBgTFrZcuKq
	KI1WSDRCOiTY2fTT7mQ73bLWXPtWuiSVRE698o1O5qFQJGUNQuKXgFGLItbcTVurARVpIxQmJhX
	kKWES86gVEsco/YCdH5YztAeZXdArG9IRxHG+wPK3jqkxGZnR/Ti+NSD2UNvdHfst8MDogqYCI8
	04UkT6Bl96bKRxwIJZJ4J7vw3ZcOeuqmy27YePIw3tyQFG7vi5u7oTwnJR32SilN4yMp6ApLxdY
	N7aEZI40JMI8g5wGl9pS12hySjPBEm7Frxuw2AgCO0BrzUBNNiM4vwW42CUpcFYndrJZzFvIxnl
	SGtw==
X-Google-Smtp-Source: AGHT+IHgLL5D3yM9RdlZQ1MwTuPoHc0+CT7LUpZzSIOdrIYHqHAGsgDGRtjFBOllHJFbG3YjuM6J7Q==
X-Received: by 2002:a05:6a20:734c:b0:35f:cfb:1ee3 with SMTP id adf61e73a8af0-3614ecc9fd3mr13510474637.25.1764019274844;
        Mon, 24 Nov 2025 13:21:14 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed076eb3sm15702319b3a.1.2025.11.24.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:21:14 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	peter.shen@amd.com,
	colin.huang2@amd.com,
	Peter Shen <sjg168@gmail.com>
Subject: [PATCH v8 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Tue, 25 Nov 2025 05:21:04 +0800
Message-Id: <20251124212106.2068069-1-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Changes in v8:
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
* Added clarification for mixed-case signal names (Andrew Jeffery):
  The mixed-case names (e.g., FM_CPU0_SYS_RESET_N) in gpio-line-names
  are chosen to directly match the signal names used in the hardware 
  schematics.
  This convention is used to maintain strict adherence and clarity when
  cross-referencing between the Device Tree and the board design documents.

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


