Return-Path: <linux-aspeed+bounces-1641-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E23C83F05
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ59751fz2yRn;
	Sun,  6 Jul 2025 14:24:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775853;
	cv=none; b=ZuuaAOmGGfCSnDZm9iO1kKJKmqQuih/8dr+kmPMCL1QYUCd9RxV53AMhPJnU7nldY9ddBxZQ6LFJU/urWuZOnfgc27GZR3E82/68ZaZVacBBiXfR/UDUH6h/K+x2Y1P3eNiw83N0QYu9Mt0+8Clx4v4XNpjnBlFz/EBRYpFqZSuSe234NVrG1lfwLimqxXj5rfboqs/HeVf+ibdKhC8B7DMtoxs6ly6LsN8WhJXLaYrspGwZVy4AWcr113XeY7aBgmcJACWLxpHc00IWP9KkHWOWO2F8C+8Kivz+OmGyDCIOhRVaFaPsviOmGoIxbxH9ZqoYp3fUI0kiQmddD7CQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775853; c=relaxed/relaxed;
	bh=uhSvoJH0XX/OfBAupLeB811heAkQkGDo05cZmoEr3E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEL/S510CAo/IJJhBWnAjVjh4klJEBpkKv933RGgIYlvbAfoBlYo6G2I0/33AswcnH0Vz+evHzsdqol16W7qcGdAuszSKPIc/do8HQcuRxaa8vJwYcGtvGpQ5XNY1zcQ1oNzDRZfVUo4jC2sp9q4PTUDjURYUIcgud/k7gNEz3ZZi5wXjE9vdUAzsnnpq2H1EEO8Lq21fhP7viYy6h3Z8mgTW9m3KndHkn0oKOx4cu10Iqtbt+aDOeXHp4uv4yFNQZ/k0x1LSManOqtp2pZBKveNuBfNysQg/j9vVH4yAYpnlJp7PxIEvATILqLx+S8sWP7/vzxdT7kHBrMm/EqxxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ffoL9Dvj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ffoL9Dvj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ586F1nz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:11 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-748fe69a7baso1846919b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775849; x=1752380649; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhSvoJH0XX/OfBAupLeB811heAkQkGDo05cZmoEr3E4=;
        b=ffoL9Dvjy+uLFtbfA5Qbl1IaCCtT7FWaKi/S2r9EAfj1mn+L+75aiYXgwbn3Ygf4YB
         K0U9JONfv9IfX3ndyb4HBKko6Sq7kX36LD9ZXZluUwR2NoqXctM80qwb/UXW/KgLtOI9
         sPh2ld5XHzMmpyoylcZhvmo6I8LKlvqasfCm5O4ssuDUGZQaANe2ENR18kyvKmhsZxrv
         uIJZ2VnoWner5ieL9hI2bsn5Q4Z85BLi1wgs9j6L4uzjmo1vsRyyFPyLj2xZRsaL+w6d
         FV/lar/41VD6bgrQ1HDtznMskuveAANp7aegaSZXYJJxMrQY5xvvuSOIenlvGxjimQ9H
         JH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775849; x=1752380649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhSvoJH0XX/OfBAupLeB811heAkQkGDo05cZmoEr3E4=;
        b=rKGL2gmZWyF8K5bhgY8enMlQcyedkGuxrA4AUpRMiKqcZw2pPtXr0ACGWtREK/KE6W
         x3IWkfwYSHHiX2Y3dq43EEZem5PgO3sgFP1IeDI2qrGdBk9ksqATBIiYUse5fkKSJrE2
         +aznzTvC/wE2IejKwFky7WyPeW69iJerBkLDYhgUVSGJnSOChfFJlRCONY69b8R6nttx
         zp8n8jVqTnH+r2kFrqTT79NGuPAy5xm58+qnzHR/Ohr5gQaXzl9W8S+gxuNZ3DQXZo0+
         KPeHugr7/ZE/xxRb75vSu1vaJ8eCf8R5eTQCjzIlxSiys21OY79DnSkXZTCX/2U3GzVy
         ZBIA==
X-Forwarded-Encrypted: i=1; AJvYcCVjQ1E1LC7fKRLJXoX8ePtiU5fVjsJbHfhso92YjVaJ1Dr58N9WXX6ngOY4Bjn7K0zapRVwtqMR7Sf9l1E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylaUX4NzpTweG15v6OaayMd8c8WmJ5k7i3Vjjm1DBiOfmJaL67
	9wft5o2y6MzMfXfeMj9XCf2wb/0DAtf2+Bz7Qjh6F8nLLOKE68jgHYto
X-Gm-Gg: ASbGncsGOR53Nni3HlwvVlWLQcqlOkuBUkepekGnO9/48VPkq43ZKBFvPi15TktTaTO
	QtGqDMbvAhqfGBEouigZwMJvSV80FXIJ6oyOySm259BdgJZMwXeWcM++L4Nh+/zS79hgkhayszV
	M7Fn6fVfgTx8YLD2RDYNLrMIFoBhuQusuNCwS77XvGHgFA8X9KE2T+ggX/ol6R10Xt013g+MOwT
	9yz16OJ99SBjYy0UIjA3We/4kiiE+FGJW0dwagDpqrS7az3WUTtExDq0kmh3NP9MiKOq9QsKaVl
	rEk72+k86M+Lt65qwLx1U8gosCIRxxRZMg2Xvejqvf2FrEa3bfcPT0/WFors2YTowvSWsKOLa8v
	DjwtcE+rTYHpae2GOfCXR92SIwgq7Ow80eZMgZcU=
X-Google-Smtp-Source: AGHT+IGtzwJ3JG9jDZq93UShLC20pA1tuJ1i6r+Xx5nA8auWyQabjh+hUgo+LzZaEIr56LDORbmPzw==
X-Received: by 2002:a05:6a00:2315:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-74cf6fb8a8emr6019500b3a.19.1751775849273;
        Sat, 05 Jul 2025 21:24:09 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:08 -0700 (PDT)
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
Subject: [PATCH v2 0/9] ARM: dts: aspeed: Add Meta Darwin dts
Date: Sat,  5 Jul 2025 21:23:50 -0700
Message-ID: <20250706042404.138128-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Patches #4, #5 and #6 introduces a new BMC flash layout to be used by
wedge400 and fuji (and later more Meta Network BMC platforms).

Patch #7 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
each BMC platform because eMMC was removed from future Meta Network BMC
platforms.

Patches #8 and #9 adds Meta Darwin BMC and updates devicetree bindings.

Tao Ren (9):
  ARM: dts: aspeed: wedge400: Fix DTB warnings
  ARM: dts: aspeed: fuji: Fix DTB warnings
  ARM: dts: aspeed: Fix DTB warnings in
    ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
  ARM: dts: aspeed: wedge400: Extend data0 partition to 64MB
  ARM: dts: aspeed: Move flash layout out of Facebook netbmc-common.dtsi
  ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
  dt-bindings: arm: aspeed: add Facebook Darwin board
  ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |  1 +
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 78 +++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-elbert.dts | 18 +++++
 .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 24 ++++--
 .../aspeed/aspeed-bmc-facebook-wedge400.dts   |  8 +-
 .../ast2600-facebook-netbmc-common.dtsi       | 24 ++----
 .../facebook-bmc-flash-layout-128-data64.dtsi | 60 ++++++++++++++
 8 files changed, 187 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

-- 
2.47.1


