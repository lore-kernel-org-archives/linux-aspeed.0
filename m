Return-Path: <linux-aspeed+bounces-2902-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52612CDB480
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 03:39:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d72vS04Pdz2ySq;
	Fri, 14 Nov 2025 14:39:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763091587;
	cv=none; b=KEK+GRe1EVML4OkMJbLY2NFJI8iDsz9jqQxngou8zeUOfMzwHM5Y/C3Q+yxi1Rjsho10PMtjtyWk6C3mOn2w4zsXxs3JKYWedVE8e4TgDh8fVc2PfEEwzYb7W8Vss+j7vIBS6BAZ0MJk7zX+HLScB64xQ7VDLPvimEW6idpjR0lfVEAabi+0TDuuW5FiwZfo4CJJCeiAn9Rp1Ib/cqejz74dgUYFCktWidfbQN9M5c7PswWPxpD85uTNOgbwHlCfhDD4JLhiI3AgnAN6iUuKF1ghTSpVKb3bzeIvKxtjG+6mGsRjqPlsA0U3UW+dsGGTZFHEajv4muNsGnHf544cPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763091587; c=relaxed/relaxed;
	bh=n7Wa5zv6kJms6DiLqqXPzKVowzYle1GvZ5G3rdIqE/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JAPtgerbH72Q7pL1aRDgmCqege1rMCSmD4CiFcn28Dex3CPwynvDMKaHqsfngasczCTjz27pq3Nr4D/HxG97CFLUwZCguqANfpXKWkoG920xEPKIvI1izBivdFJSpD+BWw2Baf8JO6gn2BWgg/RrtvpiT/mV+2L7yNiaPSBiNAJCByBnbdTdW8m31ih7YEw3cuGl2R9CPJD7EwoE7OCv0QDOOKWG84PWNQxcwwaT1TgSCdaoJukDIPHkr2/txkMIibBSCqWq5uy3CYd2gigPYjJXBtT8kyzN89+CxuHpsTTQ+bJObWhA8TDvVOZ29nMw6Fvkfvkohgt820m+fHQMSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=G7YEiJQ/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=G7YEiJQ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d72vR36dMz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 14:39:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763091585;
	bh=n7Wa5zv6kJms6DiLqqXPzKVowzYle1GvZ5G3rdIqE/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=G7YEiJQ/nxh6zWkZGsKi3M65JA1ugHSdZF+jmP5H0v4cN2bIrF3lkDgJhefkRuRtZ
	 UoMGsHHBNydzEo07wb+HD8z+eObQllZZngvB6J/SAX9eMk26dBocMqPGSLL7/J4a2q
	 CMzlTPqPSHnMgM3MevKx9yTqVLp0OAi65gj8Yn243xBowKCbx6LuJ1bbEJ9XMWgxtd
	 Jbod5EFnS4u7ZgBBBXA5nhIf0XBr7YmDNKZQvEzyTDU3NkB82OolpnYLXfKk8BWqV+
	 dYGrIvy1yX7VIDEIPY9CW9KxdhmqoKh/acHgEvJzNub9rpK0aBSpL8FOnPYMOE95tD
	 6v56rZV7xlryw==
Received: from [127.0.1.1] (unknown [180.150.112.244])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CF0CB783DF;
	Fri, 14 Nov 2025 11:39:44 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Leo Wang <leo.jt.wang@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com
In-Reply-To: <20251021-leo-dts-add-nvme-eeprom-v1-1-33166b3665b4@gmail.com>
References: <20251021-leo-dts-add-nvme-eeprom-v1-1-33166b3665b4@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: Add EEPROMs for boot and
 data drive FRUs
Message-Id: <176309158432.894995.1068506101584521049.b4-ty@codeconstruct.com.au>
Date: Fri, 14 Nov 2025 14:09:44 +1030
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
X-Mailer: b4 0.14.3

On Tue, 21 Oct 2025 11:15:39 +0800, Leo Wang wrote:
> Add EEPROM devices on the I2C buses used for the boot and data NVMe
> drives. These EEPROMs store FRU information for each drive, allowing
> the BMC to identify.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


