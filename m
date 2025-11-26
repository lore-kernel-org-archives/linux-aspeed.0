Return-Path: <linux-aspeed+bounces-2999-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497BED1038F
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Nov 2025 08:26:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGXj54jDLz2ynP;
	Wed, 26 Nov 2025 19:26:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764145609;
	cv=none; b=iBYAsz4EVknYXtVxItS/HOVFmR043j3cKBAx5wNDkCeuQnYlUKsE6ocBxo3hGzkEd11JB+VEkK0f1X6fwpGxEa48wayXMewK03B9S6vL/mzCtdvIRbxc3rsXn/ofotsnCRVlBt8UVJAkQtotQEFLivkdX2QdHQhKxjrGfKJOEkThtXjeJM6+sUbDR4yiRzpkUrxW1du9sY5TfcwRGg0TcHo3T70FTKvPrk3N9tU9ASp3XSR4fIHM76nH1L+/HZ257JsO4FZ7CoKR2ftOEOhq3SQDommxKPkJzNQLQdmrTXGCbqS7zanzaBVdO0JUUw0oGIc0o04o4cjUKBDJeKVKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764145609; c=relaxed/relaxed;
	bh=+vJ8EaE+nu0lIUJABRQHfDnIDkTZEuMj0mTHD0scIYU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=mynjvzWPtX51rPquaZHgxjfBGcgg2KabbmVyF3a/W7Z9boGUleblcv0W7x8RqleFnAZkIXf6RT1o0YvzYmu/uSei8U25RNuM/hgZYwHwbz6lPfW0vY41o30CGr1bqLRjAhdBL/aUeHXUlD2wCUYFqFKNlDaswXvBFxpN2J5w+3WkqF5gaMxrqllCZE1LJa0CP/wz5t/Mhxmyb9HTwTr6Jtt8I8NZ4mo/FD1XC/X2d0PFhjNQbBkwQQp9UqVko85N2arwZWQzoz86qr552M4BQvP3mZrQ+DfcXsgY+j4IFL+w4pSR6Jt8NTR4gr73HJ8UoFNXzeGgyI8Lyhbc27JAfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGXj44fxhz2xPy
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 19:26:47 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 26 Nov
 2025 16:26:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 26 Nov 2025 16:26:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/2] Add AST2700 support for Aspeed vhub
Date: Wed, 26 Nov 2025 16:26:29 +0800
Message-ID: <20251126-upstream_vhub-v1-0-910709937ee0@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIALW5JmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyNT3dKC4pKi1MTc+LKM0iRd41QjAxML40QTU9NUJaCegqLUtMwKsHn
 RsbW1AJvgbwNfAAAA
X-Change-ID: 20251125-upstream_vhub-3e20483a455e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764145590; l=793;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=7cC5jeCkWsYO33bINv8Y064Z31IpWkHiFJYzubZI4AA=;
 b=vEIO1LfVfQsPoR4eEKhpTG48ZIF//W0qo8MEjrlqB1chhzuwEI/NdKsBkFpT4MhOn0WevIT6E
 yUvLUm5ZfSiAy8uqh+Uh6cFFrNf8ODVkst3oLi1RJDHX9pHr0D+kZPu
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add Aspeed vhub support for AST2700.
The AST2700 vhub requires a reset and uses 64-bit DMA.
This series updates the binding and driver to support these two
requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Ryan Chen (2):
      dt-bindings: usb: aspeed,usb-vhub: Add ast2700 support
      usb: gadget: aspeed-vhub: Add ast2700 support

 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   | 14 ++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/core.c          | 30 ++++++++++++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |  1 +
 3 files changed, 45 insertions(+)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251125-upstream_vhub-3e20483a455e

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


