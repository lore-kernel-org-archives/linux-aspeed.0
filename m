Return-Path: <linux-aspeed+bounces-4072-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30272CD4F4A
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 14:02:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJzyc5wsmz2y7Y;
	Tue, 19 May 2026 00:02:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779112952;
	cv=none; b=LaHVVPrnmWdwAmgZ7QQWxzkEOvJVWBMKTkrbpBJv3YwEexsPL8rIAOEdhyESOYjnL5/zVFWPFha2Hdqr+rD0hDgMB+NUBOzIvlwsatDumssrckZvyrw8P50q6IZUAFIeceHhys76/FfJS/O4pqS7guUyHxElbJbpl4+34GQjaQ4nYBRmnXDf7Pg/dhAQ0JMWgi0+zcSNHZHb41DAwybtemHsnsRG72MERM5QOnm0KmNpv19iVe0X3uJHYf84wd4H5CD8qfQUr3ic7Ycv9F5wEJq4OeEPDfDSLkv5/2selanwPfYeZR6yb/9fyIIjoY8bN64tSCnQGWxRfkqP4GS3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779112952; c=relaxed/relaxed;
	bh=Nefc8G0NeaGyb3UUQULb64nwG2lmumgk5OzS0zMOeq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BV6RP5EUtRT4PfvrfoN2+CrdDDXPHTOqsgEPGrnS/hUv4ek/bkabKMlRA6e87qvHGAWdWHcQoPZ/6+KhB3KdMluNgWQMUmtXuvBOqk2+DgR0/QJfZ/St1QcO8QZNUEU1mJ8SYIiFRL77OZCSP07a1GwsEcpLLHT9vJx3W4ACe9EEyQTVVOfBKvbDXfX4cf7Vx/8cPPSZPxKwoV9oh5dxeB3o8Ze7IJtr4gXVOAYOkZSsrsPsEM7Qsgwac8TEaNuk/6Voae9fNcdq3i23Cl611OQbgR7MCKIfRxrv04SDbXpMwi54YvO9lfLLPZkYu/YtJzNRFLAbmkhtbpr0nX6PvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZWaKw0M8; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZWaKw0M8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJzyc0CW6z2xrC
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 00:02:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779112950;
	bh=Nefc8G0NeaGyb3UUQULb64nwG2lmumgk5OzS0zMOeq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZWaKw0M8IW1TXPTTsI7HUNxZSISrzmkTLNJukBj40iCHyHYVdd7+OD4OIFEAzJgQi
	 M4izzl9RdIWTpSNmXU2HIRyJZd9Tyu84ONGnmB2jZrtlDPM8X/qVWbG53+dI95fvli
	 F/wol8eBioyTpGdWye8EYvva64DQiZ8sDiPMJnJpYNjJjYoCJ5N6DGKvMk5pdqGFnX
	 NL5uUDbP5H5UsdOhO1/QcgQsV2Ew5gbqu+DwFmOmmHJHjVZTEWjwJbW+RgLsylZkhy
	 EIFOVJag9WLUG0gekQ1k0RySJRIiGSKsEWFmHatrcdej7DIKRUByRex+pZfSQV9b2i
	 M35kL3oTaPnlQ==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7BCC56025D;
	Mon, 18 May 2026 22:02:29 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <20260323-sanmiguel_init_dts-v4-0-caaa48a7f7be@gmail.com>
References: <20260323-sanmiguel_init_dts-v4-0-caaa48a7f7be@gmail.com>
Subject: Re: [PATCH v4 0/2] Add Meta (Facebook) SanMiguel BMC (AST2620)
Message-Id: <177911294941.2210651.9798336892963650465.b4-ty@b4>
Date: Mon, 18 May 2026 23:32:29 +0930
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
X-Mailer: b4 0.15.2

On Mon, 23 Mar 2026 20:41:04 +0800, Potin Lai wrote:
> Add Linux device tree entries for Meta (Facebook) SanMiguel specific
> devices connected to the AST2620 BMC SoC.

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


