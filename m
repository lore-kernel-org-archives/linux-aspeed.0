Return-Path: <linux-aspeed+bounces-372-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C96E77199
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 20:17:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSzjp19ksz30Tr;
	Thu,  9 Jan 2025 07:17:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736367454;
	cv=none; b=jfKdKsQA5rInNC3zIbcLTIZ/UptGA8JdW46xRTleVkTc0unlK9I9CU0SO8l5j8IopTN9+EBkyM7TYLt4HF8cOl7wKyyjPlae38ubwvI/xfWBddWGUxcV5WlORYOCUb/vduEO+85nbXj6gQUSwJI3ny9dwOtWviM6AkUu82vdHkb/SpEmXL3jEIJOErCuM0Edv/iS32GIWI1YtOmqkDZfezY+74sSG6VpruW++6ZCJNRP0G3Kyz3rQZFmwo/OpT1P1r8CTIYT0QdcoRA2DNa863chCoLoRHybTWDonvpdhD7IZkdQAS2YJJPMiKoCFUYCDpjGzmN+q8Se0ofdVGQYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736367454; c=relaxed/relaxed;
	bh=b+Hjf7gL0CKGudF4dN19V3/6KMwWFZmCJ+Cv2U2rfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1aLez+JlGSxi4Dlk8o4z3a3JQaHVmQuTcalbFkr99KDKBmHn9if0tNzRdP6kpJG73aXC0+HOKjI1aznOaFTozB1yETtWry8bZdtAz9vEV1RabEzv2yqmxYNfjdLKiZh5J6r58U3cd1A0f5EEbQAN2KLtF7lz4UpTXpgciTGTzHhGhXhI1WDct5NEJKSx4qHmiYKdl2HIJaSLiBlOv9lxPR82FPY/ICqay45OiLhjGinohyyIsC2FpZhtpqKb20uKpuVdfGt2CE1BsesDoPbO73akYbkmYage03E5pM3nnTwKHdQvxNaIK6mbpge2/tcOFDOc7WcpZd/WbuDG7Qr0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=yHWYY4bS; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=yHWYY4bS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSzjn12q1z30Tc
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 07:17:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b+Hjf7gL0CKGudF4dN19V3/6KMwWFZmCJ+Cv2U2rfsQ=; b=yHWYY4bSalT2gL8z3UpH+ZLEi/
	wai17khUMCEbltTA0kvnb6fXjBq5v+YSRMg3YfdC7cEKYCdzJmBUPQykCFJpd8z5RWjq2Aaafejzj
	yjoezsV6OMjJpgvGAYR7f7eLqXjF1Sw9KJQS0mizDmRURjHYiKh0ClvjbCq2KSaa/i3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVcUR-002g0l-Eh; Wed, 08 Jan 2025 21:17:19 +0100
Date: Wed, 8 Jan 2025 21:17:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <769c47ce-3183-4730-8702-ec85245e66df@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <bebbba7b-f86e-4dc4-8253-65d34cb84804@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebbba7b-f86e-4dc4-8253-65d34cb84804@linux.ibm.com>

> I checked with out hardware team and they did not add any extra delay on the
> board.
> 
> We have normal point to point clock without any delay added by line.

Thanks for checking. Thus phy-mode must be "rgmii-id". We now need to
fix the MAC driver so it does the correct thing when passed that.

    Andrew

