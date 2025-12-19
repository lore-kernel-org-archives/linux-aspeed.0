Return-Path: <linux-aspeed+bounces-3174-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5436AE668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:54:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFW86WqVz2yFY;
	Sat, 20 Dec 2025 17:54:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766135866;
	cv=none; b=jtZFPTBcBje9k/4SLarqJjBFFIbEeJ2igawgkjukkeRpr7ZzHkHSEsP2PDS0yxPE4Qi2WSFuQawmtVUrzSUXrHd2boo4gBpRwo25sEtpHh0UDCNNn6Fvwis/gTp9FbelttIA9RrFm00qjsyJlG5zaXpumDg2qd6y/AyKXiIaGhsK1mfjCbE5RjIV4gc9SsaQlsL/k9j05NLUwnNGaOP6rmQR9vpAlMfDcqdUIaZz8swVqdEQC+Z9JkYPWbnbyfZeeDJderRz2ghbNM/Zdm/2hX2WLK16gVw+38FllhkFqCGNUgFgNhQztTIGdi1Wy6FZk0dkvJhzdN1m79CmASsEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766135866; c=relaxed/relaxed;
	bh=s0wq56S49D0XiqE0opAn2H72dXHptd985ZPMxAa7P8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SxrnHHPT6ZixCAfSKq4Wf4hqWNPzp3Qs3AimX/l5Wc753Sf2bcDf03eGwVOnbkM9TlZKWQ2HNaJE6A9AV8Jmrpgj7H4UhsYwC12gvvgje9EDNrv1CaW+psEpc+RPCe90CKMrm1aCt50O/3dNKP3pBVZtYKhlKvULJlVO1zGWILccrsFAJDGeYqPBlj/dAHhAG7FIe9zqyGETchBRJAkUzJgl5taicbroOIXs0vrmadVFq3419pD9VdWs5z7iV9gIM5nrVIg8ry91q/Nl9TDTTuDFRD2A3PROzT/RXIJG8z11bHwCd3lz77LBJO5J7ZOsKnGoeB55RFs42ou4soDiwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Pc0Hvxe7; dkim-atps=neutral; spf=pass (client-ip=209.85.214.175; helo=mail-pl1-f175.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Pc0Hvxe7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.175; helo=mail-pl1-f175.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXhlD3LRwz2xqm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 20:17:43 +1100 (AEDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a07fac8aa1so16254295ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 01:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766135802; x=1766740602; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0wq56S49D0XiqE0opAn2H72dXHptd985ZPMxAa7P8A=;
        b=Pc0Hvxe7vnd84ThbdATGsHYBv2gxYbQxkk4uLWSwxxx7cf8zZJK38aoaNCSTo2ySd0
         HaVkM1VUACiLRD27n24BUxBwbR1GKMRuBg/JKh0r4lYxtm6iH+e0QSZEKDivk7eMSt1b
         mNETGaDQxFwCnYVCyy9nsji+z/kUSZDWx5jQBCNpFw3bLe545Db1Y4+V7xiBolYrrM54
         UW+VA3RS3/UO4j+Mj+rTiVAWxSrnyyydR6LoreNsSH7Iih7M1b4DvbdQ6ZH4/sNKQWO2
         FCqGQ+Na+Mr81oJwQLfvfSHAtdoQBrnYXrm8cPOs9vVSbXqQZ05hipqumem5tmCzowcs
         aagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135802; x=1766740602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0wq56S49D0XiqE0opAn2H72dXHptd985ZPMxAa7P8A=;
        b=DJJabGFhHrejiReJpIWPo3BOjlT6hxcIozKMI+85fbz3TeNlf0CecoI6cTv37OmJ7W
         zXjBNwr7HNzWwURSDCGPguAjjr93YcruJNzCx/5PZmOpYh4ogetADm9v744pniVy/aeL
         v1zE1xvFVVLoaCOCnaMA3bELWwoA/VUsf5Qd7sCei2cjHW783VozWuMujQjZAXmMNDUP
         iVPmxIEYs8n/AljYmQj7H6LUjxEkMEdBgXqt+RhUKm90e8Co8BK5nzlRxUmN+ufGSRCo
         d1z74KWvnmPy+Qrda7LNTZ4rXs4LPs9ueA4ULaM6jLzIFZ6jU5n3YHVVr8jWBBjF3/jM
         7Nzg==
X-Forwarded-Encrypted: i=1; AJvYcCUUE1OsbY85ZE4wd57liAApt3PQfL03ZalSfJNBmDZtKaXr5d/5lDY/PDMGY8OQ18Zv/dEmx0inRXr22OY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzuMWYV0Opg3DaWgUIdg7zU2nuRtdgQbLjSD7UwOIoCXYO/o/RW
	dLZdIWGSMnBZn+K/b1in/q1BxC4AI2sh/f6J8cO62zBEigr5gC9KHAQEYEWCpw==
X-Gm-Gg: AY/fxX61H5oR6HlbRkTvcLoBqJi0yJTSJdIxP4HdHNvVImvO48IHrHvyCCyyblRR5M1
	8EG1PvMmnpVUH/J3ov4BgGSZXI9z4GZrp+rlbMIooheZ6EPsmWiM1EwgN04kPy6AjgUmYx3vukT
	Vv44jbvCFEZnB/+6Zwgsr1enqHzC91DyqJDsgbMttfSFELwCbDnNbabcgbtio93YOqKnxqtxAgf
	eofKxoFBZm34eFxfvUHw/krlzALQJBtAaHpcAkFwkgQ8xqkJMIUxTccv/aXlwo32hLCfoogcCE4
	C1onz3x8fT1myXEdE/IRDn9hB4ANfYzqNKEXr7nJNX27cCJWYtt2ANCM5CGsknl/FvcGAJU/M4V
	H42YhvNOtEvRi5pcA1hLpvAsIykPF/YnTXfhFOIot5/iShptM1G6vSVqAlSj5ii/RleeU8tQTZQ
	RRjQ==
X-Google-Smtp-Source: AGHT+IExGez/SwIBFURSmY3cs4pQ+FOVzxgn0uQq48pg35PAUqNFrGyru+1LszkjcLfX0eBztZo4og==
X-Received: by 2002:a17:903:4b30:b0:2a0:9fc8:a98b with SMTP id d9443c01a7336-2a2f28375dfmr22211505ad.40.1766135801575;
        Fri, 19 Dec 2025 01:16:41 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm16831515ad.59.2025.12.19.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:16:40 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com,
	colin.huang2@amd.com,
	Peter Shen <sjg168@gmail.com>
Subject: [PATCH v9 0/2] ARM: dts: aspeed: Add Facebook Anacapa platform
Date: Fri, 19 Dec 2025 17:16:30 +0800
Message-Id: <20251219091632.1598603-1-sjg168@gmail.com>
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

The Meta Anacapa BMC is the DC-SCM (Data Center Secure Control
Module) controller for the Meta OCP Open Rack Wide (ORW) compute tray.
This platform is a key component of the AMD Helios AI rack reference
design system, designed for next-generation AI workloads.

The BMC utilizes the Aspeed AST2600 SoC to manage the compute tray, which
contains up to 4 AMD Instinct MI450 Series GPUs (connected via a Broadcom
OCP NIC) and host CPUs. Its primary role is to provide essential system
control, power sequencing, and telemetry reporting for the compute complex
via the OpenBMC software stack.

For more detail on the AMD Helios reference design:
https://www.amd.com/en/blogs/2025/amd-helios-ai-rack-built-on-metas-2025-ocp-design.html

Changes in v9:
  - Describe platform and hardware architecture (Andrew Jeffery).
  - Remove "Device Tree" from patch subjects (Andrew Jeffery).
  - Reconfigured aliases to be sequential (Andrew Jeffery).
  - Alphabetized all DTS label references (Andrew Jeffery).

Changes in v8:
  - Dropped unused 'pcc_memory' reserved memory (Andrew Jeffery).
  - Grouped 'spi-gpio' properties together (Andrew Jeffery).
  - Moved 'pinctrl_ncsi3_default' to aspeed-g6.dtsi (Andrew Jeffery).
  - Revised 'gpio-line-names' to match schematics (Andrew Jeffery).
  - Improved 'sgpio-line-names' formatting.
  - Removed unused 'led-2' definition.
  - Added ADC128D818 sensor support.

Peter Shen (2):
  dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
  ARM: dts: aspeed: Add Facebook Anacapa platform

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-anacapa.dts    | 1045 +++++++++++++++++
 3 files changed, 1047 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts

-- 
2.34.1

