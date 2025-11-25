Return-Path: <linux-aspeed+bounces-2998-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F50D0EE18
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Nov 2025 23:50:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGKFN1qfgz2yrT;
	Wed, 26 Nov 2025 10:50:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764114632;
	cv=none; b=F2myuOQQbtN0ZPFX6ygJA5NhSRPV35qGlP1M4cWaMF6DasFLSng9ZpjtHhV4x31slbmtBPTY5glyvUjxmxYOCT9Fd7fsiKT+6Jg5vC+az2rQSnQeW+3bclmggbN35kj+WWQFsv4Uj09SOOSw6B3k2KD8b8GSOMSXLIbfaVyW9mQO5H6infE1yy0BEtdKsPbRH8x1IRLVUzq4RGYOZBc/lGd9jpn7IpP5UidHtdsmQUOCVJ4NpIsYeyTgU7ReVHrpZKvg25HRzJMQNLYaGleGpUwvI64uyMMK5cNNlw0TesEPD+w5PzVdWJGh+4/lGMWmQCWU6wvct/kxEj0jzzJMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764114632; c=relaxed/relaxed;
	bh=v5DEfi++1C8bftapZgqYGj62YjX3kAgMlduZ/oN7pZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY1QlWhwsf1imulN87/kMqSj2oi0f7OOGCfxkdXRSedOQH7vZW7p6uAdZsKHDqP2/2sxIy2R/LA7hyWtmK89vTlTNewEF399eOyz/wosp0IahNpuFzS3g6X9TiFZi4xoHhjKEols4BO0CDHQ0vvWKacJTn+hJ/2Ri50/MDs7Qz3gGWfqgtrPqLgoHOJ8+DxvsoMslZmybLb+RYMtZEhZFLk/GRO95QH0UGkw13bINsxR0o2EsZX3E433XLSW7XcKTxGp4urRycMX/0fSYoLJcn7bE/NblTrLbrGPICJb9NdzWyrlZrIYoZa8Y/Zn2UJAgs13Q1tp1aVOPUe9hZ4lIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LO3hDRES; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LO3hDRES;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGKFK69Gvz2yr9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 10:50:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v5DEfi++1C8bftapZgqYGj62YjX3kAgMlduZ/oN7pZ4=; b=LO3hDRESQrCbqmtAAAldsvnpKS
	oB2F7027X8GPBxEB5HXMPoON3NcEYL7a8m2rDjC7OwKAo/00pFXnIDPIjPxmqs5ll1LfYHhbI/qjM
	IA+xdcVV7tSrOsqWvX5SghR1oYbfrvFQ29wKqPMGjjYPJMdXtiacYOjEXDcmOP7PGVKA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vO2nF-00F5Jm-3I; Wed, 26 Nov 2025 00:49:57 +0100
Date: Wed, 26 Nov 2025 00:49:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>

> I try to summary in the following informations that I understand.
> 
> 1. with rx-internal-delay-ps OR tx-internal-delay-ps OR both
> 
>   Use "rx/tx-internal-delay-ps" property to configure RGMII delay at MAC side
>   Pass "phy-mode" to PHY driver by calling of_phy_get_and_connect()

Yes, since they are new properties, you can assume the phy-mode is
correct for these delays. We just need to watch out for DT developers
setting these delays to 2000ps and 'rgmii', which would be against the
guidelines.


> 2. withour rx-internal-delay-ps AND tx-internal-delay-ps
> 
>   If "phy-mode" is 'rgmii-rxid' or 'rgmii-txid':
> 	Keep original delay
> 	Print Warning message
> 	  "Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> 
> There are FOUR conditions in delay configuration:
> 'X' means RGMII delay setting from bootloader
> A: 7500 <= X <= 8000, 0 <= X <= 500
> B: 500 < X < 1500
> C: 1500 <= X <= 2500
> 	Mean "Enable RGMII delay" at MAC side
> D: 2500 < X < 7500
> 
>   If "phy-mode" is 'rgmii':
> 	Condition A:
> 		Keep original delay
> 		Update "phy-mode" to 'rgmii-id'
> 		Print Information message
> 			"Forced 'phy-mode' to rgmii-id"

So 0 <= X <= 500 is a small tuning value, so yes, is correct.

> 	Condition B and D
> 		Keep original delay
> 		Print Warning message
> 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"

Yes.

> 	Condition C:
> 		Disable RGMII delay at MAC side
> 		Update "phy-mode" to 'rgmii-id'
> 		Print Warning message
> 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"

'rx/tx-internal-delay-ps are probably not required in this case, the
2ns from the PHY is probably sufficient.

> 
>   If "phy-mode" is 'rgmii-id':
> 	Condition A:
> 		Keep original delay
> 		Keep "phy-mode" to 'rgmii-id'
> 	Condition B and D
> 		Keep original delay
> 		Print Warning message
> 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> 	Condition C:
> 		Disable RGMII delay at MAC side
> 		Update "phy-mode" to 'rgmii-id'
> 		Print Warning message
> 	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
> 

These look correct.

How many different boards do you have you can test with? Do you only
have access to RDKs? Or do you have a test farm of customer boards for
regression testing. I would throw the patchset at as many boards as
you can to make sure there are no regressions.
 
> Because the driver may need to update the "phy-mode" of dts, it need to add
> CONFIG_OF_DYNAMIC in ftgma100 of Kconfig.

I don't think you need this. At least, i would not patch the DT blob.

You are only fixing 2600. 2700 will be correct from day 1. You don't
need any of this code for the 2700. The 2500 also does not need any of
this, from what i have seen of the 2500. I've not looked at 2400, but
i also assume none of this is needed there.

The current ftgmac100_probe() is very complex. So i would pull it
apart into helpers. It looks like the ncsi is generic across all
versions. So that can be put into a helper. I would then probably have
helpers for 2400/2500, 2600, and sometime in the future 2700. In the
2600, i would look at replacing the of_phy_get_and_connect() with a
call to of_get_phy_mode() and of_phy_connect(), changing the interface
value passed to of_phy_connect() as needed.

	Andrew

