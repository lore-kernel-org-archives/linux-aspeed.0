Return-Path: <linux-aspeed+bounces-1352-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD37EC61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 06:14:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHFjg3Mp1z30DL;
	Wed, 11 Jun 2025 16:14:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749622455;
	cv=none; b=n348cMfEzva8uxGyHQlsDIg2ZRYQO7xQOVBUOeUJiBwrS+07OwfRY0EzNyb+uLe5mlfl9hWqAVcdS6WxuyVZKTXTkDQqeD/yAKqJ+rharMpK2Wqs/lkYcbBziBxgknMUWWiLxAlMAn/T8B+WHgODfKdUJLhFZY/frdtJdGDjrwzJTm4A1yqWAKxS7oQHNsF60EdYiDXtQBDtuTvhU1b909DQD8ujilzQKFdztVJrcIDMjocHtVcKiSWSNkl1Gt7Cww8kVGGpFuPgZ+AAQqT2acv/hnPbJcbxk4ZxwnLHRzweF1smtE8dq0fJ4dXJ8maA6dL3+3VP5sKTGbw7CXiFag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749622455; c=relaxed/relaxed;
	bh=rlyv04vogoughQAdjKFOOQI6+Za2bCSuZln2DyzNVIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fvouca6Nf9k+WHsQpjhdm3kQ+7sqb9xfFUVJT631PHqt8Fbqfuk/0jfGIeeOT2VrHxdBT5VfFEWt4r/VfwCfndIwoecFajw8BZR+/Eab9OabkJn+fDMhLqy+0XeoOWgWu+n9AflwymbnJVXU5z860AN5Z4+jgOAPpMDw/1oxCxKRWm1knXvG71Tqymbt8OlGbjTTocm8MuEDXGfpgk4F3ZaE+lWCTjVxdcdHuUig7m4uJmID1VtayFrCbDhzqXo+0n/WUyKQR1M7TN8X6XRiTgXA6zYfwgGIyHvdCHSEUSfVf1RIrIeFjU/+ye6BeQN0VgT14nab3GjLm3YWoDEqJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Vgyy/XW4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Vgyy/XW4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHFjf4fJkz307q
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 16:14:14 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4519dd6523dso408935e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622450; x=1750227250; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlyv04vogoughQAdjKFOOQI6+Za2bCSuZln2DyzNVIw=;
        b=Vgyy/XW4xrkZ4utHLcTNAxUDWmUkMnoLSY/FMZ0tvhJH44JXQdqOnXFxGDAp10gfsH
         7FqryVHx0oCyx5YnvJu1lpQ+9VFwTYGzRuKkOrVZ+dbhnFiG+PRlQe5TAVz1RZ9j20gP
         yi4X+uqKDwPCuDGmREMW8rXgIROcLyfmYVbNz6NmRdFDqQqcJN353m9rEGYeY97/+1d5
         qkzeveIxJvlaKFK3QyhjSbL/ZvooGCQB3RQe9Wa0H5gjrSCxZ2XerJWop/1QNzW8fWhp
         DOwfcUFKmF+NWzBLyThh23e0ITp6L8VwcM0i8HsyQL3iY06ekPIhw86CJxG+029tThN9
         WK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622450; x=1750227250;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlyv04vogoughQAdjKFOOQI6+Za2bCSuZln2DyzNVIw=;
        b=R9zG9wLMwU7CWoqC2bkb1I007RCKBZjkZxTPCLlCs8E7PBNRoxcWO0GqUEjtt3B5kA
         xIhNF88EBJEKNILdcyaa0BtGE5laDBj2ziCeS4lMg7svAEhtw11hhXgp/h1NJ2hJC+xG
         oAq2cE62WCDPeRL96IfvK1Cf/Er7+WjlsuHmJvR8psG0d7ALj1G+CJNHM1igeYlj5vUy
         hmbB6MF6Mf1N/tCTynr4r6kvZG6hDQBi90SxAr5oUqduKeOtRG9QqO6CSgv+4zi7JsBK
         XXQrvkdJJvFQVYgrRUUWpkpB4C0kgsl3Qc9CejFzfQk/e4J75I9ig5tDt1zupqQh/aF/
         LHpA==
X-Forwarded-Encrypted: i=1; AJvYcCXlZi1EEkQcqA2Vjtspb2+b6iGLVXcx9skGVy//MTx8lICipju+jT6cIOGGljqWq1NlwO/XM2h7/kFp290=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzn/qm3lfb78oKh/j4EyhEm1WeVE7Wn2QF60ea3DpWqDD3eKIh4
	TTQ/dkmrpQ7UZvTr93BzqvbYGc0Jlq8IH8azatFoqQzZeC+WRHMTGL9QWFQKtO9ngfc=
X-Gm-Gg: ASbGnctJsuK6vb8pN5q02MsBm2SGsr9PyyZJgVXlYVUyCWRbLrBiJKnj8jCFC+yiRAF
	XrgZQ9Qt+hKIadPvS04TipHreVsh3P3e8+IkqHlfGIRMcdcJwwkCJpRtQtbWJvGl71ODTL2dTms
	R5PuZ7/NWz24fNfuWCL1FtW49hyinENoTohUlrTplCcJM9fhtR/cY4TmFAA7sobfs7/tN6FSDC1
	KdRa2i8brIvmiTQAfqwITuZCE+Nsr/wl3bbslWu15ZUqrALlmKGPmVk2SQ7daTJO20STHUwrUhm
	/sScUMETlvvJIid0+xGyx8GcE9AdqYPkY2gxnFkVNTWVIfkNMlMTB3nrK1S84pYoFzKfXeRqZE8
	co1ru1N8=
X-Google-Smtp-Source: AGHT+IHdRXjfhWjLOdwo/Es6Crc9zuoJuSCwsTyx1a1IJmVOPmaXxFQNpnMjbvHQ6+89WTmnzm3cfA==
X-Received: by 2002:a05:6000:288e:b0:3a5:2dae:970f with SMTP id ffacd0b85a97d-3a558821396mr547717f8f.13.1749622449979;
        Tue, 10 Jun 2025 23:14:09 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm14142791f8f.74.2025.06.10.23.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:14:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/17] pinctrl: Constify pointers to 'pinctrl_desc' and
 more
Date: Wed, 11 Jun 2025 08:13:32 +0200
Message-Id: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAIweSWgC/32NQQqDMBBFryKz7pQYTTWueo/iIsRRBySRiUiLe
 PemHqDL9+C/f0AiYUrQFQcI7Zw4hgz6VoCfXZgIecgMWmmjjG5x5eA3WdDHkDYcKHmsXK2osuR
 daSAPV6GR31f01WeeOW1RPtfHXv7s39xeosLmMZJtWmttbZ4LByfxHmWC/jzPL+k64GC1AAAA
X-Change-ID: 20250528-pinctrl-const-desc-3a40e39eca15
To: Linus Walleij <linus.walleij@linaro.org>, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Vladimir Zapolskiy <vz@mleia.com>, Michal Simek <michal.simek@amd.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4396;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jEd48vl9QSQfzJRNBpRv6p4cKnnNhkUJ4fLA7sMP4dg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoSR6ZNJXNtzDS06LfmSN9fRLSYJEq6TBJKxjlO
 0BdYrKgNxuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEkemQAKCRDBN2bmhouD
 19wvD/49T/2W6MD/HM9DqX8B584NX/5doowuan1+HGbgL34Jkh+d7CgyP1/jT80yenqBpDEMWD3
 Ck/IBEYyVtvu9+lBHSavpcGJimI3dvzrS2eIQEYHrv+Db8ILvy2SuVEHWV/SsYTwrQwOFnMpGvW
 9W/ZSKMpl9m4M9tAVHaDBbkMl+Tb5ncycLl6wFt/FsGS9t5Cx2rco/bWPa2MKncWcM9GcsA+2qs
 8E3IELZ63OxMUKovUR0i6iB6rfsJQdSP4qfVLCrHfQKh1mtC2RtQvtSTeTxCP4gOFwoOkDnqhxT
 15x4Pa3hOLuqGQQ07HCsCypN8/p1cAnUGs43CorB6AvmkX+W6f24hElt4yTdzuSXdIbkCoRJ0Ru
 5lhPuh5vXCcYpuGDSVgWG79t3dEa91VeieYekylNWvWQ2AJVwUWT0FUEI5MFevKXuqYvdRw3CKy
 HWh6koZO844FafrzJBAEBAqai2FBax1mQOSMBRpLINtogb1nAKviRdDOWfjMbThMZYrnQhSDwv5
 UPDEC+1fbQmFThXN6Yqbm40F/AyOypi0XO1oAdDCp5+Yscm14p2nyyP6+iZvOY2DWEROhfLuPMw
 u5/9PfeVRutqtDCyfBbpoQgW2VkWNSctUpZgDM5ju51b2N7iqATLm08lXVHj/020ojBZ33Ew4L+
 uvN7ZKqtl1zf1jQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Add Rb tags
- Patch #1: rephrase commit msg (Geert)
- Patch #2: fix/require dependency on OF
- Link to v1: https://lore.kernel.org/r/20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org

Description:
------------
In several drivers pointers to 'struct pinctrl_desc' is not modified, so
since core does not modify it, it can be made as const.

Dependencies/merging:
---------------------
Patch #4 "pinctrl: Constify pointers to 'pinctrl_desc'" is a
prerequisite for all further patches, including RTC patch, therefore
probably everything should be via main pinctrl tree.

I split several patches, although not all, per SoC-submaintainers, so
reviewing will be easier.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (17):
      pinctrl: starfive: Allow compile testing on other platforms
      pinctrl: Allow compile testing for K210, TB10X and ZYNQ
      pinctrl: amd: Constify pointers to 'pinctrl_desc'
      pinctrl: Constify pointers to 'pinctrl_desc'
      pinctrl: aspeed: Constify static 'pinctrl_desc'
      pinctrl: nuvoton: Constify static 'pinctrl_desc'
      pinctrl: bcm: Constify static 'pinctrl_desc'
      pinctrl: bcm: cygnus-mux: Move fixed assignments to 'pinctrl_desc' definition
      pinctrl: bcm: cygnus-ns2: Move fixed assignments to 'pinctrl_desc' definition
      pinctrl: bcm: cygnus-nsp: Move fixed assignments to 'pinctrl_desc' definition
      pinctrl: as3722: Move fixed assignments to 'pinctrl_desc' definition
      pinctrl: max77620: Move fixed assignments to 'pinctrl_desc' definition
      pinctrl: palmas: Move fixed assignments to 'pinctrl_desc' definition
      pinctrl: renesas: Move fixed assignments to 'pinctrl_desc' definition
      pinctrl: pistachio: Constify static 'pinctrl_desc'
      pinctrl: Constify static 'pinctrl_desc'
      rtc: stm32: Constify static 'pinctrl_desc'

 drivers/pinctrl/Kconfig                            |  9 +++++----
 drivers/pinctrl/Makefile                           |  2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c         |  2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         |  2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c         |  2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            |  2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed.h            |  2 +-
 drivers/pinctrl/bcm/pinctrl-bcm4908.c              |  2 +-
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           |  8 ++++----
 drivers/pinctrl/bcm/pinctrl-ns.c                   |  2 +-
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c              |  8 ++++----
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c              |  8 ++++----
 drivers/pinctrl/berlin/berlin.c                    |  2 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c           |  2 +-
 drivers/pinctrl/core.c                             | 13 +++++++------
 drivers/pinctrl/core.h                             |  2 +-
 drivers/pinctrl/mediatek/pinctrl-airoha.c          |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c          |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |  2 +-
 drivers/pinctrl/pinctrl-amd.c                      |  8 ++++----
 drivers/pinctrl/pinctrl-artpec6.c                  |  2 +-
 drivers/pinctrl/pinctrl-as3722.c                   |  4 ++--
 drivers/pinctrl/pinctrl-bm1880.c                   |  2 +-
 drivers/pinctrl/pinctrl-k210.c                     |  2 +-
 drivers/pinctrl/pinctrl-lpc18xx.c                  |  2 +-
 drivers/pinctrl/pinctrl-max77620.c                 |  9 ++++-----
 drivers/pinctrl/pinctrl-mlxbf3.c                   |  2 +-
 drivers/pinctrl/pinctrl-palmas.c                   |  4 ++--
 drivers/pinctrl/pinctrl-pistachio.c                |  8 ++++----
 drivers/pinctrl/pinctrl-tb10x.c                    |  2 +-
 drivers/pinctrl/pinctrl-zynq.c                     |  2 +-
 drivers/pinctrl/renesas/pinctrl-rzn1.c             |  4 ++--
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |  2 +-
 drivers/rtc/rtc-stm32.c                            |  2 +-
 include/linux/pinctrl/pinctrl.h                    |  8 ++++----
 36 files changed, 70 insertions(+), 69 deletions(-)
---
base-commit: b27cc623e01be9de1580eaa913508b237a7a9673
change-id: 20250528-pinctrl-const-desc-3a40e39eca15

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


