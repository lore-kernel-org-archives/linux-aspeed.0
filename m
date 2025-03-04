Return-Path: <linux-aspeed+bounces-922-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDEAC021B8
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 10:45:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6XPl0F5pz3bkT;
	Tue,  4 Mar 2025 21:44:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741085098;
	cv=none; b=lQzfEGdAqGnuPlgZ0Us88MMH5j9L4PicP1kqfoFe0SZp2Pg5AqEH2Xtuce+Ob/QocYCGZZck6TjAn9UrPohGcON/tIXgG74FGoswHr2HX835e4T0RrC0bG09SMKfNobDQvYO9m48PBFzs5N6QhoAcI1dadAL3HISp8ZKEb5Hs4Y+oVwZll9AhF4sLqNhv1YKEfRa4y2TLpseiYwwGsNUi89i5o/bhV1Bi8HamQCBlG3FOIOO5E8TY3+n3fiK8Zq2IMUowXa1kqq5XlvLij4Zm+eoYNIuTh7iPdGwmomK6a6LQjd3KYuSQd507bRTuDwzO0UXiwV0G/lFMi32N/snXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741085098; c=relaxed/relaxed;
	bh=OtMbr2ZwivTa+QKpyid7/2KnJENNUFDtGx1aofwoiXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GFuF+ugorbY0H5my73EzlnzBRnZSOxLYHnfxz3cYagA9JiCuG3yWaO+PMvaflDV29HaeneTQXauqUrhNbR7LbRLgGHlHmM3csGPonfOM5WSfbBz05/MtOc47lz5p8GVh4aZSS5xFEZo3SYxKetZKRpyY+rSEIK8G4AMyaw/o5TUv84HLWcxY0fLIOUcLFxPWdtCy8YjO1vE5lye98/4tzK2nsBZ75+jgCq4b212gmGxJJcjB64E8BrqM/F5CxHrqHuPBlg66UiYbQ3Wu2n5yx5XG9WOv4uV1dRkrjp2/k58BQjMxU6a6GHeo5s9hPUzQwWjW9f9dqwwjXuiEHfCbgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6XPj69NYz30Vq
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 21:44:55 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 4 Mar
 2025 18:44:38 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Tue, 4 Mar 2025 18:44:38 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: Add AST2600 LPC PCC support
Date: Tue, 4 Mar 2025 18:44:31 +0800
Message-ID: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
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

 The AST2600 has PCC controller in LPC, placed in LPC node. As a result,
 add LPC PCC controller driver to support POST code capture.

--
v2:
  -- Change driver path to drivers/misc

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  36 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/aspeed-lpc-pcc.c                 | 441 ++++++++++++++++++
 5 files changed, 495 insertions(+)
 create mode 100644 drivers/misc/aspeed-lpc-pcc.c

-- 
2.34.1


