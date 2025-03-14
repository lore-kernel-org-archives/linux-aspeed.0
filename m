Return-Path: <linux-aspeed+bounces-988-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73C8C282EC
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 11:21:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDhlJ4S0Vz2yYq;
	Fri, 14 Mar 2025 22:21:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741951292;
	cv=none; b=dnRHj/RxhjfPQQwcDp0ql9nxFYgisVC6hpw1Sg5uXuAup6wEzxueTfeGN2Bpm2P5Ef2jHXyF14COEkd2lTORHHXuacaeC7Hlb3L4pbNP4K7g67wSgde0it46sv+Vvo1/9vABEWLA/lgWaRcFaLDwY9bfLcD/ZJ6k8rxJF3fy+hDtk19BWmXhKj4BiLRRrUAI19q/ZlZBZQiMAMKSkYEhZvxg0eV3mtEiRb7DI5XbrXQaUschCCqEcVHJyDo19ryPvo2Gq+fE/MfFZ5Sque5Jzv7uVLOJx2TXDZMNxoi+y04tPdPRGjXHvXiPvo1mKA4CXdjJHXdxFhGTBDqWK/4RMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741951292; c=relaxed/relaxed;
	bh=8w/NMnluLso4auUJlPLHvGrwv8C1kQ2MGdbvhxTHnEI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFzjAy/rxQ+awu5vKvmQklaD8KmeN3Qu0uf9nrOBoBy/msx6vjrMb6C+pRJ3PQJXnxTnmUaGsCwqViTztnCy01zP5bb+IamcLwTdxvIp8CO+dirmhycRvPoYj7AJED56piUim8HjI7xtFwYsJY2rUN7AVh9XZIJNpmBeiXHlF31egLUF6oKqn6dt2jFUo7NOmlhJ8UsB8XyZ6M9XFji+0CfsQ+3FsHeI09lg+4sRBFTrID4UmyCjuv7ZZpEypsqZwi7HS16Wnmefw9oFXoQB+WsWzCmb2OKInuo8pvtIbbpabSOf7k23ZbXmBnUeorEYazu77Q+VzTPXhj4vw5PdFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDhlH6C5vz2xmk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Mar 2025 22:21:31 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 14 Mar
 2025 19:21:14 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Fri, 14 Mar 2025 19:21:14 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v4 0/3] Add AST2600 LPC PCC support
Date: Fri, 14 Mar 2025 19:21:10 +0800
Message-ID: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

--
v4
aspeed-lpc-pcc.c:
 -- Remove the debug message in the aspeed_lpc_pcc_probe.
 -- Add pcc-ports in the aspeed-g6.dtsi.

v3
aspeed-lpc-pcc.c:
 -- Add ida_free and fix the dev usage with removing some debug messages.
aspeed-lpc.yaml:
 -- Add description about the pcc-ports usage.

v2:
 -- Change driver path to drivers/misc

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  38 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   8 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/aspeed-lpc-pcc.c                 | 437 ++++++++++++++++++
 5 files changed, 494 insertions(+)
 create mode 100644 drivers/misc/aspeed-lpc-pcc.c

-- 
2.34.1


